package com.drivehub.model;

/**
 * Abstract superclass representing a Vehicle Rental Reservation.
 * Demonstrates:
 * - Abstraction (defines abstract billing and summary methods)
 * - Encapsulation (validated customer contact and booking dates)
 */
public abstract class RentalReservation {
    private String reservationId;
    private String vehicleId;
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String pickupDate;
    private String returnDate;
    private int rentalDays;
    private String rentalType; // "SELF_DRIVE" or "CHAUFFEUR"
    private String status; // "PENDING", "CONFIRMED", "ACTIVE", "RETURNED", "CANCELLED"
    private double totalAmount;

    public RentalReservation() {
    }

    public RentalReservation(String reservationId, String vehicleId, String customerName,
                             String customerEmail, String customerPhone, String pickupDate,
                             String returnDate, int rentalDays, String rentalType,
                             String status, double totalAmount) {
        this.reservationId = reservationId;
        this.vehicleId = vehicleId;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        setCustomerPhone(customerPhone);
        this.pickupDate = pickupDate;
        this.returnDate = returnDate;
        setRentalDays(rentalDays);
        this.rentalType = rentalType;
        this.status = (status != null && !status.isEmpty()) ? status : "PENDING";
        this.totalAmount = totalAmount;
    }

    // Abstract methods demonstrating Abstraction & Polymorphism
    public abstract double calculateTotalBill(double vehicleDailyRate);
    public abstract String getRentalSummary();
    public abstract String toCSVString();

    // Cancellation business rule: Allowed only if PENDING or CONFIRMED
    public boolean canBeCancelled() {
        return "PENDING".equalsIgnoreCase(status) || "CONFIRMED".equalsIgnoreCase(status);
    }

    // Getters and Setters
    public String getReservationId() {
        return reservationId;
    }

    public void setReservationId(String reservationId) {
        this.reservationId = reservationId;
    }

    public String getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(String vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        if (customerPhone == null || customerPhone.trim().isEmpty()) {
            throw new IllegalArgumentException("Phone number cannot be empty.");
        }
        this.customerPhone = customerPhone.trim();
    }

    public String getPickupDate() {
        return pickupDate;
    }

    public void setPickupDate(String pickupDate) {
        this.pickupDate = pickupDate;
    }

    public String getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(String returnDate) {
        this.returnDate = returnDate;
    }

    public int getRentalDays() {
        return rentalDays;
    }

    public void setRentalDays(int rentalDays) {
        if (rentalDays < 1) {
            throw new IllegalArgumentException("Rental duration must be at least 1 day.");
        }
        this.rentalDays = rentalDays;
    }

    public String getRentalType() {
        return rentalType;
    }

    public void setRentalType(String rentalType) {
        this.rentalType = rentalType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
}
