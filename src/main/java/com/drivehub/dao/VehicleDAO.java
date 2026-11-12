package com.drivehub.dao;

import com.drivehub.model.CarVehicle;
import com.drivehub.model.VanCommercialVehicle;
import com.drivehub.model.Vehicle;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for Fleet Vehicles.
 * Satisfies Member 01's 30-mark CRUD operations on vehicles.txt.
 */
public class VehicleDAO {
    private static final String FILE_NAME = "vehicles.txt";

    /**
     * CREATE: Add a new vehicle to vehicles.txt
     */
    public boolean addVehicle(Vehicle v) {
        if (v == null || v.getVehicleId() == null) {
            return false;
        }
        if (getVehicleById(v.getVehicleId()) != null) {
            return false;
        }
        try {
            FileUtil.appendLine(FILE_NAME, v.toCSVString());
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * READ: Retrieve all vehicles
     */
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> list = new ArrayList<>();
        try {
            List<String> lines = FileUtil.readAllLines(FILE_NAME);
            for (String line : lines) {
                Vehicle v = parseCSVLine(line);
                if (v != null) {
                    list.add(v);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * READ: Search vehicle by ID
     */
    public Vehicle getVehicleById(String id) {
        if (id == null) return null;
        for (Vehicle v : getAllVehicles()) {
            if (v.getVehicleId().equalsIgnoreCase(id.trim())) {
                return v;
            }
        }
        return null;
    }

    /**
     * READ: Filter vehicles by keyword, category, and transmission
     */
    public List<Vehicle> searchVehicles(String keyword, String category, String transmission) {
        List<Vehicle> results = new ArrayList<>();
        for (Vehicle v : getAllVehicles()) {
            boolean matchesCat = (category == null || category.isEmpty() || "ALL".equalsIgnoreCase(category)
                    || v.getCategory().equalsIgnoreCase(category));
            boolean matchesTrans = (transmission == null || transmission.isEmpty() || "ALL".equalsIgnoreCase(transmission)
                    || v.getTransmission().equalsIgnoreCase(transmission));
            boolean matchesWord = (keyword == null || keyword.isEmpty()
                    || v.getMakeModel().toLowerCase().contains(keyword.toLowerCase())
                    || v.getVehicleId().toLowerCase().contains(keyword.toLowerCase()));

            if (matchesCat && matchesTrans && matchesWord) {
                results.add(v);
            }
        }
        return results;
    }

    /**
     * UPDATE: Modify an existing vehicle's record
     */
    public boolean updateVehicle(Vehicle updated) {
        if (updated == null || updated.getVehicleId() == null) {
            return false;
        }
        List<Vehicle> all = getAllVehicles();
        boolean found = false;
        List<String> lines = new ArrayList<>();

        for (Vehicle v : all) {
            if (v.getVehicleId().equalsIgnoreCase(updated.getVehicleId())) {
                lines.add(updated.toCSVString());
                found = true;
            } else {
                lines.add(v.toCSVString());
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
     * DELETE: Remove vehicle by ID
     */
    public boolean deleteVehicle(String id) {
        if (id == null) return false;
        List<Vehicle> all = getAllVehicles();
        boolean found = false;
        List<String> lines = new ArrayList<>();

        for (Vehicle v : all) {
            if (v.getVehicleId().equalsIgnoreCase(id.trim())) {
                found = true;
            } else {
                lines.add(v.toCSVString());
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
     * Auto-generate next vehicle ID
     */
    public String generateNextVehicleId() {
        int max = 100;
        for (Vehicle v : getAllVehicles()) {
            if (v.getVehicleId().startsWith("VEH")) {
                try {
                    int num = Integer.parseInt(v.getVehicleId().substring(3));
                    if (num > max) max = num;
                } catch (NumberFormatException ignored) {}
            }
        }
        return String.format("VEH%03d", max + 1);
    }

    private Vehicle parseCSVLine(String line) {
        try {
            String[] parts = line.split(",", -1);
            if (parts.length < 12) return null;

            String vehicleId = parts[0].trim();
            String makeModel = parts[1].trim();
            String category = parts[2].trim();
            double dailyRate = Double.parseDouble(parts[3].trim());
            String fuelType = parts[4].trim();
            String transmission = parts[5].trim();
            int seatingCapacity = Integer.parseInt(parts[6].trim());
            String imageUrl = parts[7].trim();

            if ("LUXURY_CAR".equalsIgnoreCase(category)) {
                boolean autopilot = Boolean.parseBoolean(parts[8].trim());
                int trunk = Integer.parseInt(parts[9].trim());
                double deposit = Double.parseDouble(parts[10].trim());
                boolean available = Boolean.parseBoolean(parts[11].trim());
                return new CarVehicle(vehicleId, makeModel, dailyRate, fuelType, transmission,
                        seatingCapacity, imageUrl, autopilot, trunk, deposit, available);
            } else {
                int payload = Integer.parseInt(parts[8].trim());
                double permitFee = Double.parseDouble(parts[9].trim());
                int towing = Integer.parseInt(parts[10].trim());
                boolean available = Boolean.parseBoolean(parts[11].trim());
                return new VanCommercialVehicle(vehicleId, makeModel, dailyRate, fuelType, transmission,
                        seatingCapacity, imageUrl, payload, permitFee, towing, available);
            }
        } catch (Exception e) {
            System.err.println("Error parsing vehicle line: " + line + " -> " + e.getMessage());
            return null;
        }
    }
}
