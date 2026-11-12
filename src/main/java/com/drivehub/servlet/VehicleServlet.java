package com.drivehub.servlet;

import com.drivehub.dao.FileUtil;
import com.drivehub.dao.VehicleDAO;
import com.drivehub.model.CarVehicle;
import com.drivehub.model.VanCommercialVehicle;
import com.drivehub.model.Vehicle;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller Servlet for Member 01: Vehicle Fleet Management.
 */
@WebServlet(name = "VehicleServlet", urlPatterns = {"/vehicles", "/VehicleServlet"})
public class VehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VehicleDAO vehicleDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        String realPath = getServletContext().getRealPath("/WEB-INF/data");
        if (realPath != null) {
            FileUtil.setDataDirectory(realPath);
        }
        vehicleDAO = new VehicleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "list";
        }

        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteVehicle(request, response);
                break;
            case "manage":
                listManageFleet(request, response);
                break;
            case "search":
            case "list":
            default:
                listVehicles(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("insert".equalsIgnoreCase(action)) {
            insertVehicle(request, response);
        } else if ("update".equalsIgnoreCase(action)) {
            updateVehicle(request, response);
        } else {
            response.sendRedirect("vehicles?action=list");
        }
    }

    private void listVehicles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String transmission = request.getParameter("transmission");

        List<Vehicle> list = vehicleDAO.searchVehicles(keyword, category, transmission);
        request.setAttribute("vehicleList", list);
        request.setAttribute("searchKeyword", keyword != null ? keyword : "");
        request.setAttribute("selectedCategory", category != null ? category : "ALL");
        request.setAttribute("selectedTransmission", transmission != null ? transmission : "ALL");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/fleet.jsp");
        dispatcher.forward(request, response);
    }

    private void listManageFleet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vehicle> list = vehicleDAO.getAllVehicles();
        request.setAttribute("vehicleList", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/manage-fleet.jsp");
        dispatcher.forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nextId = vehicleDAO.generateNextVehicleId();
        request.setAttribute("nextId", nextId);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/add-vehicle.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Vehicle existing = vehicleDAO.getVehicleById(id);
        if (existing != null) {
            request.setAttribute("vehicle", existing);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/edit-vehicle.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("vehicles?action=manage&error=VehicleNotFound");
        }
    }

    private void insertVehicle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String vehicleId = request.getParameter("vehicleId");
            String makeModel = request.getParameter("makeModel");
            String category = request.getParameter("category");
            double dailyRate = Double.parseDouble(request.getParameter("dailyRate"));
            String fuelType = request.getParameter("fuelType");
            String transmission = request.getParameter("transmission");
            int seats = Integer.parseInt(request.getParameter("seatingCapacity"));
            String imageUrl = request.getParameter("imageUrl");
            boolean available = request.getParameter("available") != null;

            Vehicle newVehicle;
            if ("LUXURY_CAR".equalsIgnoreCase(category)) {
                boolean autopilot = request.getParameter("hasAutopilot") != null;
                int trunk = Integer.parseInt(request.getParameter("trunkCapacityLitres"));
                double deposit = Double.parseDouble(request.getParameter("securityDeposit"));
                newVehicle = new CarVehicle(vehicleId, makeModel, dailyRate, fuelType, transmission,
                        seats, imageUrl, autopilot, trunk, deposit, available);
            } else {
                int payload = Integer.parseInt(request.getParameter("cargoPayloadKg"));
                double permit = Double.parseDouble(request.getParameter("commercialPermitFee"));
                int towing = Integer.parseInt(request.getParameter("towingCapacityKg"));
                newVehicle = new VanCommercialVehicle(vehicleId, makeModel, dailyRate, fuelType, transmission,
                        seats, imageUrl, payload, permit, towing, available);
            }

            boolean success = vehicleDAO.addVehicle(newVehicle);
            if (success) {
                response.sendRedirect("vehicles?action=manage&msg=VehicleAddedSuccessfully");
            } else {
                response.sendRedirect("vehicles?action=add&error=DuplicateVehicleOrSaveFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("vehicles?action=add&error=" + e.getMessage());
        }
    }

    private void updateVehicle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String vehicleId = request.getParameter("vehicleId");
            String makeModel = request.getParameter("makeModel");
            String category = request.getParameter("category");
            double dailyRate = Double.parseDouble(request.getParameter("dailyRate"));
            String fuelType = request.getParameter("fuelType");
            String transmission = request.getParameter("transmission");
            int seats = Integer.parseInt(request.getParameter("seatingCapacity"));
            String imageUrl = request.getParameter("imageUrl");
            boolean available = request.getParameter("available") != null;

            Vehicle updated;
            if ("LUXURY_CAR".equalsIgnoreCase(category)) {
                boolean autopilot = request.getParameter("hasAutopilot") != null;
                int trunk = Integer.parseInt(request.getParameter("trunkCapacityLitres"));
                double deposit = Double.parseDouble(request.getParameter("securityDeposit"));
                updated = new CarVehicle(vehicleId, makeModel, dailyRate, fuelType, transmission,
                        seats, imageUrl, autopilot, trunk, deposit, available);
            } else {
                int payload = Integer.parseInt(request.getParameter("cargoPayloadKg"));
                double permit = Double.parseDouble(request.getParameter("commercialPermitFee"));
                int towing = Integer.parseInt(request.getParameter("towingCapacityKg"));
                updated = new VanCommercialVehicle(vehicleId, makeModel, dailyRate, fuelType, transmission,
                        seats, imageUrl, payload, permit, towing, available);
            }

            boolean success = vehicleDAO.updateVehicle(updated);
            if (success) {
                response.sendRedirect("vehicles?action=manage&msg=VehicleUpdatedSuccessfully");
            } else {
                response.sendRedirect("vehicles?action=edit&id=" + vehicleId + "&error=UpdateFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("vehicles?action=manage&error=" + e.getMessage());
        }
    }

    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String id = request.getParameter("id");
        boolean success = vehicleDAO.deleteVehicle(id);
        if (success) {
            response.sendRedirect("vehicles?action=manage&msg=VehicleDecommissionedSuccessfully");
        } else {
            response.sendRedirect("vehicles?action=manage&error=DeleteFailed");
        }
    }
}
