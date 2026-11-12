package com.drivehub.servlet;

import com.drivehub.dao.FileUtil;
import com.drivehub.dao.RentalDAO;
import com.drivehub.dao.VehicleDAO;
import com.drivehub.model.ChauffeurDrivenReservation;
import com.drivehub.model.RentalReservation;
import com.drivehub.model.SelfDriveReservation;
import com.drivehub.model.Vehicle;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Controller Servlet for Member 02: Rental Booking & Customer Reservation Management.
 */
@WebServlet(name = "RentalServlet", urlPatterns = {"/rentals", "/RentalServlet"})
public class RentalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RentalDAO rentalDAO;
    private VehicleDAO vehicleDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        String realPath = getServletContext().getRealPath("/WEB-INF/data");
        if (realPath != null) {
            FileUtil.setDataDirectory(realPath);
        }
        rentalDAO = new RentalDAO();
        vehicleDAO = new VehicleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "track";
        }

        switch (action) {
            case "book":
                showBookingForm(request, response);
                break;
            case "manage":
                listAllRentals(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "cancel":
                cancelReservation(request, response);
                break;
            case "delete":
                deleteReservation(request, response);
                break;
            case "track":
            default:
                trackReservation(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("create".equalsIgnoreCase(action)) {
            createReservation(request, response);
        } else if ("update".equalsIgnoreCase(action)) {
            updateReservation(request, response);
        } else if ("updateStatus".equalsIgnoreCase(action)) {
            updateStatus(request, response);
        } else {
            response.sendRedirect("rentals?action=track");
        }
    }

    private void showBookingForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vehicleId = request.getParameter("vehicleId");
        List<Vehicle> all = vehicleDAO.getAllVehicles();
        request.setAttribute("vehicleList", all);
        request.setAttribute("selectedVehicleId", vehicleId);
        request.setAttribute("nextReservationId", rentalDAO.generateNextReservationId());

        RequestDispatcher dispatcher = request.getRequestDispatcher("/book-vehicle.jsp");
        dispatcher.forward(request, response);
    }

    private void listAllRentals(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<RentalReservation> list = rentalDAO.getAllReservations();
        request.setAttribute("rentalList", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/manage-rentals.jsp");
        dispatcher.forward(request, response);
    }

    private void trackReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        List<RentalReservation> found = new ArrayList<>();

        if (query != null && !query.trim().isEmpty()) {
            query = query.trim();
            RentalReservation byId = rentalDAO.getReservationById(query);
            if (byId != null) {
                found.add(byId);
            } else {
                found.addAll(rentalDAO.searchReservations(query));
            }
            request.setAttribute("searchPerformed", true);
            request.setAttribute("query", query);
        }

        request.setAttribute("foundRentals", found);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/rental-track.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        RentalReservation r = rentalDAO.getReservationById(id);
        if (r != null) {
            request.setAttribute("rental", r);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/edit-rental.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("rentals?action=manage&error=ReservationNotFound");
        }
    }

    private void createReservation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String reservationId = request.getParameter("reservationId");
            String vehicleId = request.getParameter("vehicleId");
            String name = request.getParameter("customerName");
            String email = request.getParameter("customerEmail");
            String phone = request.getParameter("customerPhone");
            String pickupDate = request.getParameter("pickupDate");
            String returnDate = request.getParameter("returnDate");
            int days = Integer.parseInt(request.getParameter("rentalDays"));
            String type = request.getParameter("rentalType");

            Vehicle v = vehicleDAO.getVehicleById(vehicleId);
            double dailyRate = (v != null) ? v.calculateDailyRentalRate() : 100.00;

            RentalReservation newReservation;
            if ("CHAUFFEUR".equalsIgnoreCase(type)) {
                String location = request.getParameter("pickupLocation");
                double driverFee = Double.parseDouble(request.getParameter("driverDailyFee"));
                String notes = request.getParameter("tripItineraryNotes");
                ChauffeurDrivenReservation cdr = new ChauffeurDrivenReservation(reservationId, vehicleId, name,
                        email, phone, pickupDate, returnDate, days, location, driverFee, notes, "CONFIRMED", 0.0);
                cdr.setTotalAmount(cdr.calculateTotalBill(dailyRate));
                newReservation = cdr;
            } else {
                String license = request.getParameter("driverLicenseNumber");
                String mileage = request.getParameter("mileagePackage");
                String insurance = request.getParameter("insuranceTier");
                SelfDriveReservation sdr = new SelfDriveReservation(reservationId, vehicleId, name,
                        email, phone, pickupDate, returnDate, days, license, mileage, insurance, "CONFIRMED", 0.0);
                sdr.setTotalAmount(sdr.calculateTotalBill(dailyRate));
                newReservation = sdr;
            }

            boolean success = rentalDAO.addReservation(newReservation);
            if (success) {
                response.sendRedirect("rentals?action=track&query=" + reservationId + "&msg=ReservationConfirmedSuccessfully");
            } else {
                response.sendRedirect("rentals?action=book&error=FailedToCreateReservation");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("rentals?action=book&error=" + e.getMessage());
        }
    }

    private void updateReservation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String id = request.getParameter("reservationId");
            RentalReservation r = rentalDAO.getReservationById(id);
            if (r == null) {
                response.sendRedirect("rentals?action=manage&error=ReservationNotFound");
                return;
            }

            r.setCustomerName(request.getParameter("customerName"));
            r.setCustomerEmail(request.getParameter("customerEmail"));
            r.setCustomerPhone(request.getParameter("customerPhone"));
            r.setPickupDate(request.getParameter("pickupDate"));
            r.setReturnDate(request.getParameter("returnDate"));
            r.setRentalDays(Integer.parseInt(request.getParameter("rentalDays")));

            if (r instanceof SelfDriveReservation) {
                SelfDriveReservation sdr = (SelfDriveReservation) r;
                sdr.setDriverLicenseNumber(request.getParameter("driverLicenseNumber"));
                sdr.setMileagePackage(request.getParameter("mileagePackage"));
                sdr.setInsuranceTier(request.getParameter("insuranceTier"));
            } else if (r instanceof ChauffeurDrivenReservation) {
                ChauffeurDrivenReservation cdr = (ChauffeurDrivenReservation) r;
                cdr.setPickupLocation(request.getParameter("pickupLocation"));
                cdr.setDriverDailyFee(Double.parseDouble(request.getParameter("driverDailyFee")));
                cdr.setTripItineraryNotes(request.getParameter("tripItineraryNotes"));
            }

            Vehicle v = vehicleDAO.getVehicleById(r.getVehicleId());
            double dailyRate = (v != null) ? v.calculateDailyRentalRate() : 100.00;
            r.setTotalAmount(r.calculateTotalBill(dailyRate));

            boolean success = rentalDAO.updateReservation(r);
            if (success) {
                response.sendRedirect("rentals?action=manage&msg=ReservationUpdatedSuccessfully");
            } else {
                response.sendRedirect("rentals?action=edit&id=" + id + "&error=UpdateFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("rentals?action=manage&error=" + e.getMessage());
        }
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String id = request.getParameter("reservationId");
        String newStatus = request.getParameter("newStatus");
        boolean success = rentalDAO.updateReservationStatus(id, newStatus);
        if (success) {
            response.sendRedirect("rentals?action=manage&msg=StatusUpdatedTo" + newStatus);
        } else {
            response.sendRedirect("rentals?action=manage&error=StatusUpdateFailed");
        }
    }

    private void cancelReservation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String id = request.getParameter("id");
        boolean success = rentalDAO.cancelReservation(id);
        if (success) {
            response.sendRedirect("rentals?action=track&query=" + id + "&msg=RentalCancelledSuccessfully");
        } else {
            response.sendRedirect("rentals?action=track&query=" + id + "&error=CannotCancelReservation");
        }
    }

    private void deleteReservation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String id = request.getParameter("id");
        boolean success = rentalDAO.deleteReservationPermanently(id);
        if (success) {
            response.sendRedirect("rentals?action=manage&msg=ReservationArchivedPermanently");
        } else {
            response.sendRedirect("rentals?action=manage&error=DeleteFailed");
        }
    }
}
