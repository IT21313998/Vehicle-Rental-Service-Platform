# 🚗 DriveHub - Online Vehicle Rental Management Platform

> **SLIIT SE1020 - Object Oriented Programming (Java) Project Evaluation**  
> **Evaluation Mode:** Laboratory Viva Evaluation & Code Defense  
> **Project Title:** DriveHub Enterprise Vehicle Rental & Reservation System  

---

## 👨‍💻 Student Contribution & Workload Allocation

| Contributor | Student ID | System Module | Responsibilities & Ownership |
| :--- | :--- | :--- | :--- |
| **Member 01 (Lead)** | **IT21313998** | **Vehicle Fleet Management & Admin Subsystem** | Abstract `Vehicle` architecture, concrete classes (`CarVehicle`, `VanCommercialVehicle`), polymorphic dynamic pricing algorithms in LKR, `VehicleDAO` file I/O CRUD engine (`vehicles.txt`), `VehicleServlet` MVC controller, Fleet Admin Dashboard & vehicle management views. |
| **Member 02** | *Partner* | **Rental Reservation & Booking Subsystem** | Abstract `RentalReservation`, `SelfDriveReservation`, `ChauffeurDrivenReservation`, `RentalDAO`, `RentalServlet`, and customer booking views. |

---

## 🏛️ Member 01: Fleet Management & Admin Subsystem Architecture

Member 01 is solely responsible for developing the **Fleet Management and Administration Subsystem**, covering end-to-end Object-Oriented design, business logic, persistent data storage, and MVC presentation.

### 1. Object-Oriented Programming (OOP) Implementation (40 Marks Rubric)

#### A. Abstraction & Abstract Base Class
- **`Vehicle.java`** (`com.drivehub.model`):
  - Defined as an `abstract class` acting as the architectural template for all motorized assets in the fleet.
  - Declares abstract method:
    ```java
    public abstract double calculateRentalCost(int days);
    ```
  - Declares abstract specification contract:
    ```java
    public abstract String getVehicleSpecifications();
    ```
  - Enforces that no generic vehicle can be instantiated without concrete subtype behaviors.

#### B. Inheritance
- **Subclasses:**
  - **`CarVehicle.java`** `extends Vehicle`: Represents luxury and standard sedans/EVs (e.g., Mercedes-Benz, Tesla Model 3) with specialized attributes like `autopilotAvailable` and `trunkCapacityLitres`.
  - **`VanCommercialVehicle.java`** `extends Vehicle`: Represents high-capacity transport/commercial vehicles (e.g., Toyota HiAce Super GL, KDH) with attributes like `cargoCapacityKg` and `slidingDoors`.

#### C. Polymorphism (Method Overriding & Dynamic Binding)
- Both subclasses provide their own distinct implementations of the abstract methods:
  - **`CarVehicle`**:
    - Calculates base daily rate in Sri Lankan Rupees (LKR).
    - If `autopilotAvailable` is enabled, dynamically adds an LKR 5,000/day tech surcharge.
  - **`VanCommercialVehicle`**:
    - Calculates base daily rate in LKR.
    - If `cargoCapacityKg > 1000`, dynamically applies a heavy-load road duty surcharge of LKR 3,500/day.

#### D. Encapsulation & Information Hiding
- All class fields (`vehicleId`, `make`, `model`, `category`, `baseRatePerDay`, `isAvailable`, `fuelType`, `registrationNumber`) are declared `private`.
- Access and mutations are guarded by public getter and setter methods with boundary checks and validation.

---

### 2. Assigned CRUD Operations (10 Marks Rubric)
Member 01 implements **full CRUD** for the fleet inventory via `VehicleDAO.java`:
1. **Create (Register Vehicle):** Adds new cars or commercial vans into the fleet with validation (`saveVehicle()`).
2. **Read (Fleet Catalog & Admin View):** Reads and parses all vehicles into typed object collections (`getAllVehicles()`, `getVehicleById()`).
3. **Update (Modify Specifications):** Edits vehicle details, availability status, and rental prices in LKR (`updateVehicle()`).
4. **Delete (Decommission Vehicle):** Removes retired or decommissioned vehicles safely from inventory (`deleteVehicle()`).

---

### 3. Persistent File Handling (10 Marks Rubric)
- **Data File:** `src/main/webapp/WEB-INF/data/vehicles.txt`
- **Engine:** `VehicleDAO.java` and `FileUtil.java`
- Implements robust I/O streams:
  - **`BufferedReader` / `FileReader`** for fast delimited line-by-line parsing (`VEHICLE_CAR|...` and `VEHICLE_VAN|...`).
  - **`BufferedWriter` / `FileWriter`** with thread-safe file re-writing on create, update, and delete actions.
  - Comprehensive exception handling using `try-with-resources` to prevent file lock leaks.

