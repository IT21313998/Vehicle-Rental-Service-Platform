package com.drivehub.model;

/**
 * Concrete class representing chauffeur-driven executive and VIP car rentals.
 * Demonstrates:
 * - Inheritance (extends RentalReservation)
 * - Polymorphism (overrides calculateTotalBill() with certified chauffeur tariffs and airport meet-and-greets)
 */
public class ChauffeurDrivenReservation extends RentalReservation {
    private String pickupLocation;
    private double driverDailyFee;
    private String tripItineraryNotes;

    public ChauffeurDrivenReservation() {
        super();
        setRentalType("CHAUFFEUR");
    }

    public ChauffeurDrivenReservation(String reservationId, String vehicleId, String customerName,
                                      String customerEmail, String customerPhone, String pickupDate,
                                      String returnDate, int rentalDays, String pickupLocation,
                                      double driverDailyFee, String tripItineraryNotes,
                                      String status, double totalAmount) {
        super(reservationId, vehicleId, customerName, customerEmail, customerPhone,
                pickupDate, returnDate, rentalDays, "CHAUFFEUR", status, totalAmount);
        this.pickupLocation = pickupLocation;
        this.driverDailyFee = driverDailyFee;
        this.tripItineraryNotes = tripItineraryNotes;
    }

    // Polymorphism: Calculates daily rate + dedicated professional chauffeur daily fee + airport dispatch surcharge
    @Override
    public double calculateTotalBill(double vehicleDailyRate) {
        double vehicleCost = vehicleDailyRate * getRentalDays();
        double driverCost = driverDailyFee * getRentalDays();
        double airportMeetSurcharge = 5000.00;
        return vehicleCost + driverCost + airportMeetSurcharge;
    }

    @Override
    public String getRentalSummary() {
        return "Chauffeur Service (" + getRentalDays() + " Days) | Pickup: " + pickupLocation + 
               " | Chauffeur Rate: LKR " + String.format("%,.2f", driverDailyFee) + "/day";
    }

    @Override
    public String toCSVString() {
        // Format: reservationId,vehicleId,customerName,customerEmail,customerPhone,pickupDate,returnDate,rentalDays,rentalType,location,driverFee,itinerary,status,totalAmount
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
                pickupLocation != null ? pickupLocation.replace(",", " ") : "City Center",
                String.format("%.2f", driverDailyFee),
                tripItineraryNotes != null && !tripItineraryNotes.isEmpty() ? tripItineraryNotes.replace(",", " ") : "Executive City Drive",
                getStatus(),
                String.format("%.2f", getTotalAmount())
        );
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public double getDriverDailyFee() {
        return driverDailyFee;
    }

    public void setDriverDailyFee(double driverDailyFee) {
        this.driverDailyFee = driverDailyFee;
    }

    public String getTripItineraryNotes() {
        return tripItineraryNotes;
    }

    public void setTripItineraryNotes(String tripItineraryNotes) {
        this.tripItineraryNotes = tripItineraryNotes;
    }
}
