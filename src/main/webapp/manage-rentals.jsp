<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.drivehub.model.RentalReservation" %>

<% request.setAttribute("pageTitle", "Fleet Dispatch & Rentals Roster - Member 02"); %>
<%@ include file="includes/header.jsp" %>

<%
    List<RentalReservation> list = (List<RentalReservation>) request.getAttribute("rentalList");
    int totalCount = (list != null ? list.size() : 0);
    int activeCount = 0;
    int confirmedCount = 0;
    double totalRevenue = 0.0;

    if (list != null) {
        for (RentalReservation r : list) {
            String st = r.getStatus().toUpperCase();
            if ("ACTIVE".equals(st)) activeCount++;
            if ("CONFIRMED".equals(st)) confirmedCount++;
            if (!"CANCELLED".equals(st)) totalRevenue += r.getTotalAmount();
        }
    }
%>

<!-- Dispatch Dashboard Header -->
<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
    <div>
        <div class="d-inline-flex align-items-center gap-2 mb-1">
            <span class="badge-pill-soft badge-soft-emerald">Member 02 Component</span>
            <span class="text-muted small">&bull; Direct CRUD &bull; <code>data/rentals.txt</code></span>
        </div>
        <h2 class="display-6 fw-bold heading-brand text-dark mb-0">Rental Dispatch &amp; Operations</h2>
        <p class="text-secondary small mb-0">Manage customer bookings, dispatch status, chauffeur assignments, and ledger records.</p>
    </div>
    <div class="d-flex gap-2">
        <a href="${pageContext.request.contextPath}/rentals?action=track" class="btn btn-saas-secondary rounded-pill px-3 btn-sm">
            <i class="bi bi-search me-1 text-primary"></i> Track Booking
        </a>
        <a href="${pageContext.request.contextPath}/rentals?action=book" class="btn btn-saas-primary rounded-pill px-4 btn-sm">
            <i class="bi bi-plus-circle me-1"></i> New Reservation
        </a>
    </div>
</div>

<!-- SaaS Metrics Summary Row -->
<div class="row g-3 mb-4">
    <div class="col-6 col-md-3">
        <div class="stat-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-muted small fw-semibold">Total Bookings</span>
                <span class="badge bg-primary-subtle text-primary"><i class="bi bi-journal-bookmark"></i></span>
            </div>
            <h3 class="fw-bold heading-brand text-dark mb-0"><%= totalCount %></h3>
            <span class="small text-muted">Contracts recorded</span>
        </div>
    </div>
    <div class="col-6 col-md-3">
        <div class="stat-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-muted small fw-semibold">Confirmed Bookings</span>
                <span class="badge bg-info-subtle text-info"><i class="bi bi-check2-circle"></i></span>
            </div>
            <h3 class="fw-bold heading-brand text-dark mb-0"><%= confirmedCount %></h3>
            <span class="small text-muted">Awaiting vehicle pickup</span>
        </div>
    </div>
    <div class="col-6 col-md-3">
        <div class="stat-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-muted small fw-semibold">On the Road</span>
                <span class="badge bg-warning-subtle text-warning"><i class="bi bi-speedometer"></i></span>
            </div>
            <h3 class="fw-bold heading-brand text-dark mb-0"><%= activeCount %></h3>
            <span class="small text-muted">Currently active trips</span>
        </div>
    </div>
    <div class="col-6 col-md-3">
        <div class="stat-card">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-muted small fw-semibold">Cumulative Value</span>
                <span class="badge bg-success-subtle text-success"><i class="bi bi-currency-dollar"></i></span>
            </div>
            <h3 class="fw-bold heading-brand text-success mb-0">LKR <%= String.format("%,.2f", totalRevenue) %></h3>
            <span class="small text-muted">Confirmed gross billings</span>
        </div>
    </div>
</div>

