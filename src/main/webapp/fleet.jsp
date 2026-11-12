<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.drivehub.model.Vehicle" %>
<%@ page import="com.drivehub.model.CarVehicle" %>
<%@ page import="com.drivehub.model.VanCommercialVehicle" %>

<% request.setAttribute("pageTitle", "Fleet Showroom - DriveHub Vehicle Rental"); %>
<%@ include file="includes/header.jsp" %>

<!-- Showroom Header -->
<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
    <div>
        <div class="d-inline-flex align-items-center gap-2 mb-1">
            <span class="badge-pill-soft badge-soft-indigo">Executive &amp; Commercial</span>
            <span class="text-muted small">&bull; Real-time inventory</span>
        </div>
        <h2 class="display-6 fw-bold heading-brand text-dark mb-0">Vehicle Fleet Showroom</h2>
        <p class="text-secondary small mb-0">Filter, inspect specifications, and instantly reserve luxury cars or high-capacity vans</p>
    </div>
    <div class="d-flex gap-2">
        <a href="${pageContext.request.contextPath}/vehicles?action=manage" class="btn btn-saas-secondary rounded-pill px-3 btn-sm">
            <i class="bi bi-grid-3x3 me-1 text-primary"></i> Inventory Table
        </a>
        <a href="${pageContext.request.contextPath}/rentals?action=book" class="btn btn-saas-primary rounded-pill px-4 btn-sm">
            <i class="bi bi-calendar2-check me-1"></i> Quick Reserve
        </a>
    </div>
</div>