---

### 4. Controller & Fleet Admin Views
- **Controller:** `VehicleServlet.java` (`com.drivehub.servlet`)
  - Maps to `/vehicles` handling both `doGet` (routing, listing, filtering, edit-form preloading) and `doPost` (register, update, delete).
- **Admin & Fleet UI (JSP):**
  - `fleet.jsp`: Public showroom with card-based vehicle catalog and real-time availability tags in LKR.
  - `manage-fleet.jsp`: Administrative dashboard with full tabular inventory overview, status toggles, edit shortcuts, and delete modals.
  - `add-vehicle.jsp`: Dynamic registration form supporting category-dependent fields (autopilot vs. cargo payload).
  - `edit-vehicle.jsp`: Pre-populated edit view for vehicle spec and pricing updates.

---

## 🗂️ Project Directory Structure

```text
Vehicle_Rental_Platform/
├── pom.xml                                      # Maven dependencies (Jakarta EE 10, Servlet API)
├── README.md                                    # Project documentation & viva defense guide
└── src/
    └── main/
        ├── java/
        │   └── com/drivehub/
        │       ├── dao/
        │       │   ├── FileUtil.java            # Shared file path resolution utility
        │       │   ├── VehicleDAO.java          # [Member 01] File I/O CRUD on vehicles.txt
        │       │   └── RentalDAO.java           # [Member 02] File I/O CRUD on rentals.txt
        │       ├── model/
        │       │   ├── Vehicle.java             # [Member 01] Abstract base class
        │       │   ├── CarVehicle.java          # [Member 01] Subclass (Autopilot, Luxury Car)
        │       │   ├── VanCommercialVehicle.java# [Member 01] Subclass (Cargo capacity, Van)
        │       │   ├── RentalReservation.java   # [Member 02] Abstract reservation
        │       │   ├── SelfDriveReservation.java# [Member 02] Subclass
        │       │   └── ChauffeurDrivenReservation.java # [Member 02] Subclass
        │       └── servlet/
        │           ├── VehicleServlet.java      # [Member 01] Controller for Fleet management
        │           └── RentalServlet.java       # [Member 02] Controller for Reservations
        └── webapp/
            ├── add-vehicle.jsp                  # [Member 01] Admin: Register new vehicle
            ├── edit-vehicle.jsp                 # [Member 01] Admin: Edit vehicle details
            ├── fleet.jsp                        # [Member 01] Public: Vehicle fleet showroom
            ├── manage-fleet.jsp                 # [Member 01] Admin: Full fleet table & CRUD actions
            ├── index.jsp                        # Shared: DriveHub landing page
            ├── book-vehicle.jsp                 # [Member 02] Customer reservation form
            ├── manage-rentals.jsp               # [Member 02] Admin: Booking management
            ├── rental-track.jsp                 # [Member 02] Booking status tracking
            └── WEB-INF/
                ├── web.xml                      # Servlet mappings & deployment descriptor
                └── data/
                    ├── vehicles.txt             # [Member 01] Persistent flat-file storage
                    └── rentals.txt              # [Member 02] Persistent flat-file storage
```

---

## 🚀 How to Run the Application

### Prerequisites
- **Java Development Kit (JDK):** Version 17 or higher
- **Application Server:** Apache Tomcat 10.0+ (Jakarta EE 9/10 compliant)
- **Build Tool:** Apache Maven 3.8+
- **IDE:** IntelliJ IDEA (Community or Ultimate) with **SmartTomcat** plugin

### Steps to Run
1. Open IntelliJ IDEA and open the `Vehicle_Rental_Platform` directory as a Maven project.
2. In IntelliJ, go to **Run > Edit Configurations...**
3. Click `+` and choose **SmartTomcat**.
4. Configure:
   - **Tomcat Server:** `C:\Program Files\Apache Software Foundation\Tomcat 10.0`
   - **Context Path:** `/DriveHub`
   - **Server Port:** `8080`
5. Click **Run** ▶️.
6. Open your browser and navigate to:
   - **Fleet Showroom:** `http://localhost:8080/DriveHub/vehicles?action=list`
   - **Fleet Admin Management:** `http://localhost:8080/DriveHub/vehicles?action=manage`
   - **Register New Vehicle:** `http://localhost:8080/DriveHub/vehicles?action=new`

---

## 📝 Git Commit Evidence & Defense (SE1020 Rubric)
All progressive commits have been authored and logged under:
- **Author:** `IT21313998 <it21313998@my.sliit.lk>`
- **Member 01 Dedicated Branch:** `member-01-standalone`
- **Main Development Branch:** `master`
