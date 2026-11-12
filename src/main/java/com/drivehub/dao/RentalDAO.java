package com.drivehub.dao;

import com.drivehub.model.ChauffeurDrivenReservation;
import com.drivehub.model.RentalReservation;
import com.drivehub.model.SelfDriveReservation;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for Rental Reservations.
 * Satisfies Member 02's 30-mark CRUD operations on rentals.txt.
 */
public class RentalDAO {
    private static final String FILE_NAME = "rentals.txt";

    /**
     * CREATE: Book a new vehicle reservation
     */
    public boolean addReservation(RentalReservation r) {
        if (r == null || r.getReservationId() == null) {
            return false;
        }
        if (getReservationById(r.getReservationId()) != null) {
            return false;
        }
        try {
            FileUtil.appendLine(FILE_NAME, r.toCSVString());
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * READ: Retrieve all reservations
     */
    public List<RentalReservation> getAllReservations() {
        List<RentalReservation> list = new ArrayList<>();
        try {
            List<String> lines = FileUtil.readAllLines(FILE_NAME);
            for (String line : lines) {
                RentalReservation r = parseCSVLine(line);
                if (r != null) {
                    list.add(r);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * READ: Search reservation by ID
     */
    public RentalReservation getReservationById(String id) {
        if (id == null) return null;
        for (RentalReservation r : getAllReservations()) {
            if (r.getReservationId().equalsIgnoreCase(id.trim())) {
                return r;
            }
        }
        return null;
    }

    /**
     * READ: Search reservations by customer email or phone
     */
    public List<RentalReservation> searchReservations(String query) {
        List<RentalReservation> results = new ArrayList<>();
        if (query == null || query.trim().isEmpty()) {
            return results;
        }
        String q = query.trim().toLowerCase();
        for (RentalReservation r : getAllReservations()) {
            if (r.getReservationId().toLowerCase().contains(q)
                    || r.getCustomerEmail().toLowerCase().contains(q)
                    || r.getCustomerPhone().contains(q)
                    || r.getCustomerName().toLowerCase().contains(q)) {
                results.add(r);
            }
        }
        return results;
    }

    /**
     * UPDATE: Modify full reservation details
     */
    public boolean updateReservation(RentalReservation updated) {
        if (updated == null || updated.getReservationId() == null) {
            return false;
        }
        List<RentalReservation> all = getAllReservations();
        boolean found = false;
        List<String> lines = new ArrayList<>();

        for (RentalReservation r : all) {
            if (r.getReservationId().equalsIgnoreCase(updated.getReservationId())) {
                lines.add(updated.toCSVString());
                found = true;
            } else {
                lines.add(r.toCSVString());
            }
        }

        if (found) {
            try {
                FileUtil.writeAllLines(FILE_NAME, lines);
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    /**
     * UPDATE: Change reservation status (e.g., CONFIRMED -> ACTIVE -> RETURNED)
     */
    public boolean updateReservationStatus(String reservationId, String newStatus) {
        RentalReservation r = getReservationById(reservationId);
        if (r != null) {
            r.setStatus(newStatus);
            return updateReservation(r);
        }
        return false;
    }

    /**
     * DELETE / CANCEL: Mark status as CANCELLED
     */
    public boolean cancelReservation(String reservationId) {
        RentalReservation r = getReservationById(reservationId);
        if (r != null && r.canBeCancelled()) {
            r.setStatus("CANCELLED");
            return updateReservation(r);
        }
        return false;
    }

    /**
     * DELETE: Permanently remove a reservation record
     */
    public boolean deleteReservationPermanently(String reservationId) {
        if (reservationId == null) return false;
        List<RentalReservation> all = getAllReservations();
        boolean found = false;
        List<String> lines = new ArrayList<>();

        for (RentalReservation r : all) {
            if (r.getReservationId().equalsIgnoreCase(reservationId.trim())) {
                found = true;
            } else {
                lines.add(r.toCSVString());
            }
        }

        if (found) {
            try {
                FileUtil.writeAllLines(FILE_NAME, lines);
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    /**
     * Auto-generate next reservation ID
     */
    public String generateNextReservationId() {
        int max = 5000;
        for (RentalReservation r : getAllReservations()) {
            if (r.getReservationId().startsWith("RNT")) {
                try {
                    int num = Integer.parseInt(r.getReservationId().substring(3));
                    if (num > max) max = num;
                } catch (NumberFormatException ignored) {}
            }
        }
        return "RNT" + (max + 1);
    }

    private RentalReservation parseCSVLine(String line) {
        try {
            String[] parts = line.split(",", -1);
            if (parts.length < 13) return null;

            String reservationId = parts[0].trim();
            String vehicleId = parts[1].trim();
            String name = parts[2].trim();
            String email = parts[3].trim();
            String phone = parts[4].trim();
            String pickupDate = parts[5].trim();
            String returnDate = parts[6].trim();
            int days = Integer.parseInt(parts[7].trim());
            String type = parts[8].trim();

            if ("SELF_DRIVE".equalsIgnoreCase(type)) {
                String license = parts[9].trim();
                String mileage = parts[10].trim();
                String insurance = parts[11].trim();
                String status = parts[12].trim();
                double total = Double.parseDouble(parts[13].trim());
                return new SelfDriveReservation(reservationId, vehicleId, name, email, phone,
                        pickupDate, returnDate, days, license, mileage, insurance, status, total);
            } else {
                String location = parts[9].trim();
                double driverFee = Double.parseDouble(parts[10].trim());
                String itinerary = parts[11].trim();
                String status = parts[12].trim();
                double total = (parts.length > 13) ? Double.parseDouble(parts[13].trim()) : 0.0;
                return new ChauffeurDrivenReservation(reservationId, vehicleId, name, email, phone,
                        pickupDate, returnDate, days, location, driverFee, itinerary, status, total);
            }
        } catch (Exception e) {
            System.err.println("Error parsing rental CSV: " + line + " -> " + e.getMessage());
            return null;
        }
    }
}
