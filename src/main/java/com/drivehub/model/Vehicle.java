package com.drivehub.model;

/**
 * Abstract base class representing a Rental Vehicle in the fleet.
 * Demonstrates:
 * - Abstraction (defines abstract calculation and specification methods)
 * - Encapsulation (private fields with domain validation)
 */
public abstract class Vehicle {
    private String vehicleId;
    private String makeModel;
    private String category; // "LUXURY_CAR" or "COMMERCIAL_VAN"
    private double dailyRate;
    private String fuelType;
    private String transmission;
    private int seatingCapacity;
    private String imageUrl;
    private boolean available;

    public Vehicle() {
    }

    public Vehicle(String vehicleId, String makeModel, String category, double dailyRate,
                   String fuelType, String transmission, int seatingCapacity,
                   String imageUrl, boolean available) {
        this.vehicleId = vehicleId;
        this.makeModel = makeModel;
        this.category = category;
        setDailyRate(dailyRate);
        this.fuelType = fuelType;
        this.transmission = transmission;
        setSeatingCapacity(seatingCapacity);
        this.imageUrl = (imageUrl != null && !imageUrl.trim().isEmpty())
                ? imageUrl.trim()
                : "https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800";
        this.available = available;
    }

    // Abstract methods demonstrating Abstraction & Polymorphism
    public abstract double calculateDailyRentalRate();
    public abstract String getVehicleSpecs();
    public abstract String toCSVString();

    // Getters and Setters (Encapsulation with validation)
    public String getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(String vehicleId) {
        if (vehicleId == null || vehicleId.trim().isEmpty()) {
            throw new IllegalArgumentException("Vehicle ID cannot be empty.");
        }
        this.vehicleId = vehicleId.trim();
    }

    public String getMakeModel() {
        return makeModel;
    }

    public void setMakeModel(String makeModel) {
        if (makeModel == null || makeModel.trim().isEmpty()) {
            throw new IllegalArgumentException("Make and model cannot be empty.");
        }
        this.makeModel = makeModel.trim();
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getDailyRate() {
        return dailyRate;
    }

    public void setDailyRate(double dailyRate) {
        if (dailyRate < 0) {
            throw new IllegalArgumentException("Daily rate cannot be negative.");
        }
        this.dailyRate = dailyRate;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public String getTransmission() {
        return transmission;
    }

    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }

    public int getSeatingCapacity() {
        return seatingCapacity;
    }

    public void setSeatingCapacity(int seatingCapacity) {
        if (seatingCapacity < 1) {
            throw new IllegalArgumentException("Seating capacity must be at least 1.");
        }
        this.seatingCapacity = seatingCapacity;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }
}
