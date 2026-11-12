<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.drivehub.model.RentalReservation" %>
<%@ page import="com.drivehub.model.SelfDriveReservation" %>
<%@ page import="com.drivehub.model.ChauffeurDrivenReservation" %>

<% request.setAttribute("pageTitle", "Track Rental Agreement - DriveHub"); %>
<%@ include file="includes/header.jsp" %>

<div class="row justify-content-center">
    <div class="col-lg-9">
        <!-- Search Card -->
        <div class="saas-card p-4 p-md-5 mb-4 text-center">
            <span class="badge-pill-soft badge-soft-indigo mb-2">Self-Service Portal</span>
            <h3 class="display-6 fw-bold heading-brand text-dark mb-2">Track Your Rental Agreement</h3>
            <p class="text-secondary small mb-4 col-md-8 mx-auto">
                Look up your active contract status, itinerary schedule, chauffeur assignment, and digital rental pass.
            </p>

            <form action="${pageContext.request.contextPath}/rentals" method="get" class="row g-2 justify-content-center">
                <input type="hidden" name="action" value="track">
                <div class="col-md-7">
                    <div class="input-group input-group-lg">
                        <span class="input-group-text bg-light border-end-0 text-muted ps-3"><i class="bi bi-search"></i></span>
                        <input type="text" name="query" class="form-control bg-light border-start-0" 
                               placeholder="e.g. RNT5001, customer email, or phone..."
                               value="<%= request.getAttribute("query") != null ? request.getAttribute("query") : "" %>" required>
                    </div>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-saas-primary btn-lg w-100 rounded-pill">
                        Track Now
                    </button>
                </div>
            </form>
        </div>

        <!-- Search Results -->
        <%
            Boolean searched = (Boolean) request.getAttribute("searchPerformed");
            List<RentalReservation> found = (List<RentalReservation>) request.getAttribute("foundRentals");

            if (searched != null && searched) {
                if (found == null || found.isEmpty()) {
        %>
            <div class="saas-card p-5 text-center">
                <div class="d-inline-flex p-3 rounded-circle bg-light text-muted fs-1 mb-3">
                    <i class="bi bi-search"></i>
                </div>
                <h5 class="fw-bold text-dark mb-2">No Matching Rental Agreement Found</h5>
                <p class="text-secondary small col-md-6 mx-auto mb-4">
                    We could not find any active booking matching your search in <code>data/rentals.txt</code>. Please check your reservation ID or book a new rental.
                </p>
                <a href="${pageContext.request.contextPath}/rentals?action=book" class="btn btn-saas-primary btn-sm rounded-pill px-4">
                    Create New Reservation
                </a>
            </div>
        <%
                } else {
                    for (RentalReservation r : found) {
                        String st = r.getStatus().toUpperCase();
                        String badgeClass = "badge-soft-amber";
                        if ("RETURNED".equals(st) || "CONFIRMED".equals(st)) badgeClass = "badge-soft-emerald";
                        if ("CANCELLED".equals(st)) badgeClass = "badge-soft-rose";
                        if ("ACTIVE".equals(st)) badgeClass = "badge-soft-indigo";
        %>
            <!-- Digital Boarding Pass / Rental Agreement -->
            <div class="saas-card mb-4 overflow-hidden border">
                <!-- Top Brand Header -->
                <div class="p-4 bg-dark text-white d-flex justify-content-between align-items-center flex-wrap gap-3" 
                     style="background: linear-gradient(135deg, #0b0f19 0%, #1e1b4b 100%) !important;">
                    <div>
                        <span class="badge-pill-soft <%= badgeClass %> mb-2"><%= st %></span>
                        <h4 class="fw-bold text-white heading-brand mb-0">Agreement <%= r.getReservationId() %></h4>
                        <small class="text-light opacity-75">Vehicle Code: <strong><%= r.getVehicleId() %></strong> &bull; <%= r.getRentalType() %> Mode</small>
                    </div>
                    <div class="text-md-end">
                        <small class="text-light opacity-75 d-block">Total Hire Amount</small>
                        <h3 class="fw-bold text-info mb-0">LKR <%= String.format("%,.2f", r.getTotalAmount()) %></h3>
                        <small class="text-light opacity-75"><%= r.getRentalDays() %> Day(s) Allocated</small>
                    </div>
                </div>

                <!-- Visual Stepper Progress Bar -->
                <div class="p-3 bg-light border-bottom">
                    <div class="row text-center g-2 small">
                        <div class="col-3">
                            <i class="bi bi-check-circle-fill text-success fs-5 d-block"></i>
                            <span class="fw-bold text-dark">1. Confirmed</span>
                        </div>
                        <div class="col-3">
                            <i class="bi <%= ("ACTIVE".equals(st) || "RETURNED".equals(st)) ? "bi-check-circle-fill text-success" : "bi-circle text-muted" %> fs-5 d-block"></i>
                            <span class="<%= ("ACTIVE".equals(st) || "RETURNED".equals(st)) ? "fw-bold text-dark" : "text-muted" %>">2. Inspected</span>
                        </div>
                        <div class="col-3">
                            <i class="bi <%= ("ACTIVE".equals(st)) ? "bi-record-circle text-primary" : (("RETURNED".equals(st)) ? "bi-check-circle-fill text-success" : "bi-circle text-muted") %> fs-5 d-block"></i>
                            <span class="<%= "ACTIVE".equals(st) ? "fw-bold text-primary" : "text-muted" %>">3. On Road</span>
                        </div>
                        <div class="col-3">
                            <i class="bi <%= "RETURNED".equals(st) ? "bi-check-circle-fill text-success" : "bi-circle text-muted" %> fs-5 d-block"></i>
                            <span class="<%= "RETURNED".equals(st) ? "fw-bold text-success" : "text-muted" %>">4. Returned</span>
                        </div>
                    </div>
                </div>

                <!-- Customer & Schedule Breakdown -->
                <div class="p-4">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <div class="p-3 rounded-3 bg-light border h-100">
                                <h6 class="small fw-bold text-primary text-uppercase tracking-wider mb-3">
                                    <i class="bi bi-person-fill me-1"></i> Renter Contact Details
                                </h6>
                                <p class="mb-1 small"><strong>Customer:</strong> <%= r.getCustomerName() %></p>
                                <p class="mb-1 small"><strong>Email:</strong> <%= r.getCustomerEmail() %></p>
                                <p class="mb-0 small"><strong>Phone:</strong> <%= r.getCustomerPhone() %></p>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="p-3 rounded-3 bg-light border h-100">
                                <h6 class="small fw-bold text-primary text-uppercase tracking-wider mb-3">
                                    <i class="bi bi-calendar-check me-1"></i> Rental Itinerary &amp; Package
                                </h6>
                                <p class="mb-1 small"><strong>Pickup Date:</strong> <%= r.getPickupDate() %></p>
                                <p class="mb-1 small"><strong>Return Date:</strong> <%= r.getReturnDate() %></p>
                                <p class="mb-0 small"><strong>Terms:</strong> <%= r.getRentalSummary() %></p>
                            </div>
                        </div>
                    </div>

                    <!-- Footer Action Bar -->
                    <div class="d-flex justify-content-between align-items-center pt-3 border-top flex-wrap gap-2">
                        <span class="small text-muted">
                            <i class="bi bi-file-earmark-text text-primary me-1"></i> Synced with <code>rentals.txt</code> storage
                        </span>
                        <div>
                            <% if (r.canBeCancelled()) { %>
                                <a href="${pageContext.request.contextPath}/rentals?action=cancel&id=<%= r.getReservationId() %>" 
                                   class="btn btn-outline-danger btn-sm rounded-pill px-4"
                                   onclick="return confirm('Cancel reservation <%= r.getReservationId() %>?');">
                                    <i class="bi bi-x-circle me-1"></i> Cancel Reservation
                                </a>
                            <% } else { %>
                                <span class="badge bg-light text-muted border px-3 py-2">Lock in place (<%= st %>)</span>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        <%
                    }
                }
            }
        %>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