<!-- Interactive SaaS Filter & Search Control Center -->
<div class="saas-card p-3 mb-4">
    <div class="row g-3 align-items-center">
        <!-- Live Search Input -->
        <div class="col-lg-5">
            <div class="input-group">
                <span class="input-group-text bg-light border-end-0 text-muted ps-3"><i class="bi bi-search"></i></span>
                <input type="text" id="liveSearchInput" class="form-control bg-light border-start-0 py-2" 
                       placeholder="Live search by model, fuel, or vehicle ID..." onkeyup="filterFleetCards()">
            </div>
        </div>

        <!-- Filter Category Tabs -->
        <div class="col-lg-7">
            <div class="d-flex flex-wrap gap-2 justify-content-lg-end">
                <button type="button" class="filter-btn active" data-filter="all" onclick="setCategoryFilter('all', this)">
                    <i class="bi bi-grid-fill me-1"></i> All Vehicles
                </button>
                <button type="button" class="filter-btn" data-filter="LUXURY_CAR" onclick="setCategoryFilter('LUXURY_CAR', this)">
                    <i class="bi bi-car-front-fill me-1"></i> Luxury Cars
                </button>
                <button type="button" class="filter-btn" data-filter="COMMERCIAL_VAN" onclick="setCategoryFilter('COMMERCIAL_VAN', this)">
                    <i class="bi bi-truck-front-fill me-1"></i> Passenger &amp; Cargo
                </button>
                <button type="button" class="filter-btn" data-filter="available" onclick="setCategoryFilter('available', this)">
                    <i class="bi bi-check-circle-fill me-1 text-success"></i> Available Now
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Vehicle Fleet Cards Grid -->
<div class="row g-4" id="fleetGridContainer">
    <%
        List<Vehicle> list = (List<Vehicle>) request.getAttribute("vehicleList");
        if (list == null || list.isEmpty()) {
    %>
        <div class="col-12 text-center py-5">
            <div class="p-4 rounded-4 bg-white border d-inline-block text-center shadow-sm">
                <i class="bi bi-car-front fs-1 text-muted"></i>
                <h5 class="mt-3 text-dark fw-bold">No vehicles currently found</h5>
                <p class="text-secondary small mb-3">The vehicle fleet database in <code>data/vehicles.txt</code> is empty or unreadable.</p>
                <a href="${pageContext.request.contextPath}/vehicles?action=add" class="btn btn-saas-primary btn-sm rounded-pill px-4">Register New Vehicle</a>
            </div>
        </div>
    <%
        } else {
            for (Vehicle v : list) {
                boolean isCar = "LUXURY_CAR".equalsIgnoreCase(v.getCategory());
    %>
        <div class="col-md-6 col-lg-4 vehicle-card-item" 
             data-category="<%= v.getCategory() %>" 
             data-available="<%= v.isAvailable() %>"
             data-name="<%= v.getMakeModel().toLowerCase() %>"
             data-id="<%= v.getVehicleId().toLowerCase() %>"
             data-fuel="<%= v.getFuelType().toLowerCase() %>">
            
            <div class="saas-card h-100 d-flex flex-column">
                <div class="vehicle-img-box">
                    <img src="<%= v.getImageUrl() %>" alt="<%= v.getMakeModel() %>" 
                         onerror="this.src='https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800';">
                    
                    <span class="vehicle-category-pill">
                        <%= isCar ? "Sedan &bull; Luxury" : "Van &bull; Commercial" %>
                    </span>
                    
                    <span class="vehicle-seats-pill">
                        <i class="bi bi-people-fill me-1"></i> <%= v.getSeatingCapacity() %> Seats
                    </span>
                </div>

                <div class="p-4 d-flex flex-column flex-grow-1">
                    <!-- Badges row -->
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="badge bg-light text-dark border px-2 py-1 small fw-semibold">
                            <%= v.getTransmission() %> &bull; <%= v.getFuelType() %>
                        </span>
                        <% if (v.isAvailable()) { %>
                            <span class="badge bg-success-subtle text-success px-2 py-1 small fw-semibold">
                                <i class="bi bi-check-circle me-1"></i> Ready for Hire
                            </span>
                        <% } else { %>
                            <span class="badge bg-danger-subtle text-danger px-2 py-1 small fw-semibold">
                                <i class="bi bi-clock-history me-1"></i> On Rental
                            </span>
                        <% } %>
                    </div>

                    <h5 class="fw-bold text-dark mb-1"><%= v.getMakeModel() %></h5>
                    <p class="small text-muted mb-2">Reference ID: <span class="fw-semibold text-dark"><%= v.getVehicleId() %></span></p>

                    <!-- Polymorphic Specifications Card -->
                    <div class="p-2 bg-light rounded-3 small text-secondary mb-3 border">
                        <i class="bi bi-info-circle text-primary me-1"></i> <%= v.getVehicleSpecs() %>
                    </div>

                    <!-- Pricing & CTA footer -->
                    <div class="mt-auto pt-3 border-top d-flex justify-content-between align-items-center">
                        <div>
                            <span class="small text-muted d-block">Base Daily Rate</span>
                            <span class="h5 fw-bold text-primary mb-0">LKR <%= String.format("%,.2f", v.calculateDailyRentalRate()) %></span>
                            <span class="small text-muted">/day</span>
                        </div>
                        
                        <% if (v.isAvailable()) { %>
                            <a href="${pageContext.request.contextPath}/rentals?action=book&vehicleId=<%= v.getVehicleId() %>" 
                               class="btn btn-saas-primary btn-sm px-4 rounded-pill">
                                <i class="bi bi-key-fill me-1"></i> Reserve
                            </a>
                        <% } else { %>
                            <button class="btn btn-secondary btn-sm rounded-pill px-3" disabled>Unavailable</button>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    <%
            }
        }
    %>
</div>

<!-- Interactive Client-side Filter Script -->
<script>
    let activeFilter = 'all';

    function setCategoryFilter(filterType, btnElement) {
        activeFilter = filterType;
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        btnElement.classList.add('active');
        filterFleetCards();
    }

    function filterFleetCards() {
        const query = document.getElementById('liveSearchInput').value.toLowerCase().trim();
        const cards = document.querySelectorAll('.vehicle-card-item');

        cards.forEach(card => {
            const cat = card.getAttribute('data-category');
            const isAvail = card.getAttribute('data-available') === 'true';
            const name = card.getAttribute('data-name');
            const id = card.getAttribute('data-id');
            const fuel = card.getAttribute('data-fuel');

            // Category matching
            let matchesCategory = false;
            if (activeFilter === 'all') {
                matchesCategory = true;
            } else if (activeFilter === 'available') {
                matchesCategory = isAvail;
            } else if (activeFilter === cat) {
                matchesCategory = true;
            }

            // Search query matching
            let matchesSearch = true;
            if (query.length > 0) {
                matchesSearch = name.includes(query) || id.includes(query) || fuel.includes(query);
            }

            if (matchesCategory && matchesSearch) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }
</script>

<%@ include file="includes/footer.jsp" %>
