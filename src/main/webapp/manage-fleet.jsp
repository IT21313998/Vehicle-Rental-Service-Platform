<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.drivehub.model.Vehicle" %>
<%@ page import="com.drivehub.model.CarVehicle" %>
<%@ page import="com.drivehub.model.VanCommercialVehicle" %>

<% request.setAttribute("pageTitle", "Fleet Inventory Management - Member 01"); %>
<%@ include file="includes/header.jsp" %>

<%
    List<Vehicle> list = (List<Vehicle>) request.getAttribute("vehicleList");
    int totalCount = (list != null ? list.size() : 0);
    int luxuryCount = 0;
    int commercialCount = 0;
    int availableCount = 0;
    if (list != null) {
        for (Vehicle v : list) {
            if ("LUXURY_CAR".equalsIgnoreCase(v.getCategory())) luxuryCount++;
            else commercialCount++;
            if (v.isAvailable()) availableCount++;
        }
    }
%>

<!-- Dashboard Header -->
<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
    <div>
        <div class="d-inline-flex align-items-center gap-2 mb-1">
            <span class="badge-pill-soft badge-soft-indigo">Member 01 Component</span>
            <span class="text-muted small">&bull; Direct CRUD &bull; <code>data/vehicles.txt</code></span>
        </div>
        <h2 class="display-6 fw-bold heading-brand text-dark mb-0">Fleet Inventory Console</h2>
        <p class="text-secondary small mb-0">Register, inspect, price, and decommission vehicles in the active registry.</p>
    </div>
    <div class="d-flex gap-2">
        <a href="${pageContext.request.contextPath}/vehicles?action=list" class="btn btn-saas-secondary rounded-pill px-3 btn-sm">
            <i class="bi bi-eye me-1 text-primary"></i> Public Showroom
        </a>
        <a href="${pageContext.request.contextPath}/vehicles?action=add" class="btn btn-saas-primary rounded-pill px-4 btn-sm">
            <i class="bi bi-plus-circle me-1"></i> Register New Vehicle
        </a>
    </div>
</div>

<!-- SaaS Metrics Summary Row -->
<div class="row g-3 mb-4">
    <div class="col-6 col-md-3">
        <div class="stat-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-muted small fw-semibold">Total Fleet</span>
                <span class="badge bg-primary-subtle text-primary"><i class="bi bi-car-front"></i></span>
            </div>
            <h3 class="fw-bold heading-brand text-dark mb-0"><%= totalCount %></h3>
            <span class="small text-muted">Vehicles on record</span>
        </div>
    </div>
    <div class="col-6 col-md-3">
        <div class="stat-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-muted small fw-semibold">Luxury Sedans &amp; SUVs</span>
                <span class="badge bg-info-subtle text-info"><i class="bi bi-gem"></i></span>
            </div>
            <h3 class="fw-bold heading-brand text-dark mb-0"><%= luxuryCount %></h3>
            <span class="small text-muted">Executive models</span>
        </div>
    </div>
    <div class="col-6 col-md-3">
        <div class="stat-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-muted small fw-semibold">Commercial Vans</span>
                <span class="badge bg-warning-subtle text-warning"><i class="bi bi-truck"></i></span>
            </div>
            <h3 class="fw-bold heading-brand text-dark mb-0"><%= commercialCount %></h3>
            <span class="small text-muted">Passenger &amp; cargo</span>
        </div>
    </div>
    <div class="col-6 col-md-3">
        <div class="stat-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-muted small fw-semibold">Ready for Dispatch</span>
                <span class="badge bg-success-subtle text-success"><i class="bi bi-check-circle"></i></span>
            </div>
            <h3 class="fw-bold heading-brand text-dark mb-0"><%= availableCount %></h3>
            <span class="small text-muted">Immediate rental</span>
        </div>
    </div>
</div>

