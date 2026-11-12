</div><!-- End Container -->

<!-- SaaS Footer -->
<footer class="py-5 mt-5" style="background: #0b0f19; border-top: 1px solid rgba(255, 255, 255, 0.08); color: #94a3b8;">
    <div class="container">
        <div class="row g-4 mb-4">
            <div class="col-lg-4 col-md-6">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span style="background: linear-gradient(135deg, #4f46e5 0%, #06b6d4 100%); width: 36px; height: 36px; display: inline-flex; align-items: center; justify-content: center; border-radius: 10px; color: #fff;">
                        <i class="bi bi-speedometer2 fs-5"></i>
                    </span>
                    <span class="fs-4 fw-bold text-white heading-brand">Drive<span style="color: #06b6d4;">Hub</span></span>
                </div>
                <p class="small text-secondary mb-3" style="line-height: 1.7;">
                    Enterprise-grade vehicle rental and chauffeur reservation ecosystem. Designed with clean Object-Oriented Principles, multi-tiered inheritance, and persistent file-backed data storage.
                </p>
                <div class="d-flex gap-2">
                    <span class="badge bg-dark border border-secondary text-light px-3 py-2 rounded-pill small">
                        <i class="bi bi-shield-check text-info me-1"></i> 100% Insured Fleet
                    </span>
                    <span class="badge bg-dark border border-secondary text-light px-3 py-2 rounded-pill small">
                        <i class="bi bi-clock-history text-warning me-1"></i> 24/7 Roadside Assist
                    </span>
                </div>
            </div>

            <div class="col-lg-2 col-md-6">
                <h6 class="text-white text-uppercase fw-bold small mb-3 tracking-wider">Quick Navigation</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2 mb-0">
                    <li><a href="${pageContext.request.contextPath}/index.jsp" class="text-secondary text-decoration-none hover-white">Home Showcase</a></li>
                    <li><a href="${pageContext.request.contextPath}/vehicles?action=list" class="text-secondary text-decoration-none hover-white">Fleet Showroom</a></li>
                    <li><a href="${pageContext.request.contextPath}/rentals?action=book" class="text-secondary text-decoration-none hover-white">Instant Booking</a></li>
                    <li><a href="${pageContext.request.contextPath}/rentals?action=track" class="text-secondary text-decoration-none hover-white">Track Reservation</a></li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6">
                <h6 class="text-white text-uppercase fw-bold small mb-3 tracking-wider">OOP Architecture</h6>
                <ul class="list-unstyled small d-flex flex-column gap-2 mb-0">
                    <li class="text-secondary"><strong class="text-light">Member 01:</strong> Vehicle Fleet DAO &amp; Models (Car &amp; Commercial Van)</li>
                    <li class="text-secondary"><strong class="text-light">Member 02:</strong> Rental Reservation DAO &amp; Models (Self-Drive &amp; Chauffeur)</li>
                    <li class="text-secondary"><strong class="text-light">Persistence:</strong> <code>vehicles.txt</code> &bull; <code>rentals.txt</code></li>
                </ul>
            </div>

            <div class="col-lg-3 col-md-6">
                <h6 class="text-white text-uppercase fw-bold small mb-3 tracking-wider">Project Runtime</h6>
                <div class="p-3 rounded-3" style="background: rgba(255, 255, 255, 0.04); border: 1px solid rgba(255, 255, 255, 0.08);">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <span class="small text-secondary">Target Container:</span>
                        <span class="badge bg-primary-subtle text-primary fw-semibold">Apache Tomcat 10</span>
                    </div>
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <span class="small text-secondary">Specification:</span>
                        <span class="badge bg-info-subtle text-info fw-semibold">Jakarta EE 5.0</span>
                    </div>
                    <div class="d-flex align-items-center justify-content-between">
                        <span class="small text-secondary">Compiler Target:</span>
                        <span class="badge bg-success-subtle text-success fw-semibold">Java 17/21 LTS</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="pt-4 border-top border-dark d-flex flex-wrap justify-content-between align-items-center gap-2 small text-muted">
            <div>
                &copy; <%= java.time.Year.now().getValue() %> DriveHub Vehicle Rental Services. Academic project developed for SLIIT SE1020 OOP.
            </div>
            <div>
                Crafted with Java Servlets, JSP &amp; Bootstrap 5
            </div>
        </div>
    </div>
</footer>

<style>
    .hover-white:hover {
        color: #ffffff !important;
        transition: color 0.2s ease;
    }
</style>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
