package com.drivehub.model;

/**
 * Concrete class representing self-drive car rentals with insurance and mileage plans.
 * Demonstrates:
 * - Inheritance (extends RentalReservation)
 * - Polymorphism (overrides calculateTotalBill() with long-term rental discounts and insurance fees)
 */
public class SelfDriveReservation extends RentalReservation {
    private String driverLicenseNumber;
    private String mileagePackage; // "Unlimited Mileage" or "Standard 250km/day"
    private String insuranceTier;  // "Basic Collision Waiver", "Comprehensive Premium", "Zero Liability"

    public SelfDriveReservation() {
        super();
        setRentalType("SELF_DRIVE");
    }

    public SelfDriveReservation(String reservationId, String vehicleId, String customerName,
                                String customerEmail, String customerPhone, String pickupDate,
                                String returnDate, int rentalDays, String driverLicenseNumber,
                                String mileagePackage, String insuranceTier,
                                String status, double totalAmount) {
        super(reservationId, vehicleId, customerName, customerEmail, customerPhone,
                pickupDate, returnDate, rentalDays, "SELF_DRIVE", status, totalAmount);
        this.driverLicenseNumber = driverLicenseNumber;
        this.mileagePackage = mileagePackage;
        this.insuranceTier = insuranceTier;
    }

    // Polymorphism: Calculates daily rate, adds insurance tier fee, and awards 15% long-term discount for >= 7 days
    @Override
    public double calculateTotalBill(double vehicleDailyRate) {
        double subtotal = vehicleDailyRate * getRentalDays();
        
        // Insurance Tier Fee in LKR
        double insuranceDailyFee = 3500.00;
        if ("Zero Liability".equalsIgnoreCase(insuranceTier)) {
            insuranceDailyFee = 9500.00;
        } else if ("Comprehensive Premium".equalsIgnoreCase(insuranceTier)) {
            insuranceDailyFee = 6000.00;
        }
        subtotal += (insuranceDailyFee * getRentalDays());

        // Long-term discount for rentals of a week or longer
        if (getRentalDays() >= 7) {
            subtotal = subtotal * 0.85; // 15% discount
        }

        return subtotal;
    }

    @Override
    public String getRentalSummary() {
        return "Self-Drive Rental (" + getRentalDays() + " Days) | License: " + driverLicenseNumber + 
               " | Insurance: " + insuranceTier + " (" + mileagePackage + ")";
    }

    @Override
    public String toCSVString() {
        // Format: reservationId,vehicleId,customerName,customerEmail,customerPhone,pickupDate,returnDate,rentalDays,rentalType,license,mileage,insurance,status,totalAmount
        return String.join(",",
                getReservationId(),
                getVehicleId(),
                getCustomerName().replace(",", " "),
                getCustomerEmail(),
                getCustomerPhone(),
                getPickupDate(),
                getReturnDate(),
                String.valueOf(getRentalDays()),
                getRentalType(),
                driverLicenseNumber != null ? driverLicenseNumber : "DL-PENDING",
                mileagePackage != null ? mileagePackage.replace(",", " ") : "Standard 250km/day",
                insuranceTier != null ? insuranceTier.replace(",", " ") : "Basic Collision Waiver",
                getStatus(),
                String.format("%.2f", getTotalAmount())
        );
    }

    public String getDriverLicenseNumber() {
        return driverLicenseNumber;
    }

    public void setDriverLicenseNumber(String driverLicenseNumber) {
        this.driverLicenseNumber = driverLicenseNumber;
    }

    public String getMileagePackage() {
        return mileagePackage;
    }

    public void setMileagePackage(String mileagePackage) {
        this.mileagePackage = mileagePackage;
    }

    public String getInsuranceTier() {
        return insuranceTier;
    }

    public void setInsuranceTier(String insuranceTier) {
        this.insuranceTier = insuranceTier;
    }
}
