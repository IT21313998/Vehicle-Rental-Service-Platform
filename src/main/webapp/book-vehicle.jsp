<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.drivehub.model.Vehicle" %>

<% request.setAttribute("pageTitle", "Reserve a Rental Vehicle - DriveHub"); %>
<%@ include file="includes/header.jsp" %>

<!-- Booking Header -->
<div class="mb-4">
    <div class="d-inline-flex align-items-center gap-2 mb-1">
        <span class="badge-pill-soft badge-soft-emerald">Member 02 Component</span>
        <span class="text-muted small">&bull; Real-time quote engine</span>
    </div>
    <h2 class="display-6 fw-bold heading-brand text-dark mb-0">Vehicle Rental Reservation</h2>
    <p class="text-secondary small mb-0">Book your self-drive or chauffeur-driven vehicle with automated instant rate calculation.</p>
</div>

<form action="${pageContext.request.contextPath}/rentals" method="post" id="rentalBookingForm">
    <input type="hidden" name="action" value="create">

    <div class="row g-4">
        <!-- Main Form Column -->
        <div class="col-lg-8">
            <!-- Step 1: Vehicle & Reservation Details -->
            <div class="saas-card p-4 mb-4">
                <div class="d-flex align-items-center gap-3 mb-3 border-bottom pb-3">
                    <span style="width: 32px; height: 32px; border-radius: 50%; background: #4f46e5; color: white; display: inline-flex; align-items: center; justify-content: center; font-weight: bold;">1</span>
                    <h5 class="fw-bold heading-brand mb-0 text-dark">Vehicle Selection &amp; Reservation Code</h5>
                </div>

                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Reservation ID</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="bi bi-hash"></i></span>
                            <input type="text" name="reservationId" class="form-control bg-light fw-bold text-primary" 
                                   value="<%= request.getAttribute("nextReservationId") != null ? request.getAttribute("nextReservationId") : "RNT5004" %>" readonly required>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <label class="form-label small fw-bold text-secondary">Choose Vehicle from Showroom</label>
                        <select name="vehicleId" id="carSelect" class="form-select py-2" onchange="recalculateRentalTotal()" required>
                            <%
                                String selVehId = (String) request.getAttribute("selectedVehicleId");
                                List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicleList");
                                if (vehicles != null) {
                                    for (Vehicle veh : vehicles) {
                                        boolean isSelected = (selVehId != null && selVehId.equalsIgnoreCase(veh.getVehicleId()));
                            %>
                                <option value="<%= veh.getVehicleId() %>" 
                                        data-rate="<%= veh.calculateDailyRentalRate() %>" 
                                        data-model="<%= veh.getMakeModel() %>"
                                        <%= isSelected ? "selected" : "" %>>
                                    <%= veh.getMakeModel() %> &bull; <%= veh.getTransmission() %> &bull; LKR <%= String.format("%,.2f", veh.calculateDailyRentalRate()) %>/day
                                </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Step 2: Customer Contact Information -->
            <div class="saas-card p-4 mb-4">
                <div class="d-flex align-items-center gap-3 mb-3 border-bottom pb-3">
                    <span style="width: 32px; height: 32px; border-radius: 50%; background: #4f46e5; color: white; display: inline-flex; align-items: center; justify-content: center; font-weight: bold;">2</span>
                    <h5 class="fw-bold heading-brand mb-0 text-dark">Customer Contact Information</h5>
                </div>

                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Full Name</label>
                        <input type="text" name="customerName" class="form-control" placeholder="e.g. Alexander Vance" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Email Address</label>
                        <input type="email" name="customerEmail" class="form-control" placeholder="e.g. alexander@company.com" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Mobile Phone / WhatsApp</label>
                        <input type="tel" name="customerPhone" class="form-control" placeholder="e.g. +1 555 019 2834" required>
                    </div>
                </div>
            </div>

            <!-- Step 3: Dates & Rental Duration -->
            <div class="saas-card p-4 mb-4">
                <div class="d-flex align-items-center gap-3 mb-3 border-bottom pb-3">
                    <span style="width: 32px; height: 32px; border-radius: 50%; background: #4f46e5; color: white; display: inline-flex; align-items: center; justify-content: center; font-weight: bold;">3</span>
                    <h5 class="fw-bold heading-brand mb-0 text-dark">Rental Schedule &amp; Duration</h5>
                </div>

                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Pickup Date</label>
                        <input type="date" name="pickupDate" id="pickupDateInput" class="form-control" required onchange="calculateRentalDays()">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Return Date</label>
                        <input type="date" name="returnDate" id="returnDateInput" class="form-control" required onchange="calculateRentalDays()">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-secondary">Duration (Days)</label>
                        <input type="number" min="1" max="90" name="rentalDays" id="rentalDaysInput" class="form-control" value="3" 
                               oninput="recalculateRentalTotal()" required>
                        <div class="small text-muted mt-1" id="discountNote">
                            <i class="bi bi-tag-fill text-success"></i> 7+ days unlocks 15% discount
                        </div>
                    </div>
                </div>
            </div>

            <!-- Step 4: Rental Mode (Self-Drive vs Chauffeur) -->
            <div class="saas-card p-4 mb-4">
                <div class="d-flex align-items-center gap-3 mb-3 border-bottom pb-3">
                    <span style="width: 32px; height: 32px; border-radius: 50%; background: #4f46e5; color: white; display: inline-flex; align-items: center; justify-content: center; font-weight: bold;">4</span>
                    <h5 class="fw-bold heading-brand mb-0 text-dark">Choose Rental Experience</h5>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <div class="p-3 border rounded-3 cursor-pointer rental-mode-card active" id="modeSelfCard" onclick="selectMode('SELF_DRIVE')">
                            <div class="d-flex align-items-center gap-3">
                                <div class="p-2 rounded-2 bg-primary-subtle text-primary fs-3">
                                    <i class="bi bi-steering-wheel"></i>
                                </div>
                                <div>
                                    <h6 class="fw-bold text-dark mb-0">Self-Drive Rental</h6>
                                    <small class="text-muted">Take the wheel with your own driver's license</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="p-3 border rounded-3 cursor-pointer rental-mode-card" id="modeChauffeurCard" onclick="selectMode('CHAUFFEUR')">
                            <div class="d-flex align-items-center gap-3">
                                <div class="p-2 rounded-2 bg-warning-subtle text-warning fs-3">
                                    <i class="bi bi-person-badge-fill"></i>
                                </div>
                                <div>
                                    <h6 class="fw-bold text-dark mb-0">Executive Chauffeur</h6>
                                    <small class="text-muted">Dedicated certified professional driver included</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <input type="hidden" name="rentalType" id="rentalTypeSelect" value="SELF_DRIVE">

                <!-- Self Drive Specifics -->
                <div id="selfDriveBox" class="p-3 rounded-3 bg-light border">
                    <h6 class="fw-bold text-primary mb-3 small text-uppercase tracking-wider">
                        <i class="bi bi-shield-lock me-1"></i> Self-Drive Credentials &amp; Insurance Protection
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Driver's License No.</label>
                            <input type="text" name="driverLicenseNumber" id="driverLicenseInput" class="form-control" placeholder="e.g. DL-99210-CA" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Mileage Allowance</label>
                            <select name="mileagePackage" class="form-select">
                                <option value="Unlimited Mileage" selected>Unlimited Mileage Plan</option>
                                <option value="Standard 250km/day">Standard 250km / day Allowance</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label small fw-bold text-secondary">Insurance Protection</label>
                            <select name="insuranceTier" id="insuranceSelect" class="form-select" onchange="recalculateRentalTotal()">
                                <option value="Basic Collision Waiver">Basic Waiver (+LKR 3,500/day)</option>
                                <option value="Comprehensive Premium" selected>Comprehensive (+LKR 6,000/day)</option>
                                <option value="Zero Liability">Zero Liability (+LKR 9,500/day)</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Chauffeur Specifics -->
                <div id="chauffeurBox" class="p-3 rounded-3 bg-light border" style="display:none;">
                    <h6 class="fw-bold text-warning mb-3 small text-uppercase tracking-wider">
                        <i class="bi bi-geo-alt-fill me-1"></i> Executive Chauffeur &amp; Dispatch Options
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-secondary">Pickup Location / Flight Arrival</label>
                            <input type="text" name="pickupLocation" id="pickupLocationInput" class="form-control" placeholder="e.g. Bandaranaike Intl Airport or Cinnamon Grand Hotel">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold text-secondary">Driver Tariff</label>
                            <select name="driverDailyFee" id="driverFeeSelect" class="form-select" onchange="recalculateRentalTotal()">
                                <option value="6500.00" selected>Standard Certified Chauffeur (LKR 6,500/day)</option>
                                <option value="10000.00">VIP Multilingual Security Chauffeur (LKR 10,000/day)</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sticky Quote Summary Column -->
        <div class="col-lg-4">
            <div class="saas-card p-4 position-sticky" style="top: 100px;">
                <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                    <h5 class="fw-bold heading-brand text-dark mb-0">Live Quote Summary</h5>
                    <span class="badge bg-primary-subtle text-primary">Instant Estimate</span>
                </div>

                <div class="mb-3">
                    <small class="text-muted d-block">Selected Vehicle</small>
                    <h6 class="fw-bold text-dark mb-0" id="summaryVehicleModel">--</h6>
                </div>

                <div class="d-flex flex-column gap-2 small border-bottom pb-3 mb-3">
                    <div class="d-flex justify-content-between">
                        <span class="text-secondary">Base Rate (<span id="summaryDays">3</span> days):</span>
                        <span class="fw-semibold text-dark" id="summaryBasePrice">LKR 0.00</span>
                    </div>
                    <div class="d-flex justify-content-between" id="summaryInsuranceRow">
                        <span class="text-secondary">Insurance Protection:</span>
                        <span class="fw-semibold text-dark" id="summaryInsurancePrice">LKR 0.00</span>
                    </div>
                    <div class="d-flex justify-content-between" id="summaryChauffeurRow" style="display:none;">
                        <span class="text-secondary">Chauffeur Service:</span>
                        <span class="fw-semibold text-dark" id="summaryChauffeurPrice">LKR 0.00</span>
                    </div>
                    <div class="d-flex justify-content-between text-success" id="summaryDiscountRow" style="display:none;">
                        <span><i class="bi bi-tag-fill me-1"></i> Long-Term Discount (15%):</span>
                        <span class="fw-bold" id="summaryDiscountPrice">-LKR 0.00</span>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-baseline mb-2">
                    <span class="h6 fw-bold text-dark mb-0">Total Estimated:</span>
                    <span class="h5 fw-bold text-primary mb-0" id="summaryGrandTotal">LKR 0.00</span>
                </div>

                <div class="p-2 rounded-2 bg-light text-muted small mb-4 border" id="summaryDepositRow">
                    <i class="bi bi-shield-check text-info me-1"></i> Includes <strong class="text-dark" id="summaryDepositText">LKR 75,000.00</strong> refundable deposit (returned upon check-in).
                </div>

                <button type="submit" class="btn btn-saas-primary w-100 py-3 fw-bold rounded-pill shadow">
                    <i class="bi bi-lock-fill me-1"></i> Confirm &amp; Dispatch Reservation
                </button>

                <p class="text-center small text-muted mt-3 mb-0">
                    <i class="bi bi-shield-fill-check text-success me-1"></i> No credit card required today. Pay at pickup.
                </p>
            </div>
        </div>
    </div>
</form>

<style>
    .rental-mode-card {
        cursor: pointer;
        transition: all 0.2s ease;
    }
    .rental-mode-card:hover {
        border-color: #4f46e5 !important;
        background: #f8fafc;
    }
    .rental-mode-card.active {
        border-color: #4f46e5 !important;
        background: #eef2ff !important;
        box-shadow: 0 0 0 1px #4f46e5;
    }
</style>

<!-- Live Price Calculation Script -->
<script>
    function selectMode(mode) {
        document.getElementById('rentalTypeSelect').value = mode;
        if (mode === 'SELF_DRIVE') {
            document.getElementById('modeSelfCard').classList.add('active');
            document.getElementById('modeChauffeurCard').classList.remove('active');
            document.getElementById('selfDriveBox').style.display = 'block';
            document.getElementById('chauffeurBox').style.display = 'none';
            document.getElementById('driverLicenseInput').required = true;
            document.getElementById('pickupLocationInput').required = false;
        } else {
            document.getElementById('modeSelfCard').classList.remove('active');
            document.getElementById('modeChauffeurCard').classList.add('active');
            document.getElementById('selfDriveBox').style.display = 'none';
            document.getElementById('chauffeurBox').style.display = 'block';
            document.getElementById('driverLicenseInput').required = false;
            document.getElementById('pickupLocationInput').required = true;
        }
        recalculateRentalTotal();
    }

    function calculateRentalDays() {
        const pDate = document.getElementById('pickupDateInput').value;
        const rDate = document.getElementById('returnDateInput').value;
        if (pDate && rDate) {
            const start = new Date(pDate);
            const end = new Date(rDate);
            const diffTime = end - start;
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            if (diffDays > 0) {
                document.getElementById('rentalDaysInput').value = diffDays;
            } else {
                alert("Return date must be after pickup date.");
                document.getElementById('returnDateInput').value = "";
            }
        }
        recalculateRentalTotal();
    }

    function recalculateRentalTotal() {
        const carSelect = document.getElementById('carSelect');
        if (!carSelect || !carSelect.selectedOptions || carSelect.selectedOptions.length === 0) return;
        
        const selectedOpt = carSelect.selectedOptions[0];
        const dailyRate = parseFloat(selectedOpt.getAttribute('data-rate')) || 100.0;
        const modelName = selectedOpt.getAttribute('data-model') || selectedOpt.text;
        
        let days = parseInt(document.getElementById('rentalDaysInput').value) || 1;
        if (days < 1) days = 1;

        const rentalType = document.getElementById('rentalTypeSelect').value;

        let baseTotal = dailyRate * days;
        let discount = 0.0;
        let insuranceTotal = 0.0;
        let chauffeurTotal = 0.0;
        let deposit = 0.0;

        document.getElementById('summaryVehicleModel').innerText = modelName;
        document.getElementById('summaryDays').innerText = days;

        function formatLKR(num) {
            return 'LKR ' + num.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        }

        if (rentalType === 'SELF_DRIVE') {
            const insTier = document.getElementById('insuranceSelect').value;
            let insDaily = 6000.0;
            if (insTier.includes("Basic")) insDaily = 3500.0;
            else if (insTier.includes("Zero")) insDaily = 9500.0;
            insuranceTotal = insDaily * days;

            if (days >= 7) {
                discount = baseTotal * 0.15;
            }
            deposit = 75000.0;

            document.getElementById('summaryInsuranceRow').style.display = 'flex';
            document.getElementById('summaryChauffeurRow').style.display = 'none';
            document.getElementById('summaryDepositRow').style.display = 'block';
            document.getElementById('summaryInsurancePrice').innerText = formatLKR(insuranceTotal);
        } else {
            const fee = parseFloat(document.getElementById('driverFeeSelect').value) || 6500.0;
            chauffeurTotal = fee * days;
            deposit = 0.0; // No car deposit when driver is supplied

            document.getElementById('summaryInsuranceRow').style.display = 'none';
            document.getElementById('summaryChauffeurRow').style.display = 'flex';
            document.getElementById('summaryDepositRow').style.display = 'none';
            document.getElementById('summaryChauffeurPrice').innerText = formatLKR(chauffeurTotal);
        }

        document.getElementById('summaryBasePrice').innerText = formatLKR(baseTotal);

        if (discount > 0) {
            document.getElementById('summaryDiscountRow').style.display = 'flex';
            document.getElementById('summaryDiscountPrice').innerText = '-' + formatLKR(discount);
        } else {
            document.getElementById('summaryDiscountRow').style.display = 'none';
        }

        const grandTotal = (baseTotal - discount) + insuranceTotal + chauffeurTotal + deposit;
        document.getElementById('summaryGrandTotal').innerText = formatLKR(grandTotal);
    }

    // Set default dates and calculate on page load
    window.addEventListener('DOMContentLoaded', () => {
        const today = new Date();
        const tomorrow = new Date();
        tomorrow.setDate(today.getDate() + 1);
        const returnDay = new Date();
        returnDay.setDate(today.getDate() + 4);

        const formatDate = (d) => d.toISOString().split('T')[0];

        document.getElementById('pickupDateInput').value = formatDate(tomorrow);
        document.getElementById('returnDateInput').value = formatDate(returnDay);
        recalculateRentalTotal();
    });
</script>

<%@ include file="includes/footer.jsp" %>
