# SE1020 – Object Oriented Programming
## Project Workload Distribution & Architectural Specification

**Project Topic:** 01. Vehicle Rental Service Platform  
**System Name:** DriveHub – Premium Vehicle Rental & Chauffeur Fleet Management  
**Team Composition:** 2 Students (Member 01 & Member 02)  
**IDE & Technology Stack:** IntelliJ IDEA | Java (Jakarta Servlets / JSP) | Bootstrap 5 | Text File Read/Write Operations | Apache Tomcat 10  

---

## 1. Project Overview & Deliverables Alignment

In accordance with the **SE1020 Project Description**, this system is developed using Java web technologies in IntelliJ IDEA and uses file read/write operations for persistent data storage instead of a database.

The project is split into two balanced components:
* **Member 01:** Component 01 — Vehicle Fleet & Inventory Management (`vehicles.txt`)
* **Member 02:** Component 02 — Rental Booking & Customer Reservation Management (`rentals.txt`)

---

## 2. Component 01: Vehicle Fleet & Inventory Management

**Assigned Student:** Member 01  
**Description:** Manages the platform's vehicle fleet, category pricing rules, fuel types, transmission mechanisms, seating capacities, and photography.

### A. CRUD Operations (Storage File: `vehicles.txt`)
* **Create (Add New Vehicle):** Register new fleet vehicles (e.g., Mercedes-Benz E-Class, Range Rover Autobiography, Ford Transit Minivan) with ID, make/model, category, daily rate, fuel, transmission, seating, and image URLs.
* **Read (Explore & Filter Fleet):** Search vehicles by make/model/ID, filter by category (`Luxury Sedans & Sports`, `Commercial & Passenger Vans`), and filter by transmission (`Automatic`, `Manual`).
* **Update (Modify Vehicle):** Update base daily rates, transmission, payload/boot specs, or toggle availability.
* **Delete (Decommission Vehicle):** Safely remove decommissioned or retired vehicles from `vehicles.txt`.

### B. UI Components (4 Pages):
1. **`fleet.jsp` (Fleet Catalog Explorer):** Card grid with high-res automotive photography, badges, search bar, and filter controls.
2. **`add-vehicle.jsp` (Vehicle Registration Form):** Form with dynamic category toggles (Autopilot/Trunk for Cars vs. Cargo Payload/Commercial Permit for Vans) and live image preview.
3. **`edit-vehicle.jsp` (Vehicle Editor):** Pre-populated modification form.
4. **`manage-fleet.jsp` (Fleet Inventory Dashboard):** Admin table with thumbnail previews and Quick-Edit / Delete actions.

### C. OOP Concepts Applied:
* **Encapsulation:** Private attributes (`vehicleId`, `makeModel`, `dailyRate`, `seatingCapacity`, `available`) with strict domain setters.
* **Inheritance:** Abstract superclass `Vehicle` extended by `CarVehicle` and `VanCommercialVehicle`.
* **Polymorphism:** Abstract method `calculateDailyRentalRate()` overridden:
  * In `CarVehicle`: calculates AI autopilot/driver-assist tech surcharge (+$25/day).
  * In `VanCommercialVehicle`: incorporates commercial logistics permit fee and heavy cargo payload wear surcharge.
* **Abstraction & Information Hiding:** The servlets communicate via the abstract `Vehicle` type.

---

## 3. Component 02: Rental Booking & Customer Reservation Management

**Assigned Student:** Member 02  
**Description:** Manages customer rental bookings, driver's license verification, insurance protection tiers, executive chauffeur assignments, automated weekly discounts, and return status dispatch.