<!-- Rentals Ledger Card -->
<div class="saas-card overflow-hidden">
    <div class="p-3 border-bottom d-flex justify-content-between align-items-center flex-wrap gap-3">
        <div class="d-flex align-items-center gap-2">
            <h6 class="mb-0 fw-bold text-dark"><i class="bi bi-journal-text me-2 text-success"></i>Reservation Registry</h6>
            <span class="badge bg-light text-secondary border"><%= totalCount %> Contracts</span>
        </div>
        <div style="min-width: 250px;">
            <input type="text" id="rentalFilterInput" class="form-control form-control-sm bg-light" 
                   placeholder="Filter by customer, ID, or vehicle..." onkeyup="filterRentalRows()">
        </div>
    </div>

    <div class="table-responsive">
        <table class="saas-table" id="rentalsTable">
            <thead>
                <tr>
                    <th scope="col">Reservation</th>
                    <th scope="col">Customer Details</th>
                    <th scope="col">Vehicle Code</th>
                    <th scope="col">Schedule &amp; Duration</th>
                    <th scope="col">Specifications &amp; Terms</th>
                    <th scope="col">Total Bill</th>
                    <th scope="col">Status</th>
                    <th scope="col" class="text-center">Dispatch Transition</th>
                    <th scope="col" class="text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (list == null || list.isEmpty()) {
                %>
                    <tr>
                        <td colspan="9" class="text-center py-5 text-muted">
                            <i class="bi bi-inbox fs-2 text-secondary d-block mb-2"></i>
                            No rental reservations recorded in <code>data/rentals.txt</code>.
                        </td>
                    </tr>
                <%
                    } else {
                        for (RentalReservation r : list) {
                            String st = r.getStatus().toUpperCase();
                            String badgeClass = "badge-soft-amber";
                            if ("RETURNED".equals(st) || "CONFIRMED".equals(st)) badgeClass = "badge-soft-emerald";
                            if ("CANCELLED".equals(st)) badgeClass = "badge-soft-rose";
                            if ("ACTIVE".equals(st)) badgeClass = "badge-soft-indigo";
                %>
                    <tr class="rental-row">
                        <td>
                            <div class="fw-bold text-primary"><%= r.getReservationId() %></div>
                            <span class="badge bg-light text-muted border small"><%= r.getRentalType() %></span>
                        </td>
                        <td>
                            <div class="fw-bold text-dark"><%= r.getCustomerName() %></div>
                            <div class="small text-muted"><i class="bi bi-envelope me-1"></i><%= r.getCustomerEmail() %></div>
                            <div class="small text-muted"><i class="bi bi-telephone me-1"></i><%= r.getCustomerPhone() %></div>
                        </td>
                        <td>
                            <span class="badge bg-light text-dark border px-2 py-1"><i class="bi bi-car-front me-1"></i><%= r.getVehicleId() %></span>
                        </td>
                        <td>
                            <div class="small fw-semibold text-dark"><%= r.getPickupDate() %> &rarr; <%= r.getReturnDate() %></div>
                            <span class="badge bg-secondary-subtle text-dark small"><%= r.getRentalDays() %> Days Duration</span>
                        </td>
                        <td class="small text-secondary" style="max-width: 240px;">
                            <div class="p-2 rounded-2 bg-light border">
                                <%= r.getRentalSummary() %>
                            </div>
                        </td>
                        <td>
                            <div class="h6 fw-bold text-primary mb-0">LKR <%= String.format("%,.2f", r.getTotalAmount()) %></div>
                        </td>
                        <td>
                            <span class="badge-pill-soft <%= badgeClass %>"><%= st %></span>
                        </td>
                        <td class="text-center" style="min-width: 180px;">
                            <form action="${pageContext.request.contextPath}/rentals" method="post" class="d-flex gap-1 justify-content-center">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>">
                                <select name="newStatus" class="form-select form-select-sm" style="font-size: 0.8rem;">
                                    <option value="PENDING" <%= "PENDING".equals(st) ? "selected" : "" %>>PENDING</option>
                                    <option value="CONFIRMED" <%= "CONFIRMED".equals(st) ? "selected" : "" %>>CONFIRMED</option>
                                    <option value="ACTIVE" <%= "ACTIVE".equals(st) ? "selected" : "" %>>ACTIVE</option>
                                    <option value="RETURNED" <%= "RETURNED".equals(st) ? "selected" : "" %>>RETURNED</option>
                                    <option value="CANCELLED" <%= "CANCELLED".equals(st) ? "selected" : "" %>>CANCELLED</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-outline-secondary" title="Save Status">
                                    <i class="bi bi-check-lg"></i>
                                </button>
                            </form>
                        </td>
                        <td class="text-end">
                            <div class="btn-group btn-group-sm">
                                <a href="${pageContext.request.contextPath}/rentals?action=edit&id=<%= r.getReservationId() %>" 
                                   class="btn btn-outline-secondary" title="Edit Reservation">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/rentals?action=delete&id=<%= r.getReservationId() %>" 
                                   class="btn btn-outline-danger" title="Cancel & Delete Contract"
                                   onclick="return confirm('Permanently remove reservation <%= r.getReservationId() %> from rentals.txt?');">
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
    function filterRentalRows() {
        const query = document.getElementById('rentalFilterInput').value.toLowerCase().trim();
        const rows = document.querySelectorAll('.rental-row');
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
