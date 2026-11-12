package com.drivehub.model;

/**
 * Concrete class representing sedans, sports cars, and luxury SUVs.
 * Demonstrates:
 * - Inheritance (extends Vehicle)
 * - Polymorphism (overrides calculateDailyRentalRate() with autopilot/luxury packages)
 */
public class CarVehicle extends Vehicle {
    private boolean hasAutopilot;
    private int trunkCapacityLitres;
    private double securityDeposit;

    public CarVehicle() {
        super();
        setCategory("LUXURY_CAR");
    }

    public CarVehicle(String vehicleId, String makeModel, double dailyRate, String fuelType,
                      String transmission, int seatingCapacity, String imageUrl,
                      boolean hasAutopilot, int trunkCapacityLitres, double securityDeposit,
                      boolean available) {
        super(vehicleId, makeModel, "LUXURY_CAR", dailyRate, fuelType, transmission, seatingCapacity, imageUrl, available);
        this.hasAutopilot = hasAutopilot;
        this.trunkCapacityLitres = trunkCapacityLitres;
        this.securityDeposit = securityDeposit;
    }

    // Polymorphism: Daily rate includes high-tech AI autopilot and luxury performance surcharge
    @Override
    public double calculateDailyRentalRate() {
        double techSurcharge = hasAutopilot ? 5000.00 : 0.00;
        return getDailyRate() + techSurcharge;
    }

    @Override
    public String getVehicleSpecs() {
        return (hasAutopilot ? "Autopilot / Driver Assist | " : "Manual Drive | ") +
               "Boot Space: " + trunkCapacityLitres + "L | Deposit: LKR " + String.format("%,.2f", securityDeposit);
    }

    @Override
    public String toCSVString() {
        // Format: vehicleId,makeModel,category,dailyRate,fuelType,transmission,seats,imageUrl,autopilot,trunk,deposit,available
        return String.join(",",
                getVehicleId(),
                getMakeModel().replace(",", " "),
                getCategory(),
                String.format("%.2f", getDailyRate()),
                getFuelType(),
                getTransmission(),
                String.valueOf(getSeatingCapacity()),
                getImageUrl(),
                String.valueOf(hasAutopilot),
                String.valueOf(trunkCapacityLitres),
                String.format("%.2f", securityDeposit),
                String.valueOf(isAvailable())
        );
    }

    public boolean isHasAutopilot() {
        return hasAutopilot;
    }

    public void setHasAutopilot(boolean hasAutopilot) {
        this.hasAutopilot = hasAutopilot;
    }

    public int getTrunkCapacityLitres() {
        return trunkCapacityLitres;
    }

    public void setTrunkCapacityLitres(int trunkCapacityLitres) {
        this.trunkCapacityLitres = trunkCapacityLitres;
    }

    public double getSecurityDeposit() {
        return securityDeposit;
    }

    public void setSecurityDeposit(double securityDeposit) {
        this.securityDeposit = securityDeposit;
    }
}
