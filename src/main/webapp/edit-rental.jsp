<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.drivehub.model.RentalReservation" %>
<%@ page import="com.drivehub.model.SelfDriveReservation" %>
<%@ page import="com.drivehub.model.ChauffeurDrivenReservation" %>

<% request.setAttribute("pageTitle", "Modify Rental Booking - Member 02"); %>
<%@ include file="includes/header.jsp" %>

<%
    RentalReservation r = (RentalReservation) request.getAttribute("rental");
    if (r == null) {
        response.sendRedirect("rentals?action=manage");
        return;
    }
    boolean isChauffeur = r instanceof ChauffeurDrivenReservation;
%>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="saas-card p-4 p-md-5">
            <div class="d-flex align-items-center gap-3 mb-4 border-bottom pb-3">
                <span style="width: 44px; height: 44px; border-radius: 12px; background: #eef2ff; color: #4338ca; display: inline-flex; align-items: center; justify-content: center; font-size: 1.3rem;">
                    <i class="bi bi-pencil-square"></i>
                </span>
                <div>
                    <h3 class="fw-bold heading-brand text-dark mb-0">Modify Reservation: <%= r.getReservationId() %></h3>
                    <p class="text-secondary small mb-0">Reschedule Dates or Update Customer Contract &bull; Member 02</p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/rentals" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>">

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-secondary">Customer Full Name</label>
                        <input type="text" name="customerName" class="form-control" value="<%= r.getCustomerName() %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-secondary">Customer Email</label>
                        <input type="email" name="customerEmail" class="form-control" value="<%= r.getCustomerEmail() %>" required>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Mobile Phone</label>
                        <input type="tel" name="customerPhone" class="form-control" value="<%= r.getCustomerPhone() %>" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Pickup Date</label>
                        <input type="date" name="pickupDate" class="form-control" value="<%= r.getPickupDate() %>" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Return Date</label>
                        <input type="date" name="returnDate" class="form-control" value="<%= r.getReturnDate() %>" required>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-secondary">Duration (Days)</label>
                        <input type="number" min="1" max="90" name="rentalDays" class="form-control" value="<%= r.getRentalDays() %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-secondary">Current Status</label>
                        <input type="text" class="form-control bg-light" value="<%= r.getStatus() %>" readonly disabled>
                    </div>
                </div>

                <% if (isChauffeur) { 
                    ChauffeurDrivenReservation cdr = (ChauffeurDrivenReservation) r;
                %>
                <!-- Chauffeur Details -->
                <div class="p-3 bg-light rounded-3 mb-3 border">
                    <h6 class="fw-bold text-warning mb-3 small text-uppercase tracking-wider">
                        <i class="bi bi-person-badge-fill me-1"></i> Chauffeur Service Details
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-secondary">Pickup Location</label>
                            <input type="text" name="pickupLocation" class="form-control" value="<%= cdr.getPickupLocation() %>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-secondary">Driver Daily Fee (LKR)</label>
                            <input type="number" step="500" name="driverDailyFee" class="form-control" value="<%= cdr.getDriverDailyFee() %>">
                        </div>
                        <div class="col-12">
                            <label class="form-label small fw-bold text-secondary">Itinerary Notes</label>
                            <input type="text" name="tripItineraryNotes" class="form-control" value="<%= cdr.getTripItineraryNotes() %>">
                        </div>
                    </div>
                </div>
                <% } else { 
                    SelfDriveReservation sdr = (SelfDriveReservation) r;
                %>
                <!-- Self Drive Details -->
                <div class="p-3 bg-light rounded-3 mb-3 border">
                    <h6 class="fw-bold text-primary mb-3 small text-uppercase tracking-wider">
                        <i class="bi bi-shield-lock me-1"></i> Self-Drive Protection &amp; License
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Driver's License No.</label>
                            <input type="text" name="driverLicenseNumber" class="form-control" value="<%= sdr.getDriverLicenseNumber() %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Mileage Allowance</label>
                            <input type="text" name="mileagePackage" class="form-control" value="<%= sdr.getMileagePackage() %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Insurance Protection</label>
                            <input type="text" name="insuranceTier" class="form-control" value="<%= sdr.getInsuranceTier() %>">
                        </div>
                    </div>
                </div>
                <% } %>

                <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/rentals?action=manage" class="btn btn-saas-secondary rounded-pill px-4">
                        <i class="bi bi-arrow-left me-1"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-saas-primary rounded-pill px-4">
                        <i class="bi bi-save me-1"></i> Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