<!-- Fleet Management Table Card -->
<div class="saas-card overflow-hidden">
    <div class="p-3 border-bottom d-flex justify-content-between align-items-center flex-wrap gap-3">
        <div class="d-flex align-items-center gap-2">
            <h6 class="mb-0 fw-bold text-dark"><i class="bi bi-list-check me-2 text-primary"></i>Active Fleet Registry</h6>
            <span class="badge bg-light text-secondary border"><%= totalCount %> Records</span>
        </div>
        <div style="min-width: 250px;">
            <input type="text" id="tableFilterInput" class="form-control form-control-sm bg-light" 
                   placeholder="Filter records..." onkeyup="filterTableRows()">
        </div>
    </div>

    <div class="table-responsive">
        <table class="saas-table" id="fleetTable">
            <thead>
                <tr>
                    <th scope="col">Vehicle</th>
                    <th scope="col">Category</th>
                    <th scope="col">Powertrain &amp; Capacity</th>
                    <th scope="col">Specialized Specs</th>
                    <th scope="col">Base Rate</th>
                    <th scope="col">Calculated Rental</th>
                    <th scope="col">Status</th>
                    <th scope="col" class="text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (list == null || list.isEmpty()) {
                %>
                    <tr>
                        <td colspan="8" class="text-center py-5 text-muted">
                            <i class="bi bi-inbox fs-2 text-secondary d-block mb-2"></i>
                            No vehicles currently stored in <code>data/vehicles.txt</code>.
                        </td>
                    </tr>
                <%
                    } else {
                        for (Vehicle v : list) {
                            boolean isCar = "LUXURY_CAR".equalsIgnoreCase(v.getCategory());
                %>
                    <tr class="fleet-row">
                        <td>
                            <div class="d-flex align-items-center gap-3">
                                <img src="<%= v.getImageUrl() %>" alt="thumb" 
                                     style="width: 56px; height: 56px; object-fit: cover; border-radius: 10px; border: 1px solid #e2e8f0;"
                                     onerror="this.src='https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800';">
                                <div>
                                    <div class="fw-bold text-dark row-title"><%= v.getMakeModel() %></div>
                                    <span class="badge bg-light text-muted border row-id"><%= v.getVehicleId() %></span>
                                </div>
                            </div>
                        </td>
                        <td>
                            <span class="badge-pill-soft <%= isCar ? "badge-soft-indigo" : "badge-soft-amber" %>">
                                <%= isCar ? "Luxury Sedan/SUV" : "Commercial Van" %>
                            </span>
                        </td>
                        <td>
                            <div class="small text-secondary">
                                <div><i class="bi bi-gear me-1"></i><%= v.getTransmission() %> &bull; <%= v.getFuelType() %></div>
                                <div><i class="bi bi-people me-1"></i><%= v.getSeatingCapacity() %> Passengers</div>
                            </div>
                        </td>
                        <td class="small text-secondary" style="max-width: 240px;">
                            <div class="p-2 rounded-2 bg-light border">
                                <%= v.getVehicleSpecs() %>
                            </div>
                        </td>
                        <td>
                            <span class="text-secondary small">LKR <%= String.format("%,.2f", v.getDailyRate()) %></span>
                        </td>
                        <td>
                            <span class="fw-bold text-primary">LKR <%= String.format("%,.2f", v.calculateDailyRentalRate()) %></span>
                            <span class="small text-muted">/day</span>
                        </td>
                        <td>
                            <% if (v.isAvailable()) { %>
                                <span class="badge-pill-soft badge-soft-emerald">
                                    <i class="bi bi-check-circle-fill me-1"></i> Available
                                </span>
                            <% } else { %>
                                <span class="badge-pill-soft badge-soft-rose">
                                    <i class="bi bi-clock-fill me-1"></i> On Hire
                                </span>
                            <% } %>
                        </td>
                        <td class="text-end">
                            <div class="btn-group btn-group-sm">
                                <a href="${pageContext.request.contextPath}/vehicles?action=edit&id=<%= v.getVehicleId() %>" 
                                   class="btn btn-outline-secondary" title="Edit Vehicle Details">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/vehicles?action=delete&id=<%= v.getVehicleId() %>" 
                                   class="btn btn-outline-danger" title="Decommission Vehicle"
                                   onclick="return confirm('Confirm removal of <%= v.getMakeModel() %> (<%= v.getVehicleId() %>) from vehicles.txt?');">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<script>
    function filterTableRows() {
        const query = document.getElementById('tableFilterInput').value.toLowerCase().trim();
        const rows = document.querySelectorAll('.fleet-row');
        rows.forEach(r => {
            const text = r.innerText.toLowerCase();
            if (text.includes(query)) {
                r.style.display = '';
            } else {
                r.style.display = 'none';
            }
        });
    }
</script>

<%@ include file="includes/footer.jsp" %>