### A. CRUD Operations (Storage File: `rentals.txt`)
* **Create (Reserve Vehicle):** Place rental reservations with pickup/return dates, rental mode (`Self-Drive` vs. `Chauffeur-Driven`), insurance tiers, and customer contact info.
* **Read (Track Rental Agreement):** Look up reservation by Reservation Number (e.g. `RNT5001`), email, or phone number; view rental contract agreement.
* **Update (Modify Reservation):** Extend rental return dates, update driver info, or advance dispatch statuses (`PENDING` $\rightarrow$ `CONFIRMED` $\rightarrow$ `ACTIVE` $\rightarrow$ `RETURNED`).
* **Delete (Cancel Reservation):** Cancel an active rental prior to pickup and archive the record in `rentals.txt`.

### B. UI Components (4 Pages):
1. **`book-vehicle.jsp` (Rental Booking Wizard):** Interactive form with date picker and live real-time JavaScript cost estimator.
2. **`rental-track.jsp` (Reservation Tracking & Rental Agreement Voucher):** Printable agreement with status badges.
3. **`edit-rental.jsp` (Reservation Rescheduling Form):** Update dates and customer options.
4. **`manage-rentals.jsp` (Operations Dispatch Dashboard):** Master operations table with quick status updater buttons.

### C. OOP Concepts Applied:
* **Encapsulation:** Private fields (`reservationId`, `customerEmail`, `pickupDate`, `rentalDays`, `totalAmount`) with validation.
* **Inheritance:** Abstract superclass `RentalReservation` extended by `SelfDriveReservation` and `ChauffeurDrivenReservation`.
* **Polymorphism:** Abstract method `calculateTotalBill()` overridden:
  * In `SelfDriveReservation`: adds insurance protection tier fee and automatically awards a **15% long-term discount** for rentals $\ge 7$ days.
  * In `ChauffeurDrivenReservation`: incorporates certified professional driver daily fee ($60-$90/day) and airport meet-and-greet surcharge ($50).
* **Abstraction & Information Hiding:** Dispatches all reservations through the `RentalReservation` abstraction.

---

## 4. Marking Guide Alignment (100 Marks per Member)

| Evaluation Category | Marks | Delivery in DriveHub Platform |
| :--- | :---: | :--- |
| **CRUD Operations** | **30** | Complete 4-operation CRUD independently implemented for Member 01 (`vehicles.txt`) and Member 02 (`rentals.txt`). |
| **Application of OOP Concepts** | **20** | Encapsulation, 2 Inheritance hierarchies, Polymorphic rate models, Abstraction, and Information hiding. |
| **File Handling** | **10** | Robust file operations using `BufferedReader`, `BufferedWriter`, CSV parsing, atomic rewrites, and UTF-8 encoding. |
| **User Interface Design** | **10** | High-end responsive Bootstrap 5 interface with high-resolution automotive photography, dynamic estimator, and badges. |
| **GitHub Commit History** | **10** | Individual contribution recorded via feature branches and independent commits. |
| **Presentation & Viva** | **10** | Clean, well-structured Java code designed for defense during questioning. |
| **Documentation & Class Diagrams** | **10** | Complete architectural proposal and UML model relationships. |
| **Total** | **100** | **Full rubric compliance.** |

---

## 5. File Storage Data Formats (`.txt`)

### `data/vehicles.txt`
```text
VEH101,Mercedes-Benz E-Class AMG,LUXURY_CAR,140.00,Hybrid,Automatic,5,https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800,true,540,300.00,true
VEH104,Ford Transit Executive Passenger Van,COMMERCIAL_VAN,110.00,Diesel,Automatic,12,https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=800,1650,50.00,2800,true
```

### `data/rentals.txt`
```text
RNT5001,VEH101,Daniel Craig,daniel.craig@email.com,+1 310 555 0192,2026-11-01,2026-11-05,4,SELF_DRIVE,DL-98234-CA,Unlimited Mileage,Comprehensive Premium,CONFIRMED,760.00
RNT5002,VEH102,Victoria Beckham,v.beckham@fashion.uk,+44 20 7123 4567,2026-11-10,2026-11-14,4,CHAUFFEUR,Central London Hotel,70.00,VIP Airport Meet & Greets,CONFIRMED,1280.00
```
