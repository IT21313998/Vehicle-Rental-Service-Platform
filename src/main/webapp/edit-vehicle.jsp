<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.drivehub.model.Vehicle" %>
<%@ page import="com.drivehub.model.CarVehicle" %>
<%@ page import="com.drivehub.model.VanCommercialVehicle" %>

<% request.setAttribute("pageTitle", "Edit Fleet Vehicle - Member 01"); %>
<%@ include file="includes/header.jsp" %>

<%
    Vehicle v = (Vehicle) request.getAttribute("vehicle");
    if (v == null) {
        response.sendRedirect("vehicles?action=manage");
        return;
    }
    boolean isCar = "LUXURY_CAR".equalsIgnoreCase(v.getCategory());
%>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="saas-card p-4 p-md-5">
            <div class="d-flex align-items-center gap-3 mb-4 border-bottom pb-3">
                <span style="width: 44px; height: 44px; border-radius: 12px; background: #eef2ff; color: #4338ca; display: inline-flex; align-items: center; justify-content: center; font-size: 1.3rem;">
                    <i class="bi bi-pencil-square"></i>
                </span>
                <div>
                    <h3 class="fw-bold heading-brand text-dark mb-0">Modify Vehicle: <%= v.getMakeModel() %></h3>
                    <p class="text-secondary small mb-0">Vehicle ID: <strong class="text-primary"><%= v.getVehicleId() %></strong> &bull; Updating <code>data/vehicles.txt</code></p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/vehicles" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="vehicleId" value="<%= v.getVehicleId() %>">
                <input type="hidden" name="category" value="<%= v.getCategory() %>">

                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Vehicle ID</label>
                        <input type="text" class="form-control bg-light" value="<%= v.getVehicleId() %>" readonly disabled>
                    </div>
                    <div class="col-md-8">
                        <label class="form-label small fw-bold text-secondary">Make &amp; Model Title</label>
                        <input type="text" name="makeModel" class="form-control" value="<%= v.getMakeModel() %>" required>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Base Daily Rate (LKR)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted">LKR</span>
                            <input type="number" step="500.00" min="5000.00" name="dailyRate" class="form-control" value="<%= v.getDailyRate() %>" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Category</label>
                        <input type="text" class="form-control bg-light" value="<%= isCar ? "Luxury Sedan / Sports / SUV" : "Commercial & Passenger Van" %>" readonly disabled>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Powertrain / Fuel</label>
                        <select name="fuelType" class="form-select">
                            <option value="Petrol" <%= "Petrol".equalsIgnoreCase(v.getFuelType()) ? "selected" : "" %>>Petrol</option>
                            <option value="Diesel" <%= "Diesel".equalsIgnoreCase(v.getFuelType()) ? "selected" : "" %>>Diesel</option>
                            <option value="Hybrid" <%= "Hybrid".equalsIgnoreCase(v.getFuelType()) ? "selected" : "" %>>Hybrid</option>
                            <option value="Electric" <%= "Electric".equalsIgnoreCase(v.getFuelType()) ? "selected" : "" %>>Electric (EV)</option>
                        </select>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-secondary">Transmission Gearbox</label>
                        <select name="transmission" class="form-select">
                            <option value="Automatic" <%= "Automatic".equalsIgnoreCase(v.getTransmission()) ? "selected" : "" %>>Automatic</option>
                            <option value="Manual" <%= "Manual".equalsIgnoreCase(v.getTransmission()) ? "selected" : "" %>>Manual</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-secondary">Seating Capacity</label>
                        <input type="number" min="1" max="20" name="seatingCapacity" class="form-control" value="<%= v.getSeatingCapacity() %>" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Image URL</label>
                    <input type="url" name="imageUrl" class="form-control" value="<%= v.getImageUrl() %>" required>
                </div>

                <% if (isCar && v instanceof CarVehicle) { 
                    CarVehicle car = (CarVehicle) v;
                %>
                <!-- Car specifics -->
                <div class="p-3 bg-light rounded-3 mb-3 border">
                    <h6 class="fw-bold text-primary mb-3 small text-uppercase tracking-wider">
                        <i class="bi bi-car-front me-1"></i> Luxury Car Specifications
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-secondary">Trunk Capacity (Litres)</label>
                            <input type="number" name="trunkCapacityLitres" class="form-control" value="<%= car.getTrunkCapacityLitres() %>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-secondary">Security Deposit (LKR)</label>
                            <input type="number" step="1000" name="securityDeposit" class="form-control" value="<%= car.getSecurityDeposit() %>">
                        </div>
                        <div class="col-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="hasAutopilot" id="autoCheck" <%= car.isHasAutopilot() ? "checked" : "" %>>
                                <label class="form-check-label small fw-semibold text-dark" for="autoCheck">
                                    Autonomous Driver Assist / Autopilot Suite (+LKR 5,000/day surcharge)
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <% } else if (v instanceof VanCommercialVehicle) { 
                    VanCommercialVehicle van = (VanCommercialVehicle) v;
                %>
                <!-- Van specifics -->
                <div class="p-3 bg-light rounded-3 mb-3 border">
                    <h6 class="fw-bold text-warning mb-3 small text-uppercase tracking-wider">
                        <i class="bi bi-truck me-1"></i> Commercial Van Specifications
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Cargo Payload (Kg)</label>
                            <input type="number" name="cargoPayloadKg" class="form-control" value="<%= van.getCargoPayloadKg() %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Commercial Permit (LKR)</label>
                            <input type="number" step="500" name="commercialPermitFee" class="form-control" value="<%= van.getCommercialPermitFee() %>">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Towing Capacity (Kg)</label>
                            <input type="number" name="towingCapacityKg" class="form-control" value="<%= van.getTowingCapacityKg() %>">
                        </div>
                    </div>
                </div>
                <% } %>

                <div class="form-check form-switch mb-4">
                    <input class="form-check-input" type="checkbox" name="available" id="availCheck" <%= v.isAvailable() ? "checked" : "" %>>
                    <label class="form-check-label small fw-bold text-dark" for="availCheck">Available for Immediate Customer Rentals</label>
                </div>

                <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/vehicles?action=manage" class="btn btn-saas-secondary rounded-pill px-4">
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
