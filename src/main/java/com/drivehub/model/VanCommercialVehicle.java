package com.drivehub.model;

/**
 * Concrete class representing multi-passenger minivans and commercial cargo transports.
 * Demonstrates:
 * - Inheritance (extends Vehicle)
 * - Polymorphism (overrides calculateDailyRentalRate() with commercial payload & permit tariffs)
 */
public class VanCommercialVehicle extends Vehicle {
    private int cargoPayloadKg;
    private double commercialPermitFee;
    private int towingCapacityKg;

    public VanCommercialVehicle() {
        super();
        setCategory("COMMERCIAL_VAN");
    }

    public VanCommercialVehicle(String vehicleId, String makeModel, double dailyRate, String fuelType,
                                String transmission, int seatingCapacity, String imageUrl,
                                int cargoPayloadKg, double commercialPermitFee, int towingCapacityKg,
                                boolean available) {
        super(vehicleId, makeModel, "COMMERCIAL_VAN", dailyRate, fuelType, transmission, seatingCapacity, imageUrl, available);
        this.cargoPayloadKg = cargoPayloadKg;
        this.commercialPermitFee = commercialPermitFee;
        this.towingCapacityKg = towingCapacityKg;
    }

    // Polymorphism: Commercial rate factors in road logistics permits and heavy load wear surcharge
    @Override
    public double calculateDailyRentalRate() {
        double payloadSurcharge = (cargoPayloadKg > 1500) ? 4500.00 : 0.00;
        return getDailyRate() + commercialPermitFee + payloadSurcharge;
    }

    @Override
    public String getVehicleSpecs() {
        return "Max Payload: " + cargoPayloadKg + "kg | Towing: " + towingCapacityKg + 
               "kg | Commercial Permit: LKR " + String.format("%,.2f", commercialPermitFee);
    }

    @Override
    public String toCSVString() {
        // Format: vehicleId,makeModel,category,dailyRate,fuelType,transmission,seats,imageUrl,payload,permit,towing,available
        return String.join(",",
                getVehicleId(),
                getMakeModel().replace(",", " "),
                getCategory(),
                String.format("%.2f", getDailyRate()),
                getFuelType(),
                getTransmission(),
                String.valueOf(getSeatingCapacity()),
                getImageUrl(),
                String.valueOf(cargoPayloadKg),
                String.format("%.2f", commercialPermitFee),
                String.valueOf(towingCapacityKg),
                String.valueOf(isAvailable())
        );
    }

    public int getCargoPayloadKg() {
        return cargoPayloadKg;
    }

    public void setCargoPayloadKg(int cargoPayloadKg) {
        this.cargoPayloadKg = cargoPayloadKg;
    }

    public double getCommercialPermitFee() {
        return commercialPermitFee;
    }

    public void setCommercialPermitFee(double commercialPermitFee) {
        this.commercialPermitFee = commercialPermitFee;
    }

    public int getTowingCapacityKg() {
        return towingCapacityKg;
    }

    public void setTowingCapacityKg(int towingCapacityKg) {
        this.towingCapacityKg = towingCapacityKg;
    }
}
