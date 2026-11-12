<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "Register Fleet Vehicle - Member 01"); %>
<%@ include file="includes/header.jsp" %>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="saas-card p-4 p-md-5">
            <div class="d-flex align-items-center gap-3 mb-4 border-bottom pb-3">
                <span style="width: 44px; height: 44px; border-radius: 12px; background: #eef2ff; color: #4338ca; display: inline-flex; align-items: center; justify-content: center; font-size: 1.3rem;">
                    <i class="bi bi-plus-circle-fill"></i>
                </span>
                <div>
                    <h3 class="fw-bold heading-brand text-dark mb-0">Register New Fleet Vehicle</h3>
                    <p class="text-secondary small mb-0">Member 01 Component &bull; Persists directly to <code>data/vehicles.txt</code></p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/vehicles" method="post" id="addVehicleForm">
                <input type="hidden" name="action" value="insert">

                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Vehicle ID</label>
                        <input type="text" name="vehicleId" class="form-control" 
                               value="<%= request.getAttribute("nextId") != null ? request.getAttribute("nextId") : "VEH107" %>" required>
                    </div>
                    <div class="col-md-8">
                        <label class="form-label small fw-bold text-secondary">Make &amp; Model Title</label>
                        <input type="text" name="makeModel" class="form-control" placeholder="e.g. BMW M4 Competition Coupe" required>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Base Daily Rate (LKR)</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted">LKR</span>
                            <input type="number" step="500.00" min="5000.00" name="dailyRate" class="form-control" placeholder="35000.00" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Vehicle Classification</label>
                        <select name="category" id="catSelect" class="form-select" onchange="toggleCategoryAttributes()">
                            <option value="LUXURY_CAR" selected>Luxury Sedan / Sports / SUV</option>
                            <option value="COMMERCIAL_VAN">Commercial &amp; Passenger Van</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Powertrain / Fuel</label>
                        <select name="fuelType" class="form-select">
                            <option value="Petrol">Petrol</option>
                            <option value="Diesel">Diesel</option>
                            <option value="Hybrid">Hybrid</option>
                            <option value="Electric">Electric (EV)</option>
                        </select>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-secondary">Transmission Gearbox</label>
                        <select name="transmission" class="form-select">
                            <option value="Automatic" selected>Automatic</option>
                            <option value="Manual">Manual</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-secondary">Seating Capacity</label>
                        <input type="number" min="1" max="20" name="seatingCapacity" class="form-control" value="5" required>
                    </div>
                </div>

                <!-- Vehicle Photo URL & Preview -->
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Vehicle High-Res Image URL</label>
                    <input type="url" name="imageUrl" id="carImgUrl" class="form-control" 
                           placeholder="https://images.unsplash.com/..." 
                           value="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800"
                           oninput="previewVehicleImage()">
                    <div class="mt-2 text-center p-2 border rounded-3 bg-light" style="max-height: 200px; overflow: hidden;">
                        <img id="carPreview" src="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800" 
                             alt="Car Preview" style="height: 180px; width: 100%; object-fit: cover; border-radius: 8px;">
                    </div>
                </div>

                <!-- Car Attributes -->
                <div id="carAttributes" class="p-3 bg-light rounded-3 mb-3 border">
                    <h6 class="fw-bold text-primary mb-3 small text-uppercase tracking-wider">
                        <i class="bi bi-car-front me-1"></i> Luxury Car Specific Specifications
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-secondary">Trunk / Boot Capacity (Litres)</label>
                            <input type="number" name="trunkCapacityLitres" class="form-control" value="450">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-secondary">Security Deposit (LKR)</label>
                            <input type="number" step="1000" name="securityDeposit" class="form-control" value="75000.00">
                        </div>
                        <div class="col-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="hasAutopilot" id="autoPilotCheck" checked>
                                <label class="form-check-label small fw-semibold text-dark" for="autoPilotCheck">
                                    Autonomous Driver Assist / Autopilot Suite (+LKR 5,000/day surcharge)
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Van Attributes -->
                <div id="vanAttributes" class="p-3 bg-light rounded-3 mb-3 border" style="display:none;">
                    <h6 class="fw-bold text-warning mb-3 small text-uppercase tracking-wider">
                        <i class="bi bi-truck me-1"></i> Commercial Van Specific Specifications
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Cargo Payload (Kg)</label>
                            <input type="number" name="cargoPayloadKg" class="form-control" value="1200">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Commercial Permit (LKR)</label>
                            <input type="number" step="500" name="commercialPermitFee" class="form-control" value="3500.00">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Towing Capacity (Kg)</label>
                            <input type="number" name="towingCapacityKg" class="form-control" value="2000">
                        </div>
                    </div>
                </div>

                <!-- Availability -->
                <div class="form-check form-switch mb-4">
                    <input class="form-check-input" type="checkbox" name="available" id="availToggle" checked>
                    <label class="form-check-label small fw-bold text-dark" for="availToggle">Make immediately available in online showroom</label>
                </div>

                <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/vehicles?action=manage" class="btn btn-saas-secondary rounded-pill px-4">
                        <i class="bi bi-arrow-left me-1"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-saas-primary rounded-pill px-4">
                        <i class="bi bi-check2-circle me-1"></i> Save to Fleet Registry
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function toggleCategoryAttributes() {
    var cat = document.getElementById("catSelect").value;
    var carBox = document.getElementById("carAttributes");
    var vanBox = document.getElementById("vanAttributes");
    if (cat === "LUXURY_CAR") {
        carBox.style.display = "block";
        vanBox.style.display = "none";
    } else {
        carBox.style.display = "none";
        vanBox.style.display = "block";
    }
}
function previewVehicleImage() {
    var url = document.getElementById("carImgUrl").value;
    if (url) {
        document.getElementById("carPreview").src = url;
    }
}
</script>

<%@ include file="includes/footer.jsp" %>
