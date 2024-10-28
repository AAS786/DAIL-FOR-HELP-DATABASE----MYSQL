create database dialforhelp;
use dialforhelp;

-- 1. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    Full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    address TEXT,
    role varchar(90) NOT NULL
);

-- 2. Service_Providers Table
CREATE TABLE Service_Providers (
    provider_id INT PRIMARY KEY AUTO_INCREMENT,
    Full_name VARCHAR(100) NOT NULL,
    service_category_id INT,
    contact_info TEXT,
    experience INT, -- years of experience
    rating DECIMAL(2, 1),
    location_id INT,
    availability_status ENUM('available', 'unavailable') NOT NULL,
    FOREIGN KEY (service_category_id) REFERENCES Service_Categories(service_category_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- 3. Service_Categories Table
CREATE TABLE Service_Categories (
    service_category_id INT PRIMARY KEY AUTO_INCREMENT,
    Full_name VARCHAR(100) NOT NULL,
    Description TEXT,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES Service_Categories(service_category_id)
);

-- 4. Requests Table
CREATE TABLE Requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    provider_id INT,
    service_category_id INT NOT NULL,
    description TEXT,
    status ENUM('pending', 'accepted', 'completed') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (provider_id) REFERENCES Service_Providers(provider_id),
    FOREIGN KEY (service_category_id) REFERENCES Service_Categories(service_category_id)
);

-- 5. Reviews Table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    request_id INT NOT NULL,
    user_id INT NOT NULL,
    provider_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    FOREIGN KEY (request_id) REFERENCES Requests(request_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (provider_id) REFERENCES Service_Providers(provider_id)
);

-- 6. Locations Table
CREATE TABLE Locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    zipcode VARCHAR(10),
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6)
);

-- 7. Service_Availability Table
CREATE TABLE Service_Availability (
    availability_id INT PRIMARY KEY AUTO_INCREMENT,
    provider_id INT NOT NULL,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    start_time TIME,
    end_time TIME,
    is_available ENUM('Yes', 'No'),
    FOREIGN KEY (provider_id) REFERENCES Service_Providers(provider_id)
);

-- 8. Payment Table
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    request_id INT NOT NULL,
    user_id INT NOT NULL,
    provider_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('pending', 'completed') DEFAULT 'pending',
    payment_method ENUM( 'debit_card', 'UPI', 'net_banking', 'cash'),
    FOREIGN KEY (request_id) REFERENCES Requests(request_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (provider_id) REFERENCES Service_Providers(provider_id)
);

-- 9. Notifications Table
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    provider_id INT,
    message TEXT NOT NULL,
    notification_type ENUM('new_request', 'service_update', 'offer', 'reminder') NOT NULL,
    is_read ENUM ('Read', 'Unread'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (provider_id) REFERENCES Service_Providers(provider_id)
);

-- 10. Service_History Table
CREATE TABLE Service_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    provider_id INT NOT NULL,
    service_category_id INT NOT NULL,
    service_description TEXT,
    service_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completion_status ENUM('completed', 'cancelled') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (provider_id) REFERENCES Service_Providers(provider_id),
    FOREIGN KEY (service_category_id) REFERENCES Service_Categories(service_category_id)
);

-- INSERT VALUES --

INSERT INTO Users (Full_name, email, phone_number, address, role) VALUES
('Amit Sharma', 'amit.sharma@example.com', '9876543210', '123, MG Road, Mumbai, Maharashtra', 'customer'),
('Rahul Mehta', 'rahul.mehta@example.com', '9876543211', '456, Brigade Road, Bengaluru, Karnataka', 'customer'),
('Sneha Verma', 'sneha.verma@example.com', '9876543212', '789, Anna Nagar, Chennai, Tamil Nadu', 'customer'),
('Karan Singh', 'karan.singh@example.com', '9876543213', '101, Park Street, Kolkata, West Bengal', 'customer'),
('Pooja Gupta', 'pooja.gupta@example.com', '9876543214', '121, Connaught Place, Delhi', 'customer'),
('Vikram Desai', 'vikram.desai@example.com', '9876543215', '135, MG Road, Ahmedabad, Gujarat', 'customer'),
('Riya Patel', 'riya.patel@example.com', '9876543216', '147, Churchgate, Mumbai, Maharashtra', 'customer'),
('Anil Yadav', 'anil.yadav@example.com', '9876543217', '258, Brigade Road, Bengaluru, Karnataka', 'service_provider'),
('Sunita Rao', 'sunita.rao@example.com', '9876543218', '369, Nungambakkam, Chennai, Tamil Nadu', 'customer'),
('Nitin Jain', 'nitin.jain@example.com', '9876543219', '741, Salt Lake, Kolkata, West Bengal', 'customer'),
('Deepak Nair', 'deepak.nair@example.com', '9876543220', '852, Connaught Place, Delhi', 'service_provider'),
('Meera Kaur', 'meera.kaur@example.com', '9876543221', '963, Ellis Bridge, Ahmedabad, Gujarat', 'customer'),
('Rajesh Iyer', 'rajesh.iyer@example.com', '9876543222', '147, Hennur, Bengaluru, Karnataka', 'service_provider'),
('Tanya Singh', 'tanya.singh@example.com', '9876543223', '258, Kotturpuram, Chennai, Tamil Nadu', 'customer'),
('Suresh Bansal', 'suresh.bansal@example.com', '9876543224', '369, Jadavpur, Kolkata, West Bengal', 'service_provider'),
('Kriti Sethi', 'kriti.sethi@example.com', '9876543225', '741, Noida Sector 15, Delhi', 'customer'),
('Vinay Malhotra', 'vinay.malhotra@example.com', '9876543226', '852, Maninagar, Ahmedabad, Gujarat', 'customer'),
('Rohit Sharma', 'rohit.sharma@example.com', '9876543227', '963, Koramangala, Bengaluru, Karnataka', 'service_provider'),
('Shilpa Agrawal', 'shilpa.agrawal@example.com', '9876543228', '147, Nungambakkam, Chennai, Tamil Nadu', 'customer'),
('Aakash Mehta', 'aakash.mehta@example.com', '9876543229', '258, Salt Lake, Kolkata, West Bengal', 'customer'),
('Kajal Jain', 'kajal.jain@example.com', '9876543230', '369, Connaught Place, Delhi', 'customer');

select * from Service_Providers;
INSERT INTO Service_Providers (Full_name, service_category_id, contact_info, experience, rating, location_id, availability_status) VALUES
('Amit Kumar', 1, 'amit.kumar@example.com, 9876543210', 5, 4.5, 1, 'available'), -- Plumber
('Rajesh Mehta', 2, 'rajesh.mehta@example.com, 9876543211', 7, 4.2, 2, 'available'), -- Electrician
('Neha Gupta', 3, 'neha.gupta@example.com, 9876543212', 3, 4.8, 3, 'available'), -- AC Mechanic
('Karan Singh', 4, 'karan.singh@example.com, 9876543213', 6, 4.0, 4, 'unavailable'), -- TV Repair
('Pooja Sharma', 5, 'pooja.sharma@example.com, 9876543214', 4, 4.7, 5, 'available'), -- RO Service
('Vikram Desai', 6, 'vikram.desai@example.com, 9876543215', 5, 4.1, 6, 'available'), -- Pest Control
('Sunil Yadav', 7, 'sunil.yadav@example.com, 9876543216', 8, 4.5, 1, 'unavailable'), -- Carpenter
('Riya Patel', 8, 'riya.patel@example.com, 9876543217', 3, 4.6, 2, 'available'), -- Painter
('Anil Nair', 9, 'anil.nair@example.com, 9876543218', 10, 4.3, 3, 'available'), -- Plumber
('Deepak Sharma', 10, 'deepak.sharma@example.com, 9876543219', 5, 4.0, 4, 'available'), -- Electrician
('Kajal Jain', 11, 'kajal.jain@example.com, 9876543220', 2, 4.2, 5, 'available'), -- AC Mechanic
('Rohit Iyer', 12, 'rohit.iyer@example.com, 9876543221', 7, 4.5, 6, 'unavailable'), -- TV Repair
('Shilpa Agarwal', 13, 'shilpa.agarwal@example.com, 9876543222', 1, 4.1, 1, 'available'), -- RO Service
('Ajay Kumar', 14, 'ajay.kumar@example.com, 9876543223', 6, 4.3, 1, 'available'), -- Pest Control
('Nitin Deshmukh', 15, 'nitin.deshmukh@example.com, 9876543224', 5, 4.0, 2, 'unavailable'), -- Carpenter
('Sanjay Verma', 16, 'sanjay.verma@example.com, 9876543225', 9, 4.4, 3, 'available'), -- Painter
('Tanya Singh', 17, 'tanya.singh@example.com, 9876543226', 3, 4.6, 5, 'available'), -- Plumber
('Meera Nair', 18, 'meera.nair@example.com, 9876543227', 2, 4.2, 6, 'available'), -- Electrician
('Vinay Patil', 19, 'vinay.patil@example.com, 9876543228', 4, 4.3, 1, 'available'), -- AC Mechanic
('Rahul Joshi', 20, 'rahul.joshi@example.com, 9876543229', 8, 4.5, 2, 'unavailable'), -- TV Repair
('Anjali Gupta', 1, 'anjali.gupta@example.com, 9876543230', 1, 4.7, 3, 'available'), -- RO Service
('Suresh Bansal', 3, 'suresh.bansal@example.com, 9876543231', 6, 4.0, 6, 'available'), -- Pest Control
('Kiran Malhotra', 3, 'kiran.malhotra@example.com, 9876543232', 5, 4.4, 1, 'unavailable'), -- Carpenter
('Ramesh Yadav', 2, 'ramesh.yadav@example.com, 9876543233', 4, 4.2, 4, 'available'), -- Painter
('Aakash Bhatia', 5, 'aakash.bhatia@example.com, 9876543234', 7, 4.5, 5, 'available'), -- Plumber
('Shweta Soni', 6, 'shweta.soni@example.com, 9876543235', 2, 4.3, 6, 'available'), -- Electrician
('Kartik Jain', 8, 'kartik.jain@example.com, 9876543236', 3, 4.1, 2, 'unavailable'), -- AC Mechanic
('Parul Mishra', 8, 'parul.mishra@example.com, 9876543237', 8, 4.0, 1, 'available'), -- TV Repair
('Devendra Rao', 9, 'devendra.rao@example.com, 9876543238', 5, 4.6, 3, 'available'), -- RO Service
('Geeta Yadav', 11, 'geeta.yadav@example.com, 9876543239', 6, 4.2, 4, 'unavailable'), -- Pest Control
('Manoj Singh', 12, 'manoj.singh@example.com, 9876543240', 4, 4.5, 6, 'available'), -- Carpenter
('Priya Kapoor', 13, 'priya.kapoor@example.com, 9876543241', 9, 4.7, 3, 'available'), -- Painter
('Harish Sethi', 13, 'harish.sethi@example.com, 9876543242', 3, 4.3, 4, 'available'), -- Plumber
('Nisha Verma', 14, 'nisha.verma@example.com, 9876543243', 1, 4.6, 2, 'unavailable'), -- Electrician
('Ravi Kumar', 8, 'ravi.kumar@example.com, 9876543244', 6, 4.1, 3, 'available'), -- AC Mechanic
('Geeta Rani', 15, 'geeta.rani@example.com, 9876543245', 8, 4.5, 3, 'available'), -- TV Repair
('Rajender Das', 6, 'rajender.das@example.com, 9876543246', 4, 4.4, 4, 'unavailable'), -- RO Service
('Veena Singh', 8, 'veena.singh@example.com, 9876543247', 5, 4.2, 3, 'available'), -- Pest Control
('Sanjay Sharma', 9, 'sanjay.sharma@example.com, 9876543248', 2, 4.3, 3, 'available'), -- Carpenter
('Renu Kapoor', 13, 'renu.kapoor@example.com, 9876543249', 3, 4.1, 4, 'unavailable'); -- Painter

select * from Service_Categories;
INSERT INTO Service_Categories (Full_name, Description, parent_category_id) VALUES
('Plumbing', 'Services related to installation and repair of piping systems.', NULL),
('Electrical', 'Services involving electrical systems, wiring, and installations.', NULL),
('AC Repair', 'Repair and maintenance services for air conditioning units.', NULL),
('TV Repair', 'Services for the repair and maintenance of television sets.', NULL),
('RO Service', 'Repair and maintenance of Reverse Osmosis water purifiers.', NULL),
('Pest Control', 'Services for the management and elimination of pests.', NULL),
('Carpentry', 'Services related to woodworking and installation of wooden structures.', NULL),
('Painting', 'Services for painting and decorating buildings and structures.', NULL),
('HVAC', 'Heating, ventilation, and air conditioning services.', NULL),
('Landscaping', 'Services related to the design and maintenance of outdoor spaces.', NULL),
('Cleaning', 'Residential and commercial cleaning services.', NULL),
('Moving', 'Services for residential and commercial moving.', NULL),
('Home Security', 'Installation and maintenance of security systems for homes.', NULL),
('Appliance Repair', 'Repair services for household appliances like washers and dryers.', NULL),
('Roofing', 'Services related to installation and repair of roofs.', NULL),
('Masonry', 'Services for brick, stone, and concrete work.', NULL),
('Flooring', 'Installation and repair services for various flooring types.', NULL),
('Window Installation', 'Services for the installation of windows and glass fixtures.', NULL),
('Siding', 'Installation and repair of exterior siding for buildings.', NULL),
('Gutter Cleaning', 'Cleaning and maintenance services for gutters and downspouts.', NULL);


INSERT INTO Requests (user_id, provider_id, service_category_id, description, status) VALUES
(1, 81, 1, 'Leaking faucet in the kitchen needs urgent repair.', 'pending'),
(1, 82, 2, 'Need electrical wiring for new lighting installation.', 'pending'),
(1, 83, 3, 'AC not cooling properly; need a technician.', 'pending'),
(2, 84, 4, 'Television screen is cracked, requires repair.', 'pending'),
(2, 85, 5, 'RO water purifier is leaking, needs service.', 'pending'),
(3, 86, 6, 'Cockroach infestation in the kitchen; need pest control.', 'pending'),
(3, 87, 7, 'Need carpenter to install new shelves.', 'pending'),
(4, 88, 8, 'House painting required before the festival.', 'pending'),
(4, 89, 9, 'Need HVAC maintenance for summer.', 'pending'),
(5, 90, 10, 'Cleaning service required for entire house.', 'pending'),
(1, 91, 11, 'Bathroom sink is clogged; requires immediate attention.', 'pending'),
(1, 93, 12, 'AC unit needs servicing before summer.', 'pending'),
(6, 92, 13, 'Wiring issues in the living room.', 'pending'),
(2, 94, 14, 'Need TV wall mounting and installation.', 'pending'),
(5, 96, 15, 'Termite problem in the wooden furniture.', 'pending'),
(7, 97, 16, 'Build a new wooden cabinet in the bedroom.', 'pending'),
(8, 98, 17, 'Exterior house painting required.', 'pending'),
(3, 109, 18, 'Service required for heating system.', 'pending'),
(4, 100, 19, 'Deep cleaning for carpet and upholstery.', 'pending'),
(1, 111, 20, 'Toilet flush is not working; urgent repair needed.', 'pending'),
(2, 120, 1, 'RO filter replacement required.', 'pending'),
(3, 117, 1, 'Need cleaning service after a party.', 'pending'),
(4, 114, 3, 'Get rid of mosquitoes in the backyard.', 'pending'),
(5, 117, 4, 'Fix broken window frame.', 'pending'),
(6, 111, 5, 'Need a fresh coat of paint in the living room.', 'pending'),
(7, 93, 6, 'Inspect and service the air heater.', 'pending'),
(8, 90, 7, 'Post-renovation cleaning required.', 'pending'),
(9, 91, 3, 'Install new plumbing for the washing machine.', 'pending'),
(10, 103, 5, 'Fix electrical short circuit in the garage.', 'pending'),
(11, 103, 2, 'Check AC refrigerant levels.', 'pending'),
(12, 109, 1, 'Repair TV audio issue.', 'pending'),
(13, 105, 1, 'Service water purifier; slow water flow.', 'pending'),
(14, 112, 1, 'Ant infestation in the garden; need treatment.', 'pending'),
(15, 117, 10, 'Install new wooden flooring.', 'pending'),
(16, 119, 10, 'Paint touch-up required after water leakage.', 'pending'),
(17, 82, 12, 'Check heating thermostat issues.', 'pending'),
(18, 99, 15, 'Commercial cleaning service needed.', 'pending'),
(19, 100, 18, 'Replace old kitchen sink with a new one.', 'pending'),
(20, 108, 19, 'Install ceiling fans in all rooms.', 'pending'),
(21, 102, 20, 'Service central AC unit.', 'pending');

select * from requests;
select * from Reviews;
 
INSERT INTO Reviews (request_id, user_id, provider_id, rating, review_text) VALUES
(81, 1, 81, 5, 'Excellent service! The plumber fixed the leak quickly and efficiently. Highly recommend!'),
(82, 1, 82, 4, 'The electrician was prompt and professional. A little pricey, but overall good service.'),
(83, 1, 83, 3, 'AC technician was okay. It took longer than expected, but the issue was resolved.'),
(84, 2, 84, 2, 'The TV repair was subpar. It took too long, and the problem wasn\'t completely fixed.'),
(85, 2, 85, 5, 'Fantastic service for the RO water purifier! Fast and reliable.'),
(86, 3, 86, 1, 'Pest control did not resolve the issue at all. Very disappointed.'),
(87, 3, 87, 3, 'The carpenter did a decent job but missed the deadline.'),
(88, 4, 98, 5, 'Painter did an amazing job! The house looks brand new.'),
(89, 4, 89, 4, 'Good service from HVAC technician, but communication could be better.'),
(90, 5, 110, 3, 'Cleaning service was average. Could have been more thorough.'),
(91, 1, 120, 5, 'Fast response to my plumbing issue. Very satisfied with the work done!'),
(92, 1, 89, 4, 'Good service, but I expected a quicker turnaround.'),
(93, 6, 83, 3, 'The AC service was alright, nothing special.'),
(94, 2, 94, 2, 'TV repair service was not satisfactory. Issues remain.'),
(95, 5, 96, 5, 'Pest control was effective and professional. Highly recommend!'),
(96, 7, 87, 4, 'The carpenter did a nice job on the shelves but was a bit late.'),
(97, 8, 98, 5, 'The painting job exceeded my expectations! Beautiful work.'),
(98, 3, 99, 4, 'HVAC technician was knowledgeable and fixed the issue quickly.'),
(99, 4, 117, 3, 'Cleaning was decent, but missed some spots.'),
(100, 1, 119, 5, 'Best plumbing service I have ever used! Very professional.'),
(101, 2, 94, 2, 'The electrical work was not up to the mark. Would not recommend.'),
(102, 3, 96, 4, 'AC was fixed, but the technician could be more friendly.'),
(103, 4, 97, 5, 'Great service! My TV is working perfectly now.'),
(104, 5, 98, 4, 'RO service was good, but took longer than expected.'),
(105, 6, 99, 1, 'Pest control didn\'t work. Infestation returned quickly.'),
(106, 7, 100, 4, 'Carpenter was professional and did a good job on the cabinets.'),
(107, 8, 104, 5, 'Loved the painting! The team was quick and tidy.'),
(108, 9, 103, 3, 'Good heating service but could use better equipment.'),
(109, 10, 101, 2, 'The cleaning was rushed and not thorough. Disappointed.'),
(110, 1, 110, 5, 'Quick and effective plumbing service. Very happy!'),
(111, 1, 112, 4, 'Good job with electrical repairs, but a bit slow.'),
(112, 3, 87, 3, 'Average service; nothing stood out.'),
(113, 4, 84, 5, 'TV is working like new! Excellent repair service.'),
(114, 5, 85, 4, 'RO service was timely and efficient.'),
(115, 6, 86, 1, 'Waste of money; pest control did not work.'),
(116, 7, 87, 3, 'The carpenter was decent but could improve on finishing touches.'),
(117, 8, 88, 5, 'Amazing painting service! Highly recommend.'),
(118, 9, 89, 4, 'Good service for heating. Will use again.'),
(119, 10, 90, 2, 'Cleaning service needs improvement; not very thorough.'),
(120, 1, 99, 5, 'Fantastic job! Will hire again for plumbing issues.'),
(81, 2, 100, 4, 'The electrician did a great job but was a bit expensive.'),
(92, 3, 109, 3, 'AC service was okay, but technician was a bit rude.'),
(113, 4, 94, 5, 'Great TV repair! Very happy with the results.'),
(84, 5, 95, 4, 'RO water service was efficient and friendly.'),
(85, 6, 96, 1, 'Terrible experience; pest control didn’t work at all.'),
(96, 7, 97, 4, 'Carpenter was skilled but a bit late.'),
(117, 8, 98, 5, 'Exceptional painting work! Very satisfied.'),
(119, 9, 99, 3, 'HVAC service was okay; expected better.'),
(88, 10, 90, 2, 'Cleaning was subpar; missed many areas.'),
(90, 1, 91, 5, 'Excellent plumbing work! Highly recommend to others.');


INSERT INTO Locations (city, state, zipcode, latitude, longitude) VALUES
('Mumbai', 'Maharashtra', '400001', 19.0760, 72.8777),
('Delhi', 'Delhi', '110001', 28.6139, 77.2090),
('Bangalore', 'Karnataka', '560001', 12.9716, 77.5946),
('Chennai', 'Tamil Nadu', '600001', 13.0827, 80.2707),
('Kolkata', 'West Bengal', '700001', 22.5726, 88.3639),
('Hyderabad', 'Telangana', '500001', 17.3850, 78.4867);

select * from Service_Availability;
INSERT INTO Service_Availability (provider_id, day_of_week, start_time, end_time, is_available) VALUES
(81, 'Monday', '09:00:00', '17:00:00', 'Yes'),
(81, 'Tuesday', '09:00:00', '17:00:00', 'Yes'),
(81, 'Wednesday', '09:00:00', '17:00:00', 'Yes'),
(81, 'Thursday', '09:00:00', '17:00:00', 'Yes'),
(81, 'Friday', '09:00:00', '17:00:00', 'Yes'),
(81, 'Saturday', '10:00:00', '14:00:00', 'Yes'),
(81, 'Sunday', NUll, NUll, 'No'),
(82, 'Monday', '10:00:00', '18:00:00', 'Yes'),
(82, 'Tuesday', '10:00:00', '18:00:00', 'Yes'),
(82, 'Wednesday', '10:00:00', '18:00:00', 'Yes'),
(84, 'Thursday', '10:00:00', '18:00:00', 'Yes'),
(83, 'Friday', '10:00:00', '18:00:00', 'Yes'),
(87, 'Saturday', '10:00:00', '15:00:00', 'Yes'),
(98, 'Sunday', NUll, NUll, 'No'),
(99, 'Monday', '08:00:00', '16:00:00', 'Yes'),
(100, 'Tuesday', '08:00:00', '16:00:00', 'Yes'),
(104, 'Wednesday', '08:00:00', '16:00:00', 'Yes'),
(103, 'Thursday', '08:00:00', '16:00:00', 'Yes'),
(105, 'Friday', '08:00:00', '16:00:00', 'Yes'),
(116, 'Saturday', NUll, NUll, 'No'),
(119, 'Sunday', NUll, NUll, 'No'),
(114, 'Monday', '11:00:00', '19:00:00', 'Yes'),
(106, 'Tuesday', '11:00:00', '19:00:00', 'Yes'),
(104, 'Wednesday', '11:00:00', '19:00:00', 'Yes'),
(94, 'Thursday', '11:00:00', '19:00:00', 'Yes'),
(84, 'Friday', '11:00:00', '19:00:00', 'Yes'),
(104, 'Saturday', '12:00:00', '17:00:00', 'Yes'),
(114, 'Sunday', NUll, NUll, 'No'),
(115, 'Monday', '09:00:00', '18:00:00', 'Yes'),
(105, 'Tuesday', '09:00:00', '18:00:00', 'Yes'),
(117, 'Wednesday', '09:00:00', '18:00:00', 'Yes'),
(114, 'Thursday', '09:00:00', '18:00:00', 'Yes'),
(115, 'Friday', '09:00:00', '18:00:00', 'Yes'),
(119, 'Saturday', NUll, NUll, 'No'),
(105, 'Sunday', NUll, NUll, 'No'),
(116, 'Monday', '09:00:00', '17:00:00', 'Yes'),
(106, 'Tuesday', '09:00:00', '17:00:00', 'Yes'),
(116, 'Wednesday', '09:00:00', '17:00:00', 'Yes'),
(108, 'Thursday', '09:00:00', '17:00:00', 'Yes'),
(107, 'Friday', '09:00:00', '17:00:00', 'Yes'),
(110, 'Saturday', '10:00:00', '15:00:00', 'Yes'),
(110, 'Sunday', NUll, NUll, 'No'),
(99, 'Monday', '10:00:00', '19:00:00', 'Yes'),
(89, 'Tuesday', '10:00:00', '19:00:00', 'Yes'),
(94, 'Wednesday', '10:00:00', '19:00:00', 'Yes'),
(97, 'Thursday', '10:00:00', '19:00:00', 'Yes'),
(92, 'Friday', '10:00:00', '19:00:00', 'Yes'),
(91, 'Saturday', '10:00:00', '15:00:00', 'Yes'),
(97, 'Sunday', NUll, NUll, 'No'),
(98, 'Monday', '08:00:00', '16:00:00', 'Yes'),
(98, 'Tuesday', '08:00:00', '16:00:00', 'Yes'),
(89, 'Wednesday', '08:00:00', '16:00:00', 'Yes'),
(88, 'Thursday', '08:00:00', '16:00:00', 'Yes'),
(85, 'Friday', '08:00:00', '16:00:00', 'Yes'),
(84, 'Saturday', NUll, NUll, 'No'),
(82, 'Sunday', NUll, NUll, 'No'),
(90, 'Monday', '11:00:00', '19:00:00', 'Yes'),
(91, 'Tuesday', '11:00:00', '19:00:00', 'Yes'),
(94, 'Wednesday', '11:00:00', '19:00:00', 'Yes'),
(98, 'Thursday', '11:00:00', '19:00:00', 'Yes'),
(99, 'Friday', '11:00:00', '19:00:00', 'Yes'),
(109, 'Saturday', '12:00:00', '17:00:00', 'Yes'),
(109, 'Sunday', NUll, NUll, 'No'),
(101, 'Monday', '09:00:00', '18:00:00', 'Yes'),
(105, 'Tuesday', '09:00:00', '18:00:00', 'Yes'),
(107, 'Wednesday', '09:00:00', '18:00:00', 'Yes'),
(109, 'Thursday', '09:00:00', '18:00:00', 'Yes'),
(101, 'Friday', '09:00:00', '18:00:00', 'Yes'),
(101, 'Saturday', NUll, NUll, 'No'),
(105, 'Sunday', NUll, NUll, 'No');

select * from payment;
INSERT INTO Payment (request_id, user_id, provider_id, amount, payment_status, payment_method) VALUES
(81, 1, 81, 1500.00, 'completed', 'UPI'),
(82, 1, 82, 1200.00, 'completed', 'Cash'),
(83, 2, 83, 800.00, 'pending', 'Net_Banking'),
(84, 2, 84, 3000.00, 'completed', 'Debit_Card'),
(85, 3, 85, 2000.00, 'completed', 'UPI'),
(86, 3, 86, 900.00, 'pending', 'Debit_Card'),
(87, 4, 87, 1100.00, 'completed', 'Cash'),
(88, 4, 88, 500.00, 'completed', 'Net_Banking'),
(89, 5, 89, 650.00, 'completed', 'UPI'),
(90, 5, 90, 1500.00, 'pending', 'Debit_Card'),
(91, 6, 91, 2200.00, 'completed', 'Cash'),
(92, 6, 92, 1800.00, 'completed', 'UPI'),
(93, 7, 93, 1700.00, 'pending', 'Net_Banking'),
(94, 7, 94, 1600.00, 'completed', 'Debit_Card'),
(95, 8, 95, 2500.00, 'completed', 'UPI'),
(96, 8, 96, 700.00, 'completed', 'Cash'),
(97, 9, 97, 1300.00, 'pending', 'Debit_Card'),
(98, 9, 98, 2200.00, 'completed', 'Net_Banking'),
(99, 10, 99, 1250.00, 'completed', 'UPI'),
(100, 10, 100, 400.00, 'pending', 'Cash'),
(101, 11, 101, 900.00, 'completed', 'Debit_Card'),
(102, 11, 102, 1300.00, 'completed', 'UPI'),
(103, 12, 103, 2200.00, 'pending', 'Net_Banking'),
(104, 12, 104, 3000.00, 'completed', 'Cash'),
(105, 13, 105, 1700.00, 'completed', 'Debit_Card'),
(106, 13, 106, 800.00, 'pending', 'UPI'),
(107, 14, 107, 950.00, 'completed', 'Net_Banking'),
(108, 14, 108, 600.00, 'completed', 'Cash'),
(109, 15, 109, 1200.00, 'completed', 'UPI'),
(110, 15, 110, 1400.00, 'pending', 'Debit_Card'),
(111, 16, 111, 1100.00, 'completed', 'Cash'),
(112, 16, 112, 1300.00, 'completed', 'UPI'),
(113, 17, 113, 900.00, 'pending', 'Net_Banking'),
(114, 17, 114, 2000.00, 'completed', 'Debit_Card'),
(115, 18, 115, 1800.00, 'completed', 'UPI'),
(116, 18, 116, 800.00, 'completed', 'Cash'),
(117, 19, 117, 2100.00, 'pending', 'Debit_Card'),
(118, 19, 118, 950.00, 'completed', 'Net_Banking'),
(119, 20, 119, 650.00, 'completed', 'UPI'),
(120, 20, 120, 1750.00, 'pending', 'Cash'),
(101, 1, 81, 1550.00, 'completed', 'UPI'),
(102, 1, 82, 1250.00, 'completed', 'Cash'),
(103, 2, 83, 850.00, 'pending', 'Net_Banking'),
(104, 2, 84, 3050.00, 'completed', 'Debit_Card'),
(105, 3, 85, 2050.00, 'completed', 'UPI'),
(106, 3, 86, 950.00, 'pending', 'Debit_Card'),
(107, 4, 87, 1150.00, 'completed', 'Cash'),
(108, 4, 88, 550.00, 'completed', 'Net_Banking'),
(109, 5, 89, 700.00, 'completed', 'UPI'),
(110, 5, 90, 1550.00, 'pending', 'Debit_Card'),
(111, 6, 91, 2250.00, 'completed', 'Cash'),
(112, 6, 92, 1850.00, 'completed', 'UPI'),
(113, 7, 93, 1750.00, 'pending', 'Net_Banking'),
(114, 7, 94, 1650.00, 'completed', 'Debit_Card'),
(115, 8, 95, 2550.00, 'completed', 'UPI'),
(116, 8, 96, 750.00, 'completed', 'Cash'),
(117, 9, 97, 1350.00, 'pending', 'Debit_Card'),
(118, 9, 98, 2250.00, 'completed', 'Net_Banking'),
(119, 10, 99, 1300.00, 'completed', 'UPI'),
(120, 10, 100, 450.00, 'pending', 'Cash');



INSERT INTO Notifications (user_id, provider_id, message, notification_type, is_read) VALUES
(1, NULL, 'Your service request for plumbing has been accepted.', 'new_request', 'Unread'),
(2, 81, 'New offers available for electric services this week!', 'offer', 'Unread'),
(3, NULL, 'Reminder: Your appointment for AC maintenance is scheduled for tomorrow.', 'reminder', 'Unread'),
(4, 83, 'Your request for pest control has been completed successfully.', 'service_update', 'Read'),
(5, NULL, 'Special discount on painting services for the next 3 days!', 'offer', 'Unread'),
(1, 82, 'Your payment for the service has been received.', 'service_update', 'Read'),
(6, NULL, 'Reminder: Your carpet cleaning service is scheduled for this Saturday.', 'reminder', 'Unread'),
(7, 84, 'Your request for TV repair has been accepted.', 'new_request', 'Unread'),
(2, 85, 'Your recent feedback on the service has been noted. Thank you!', 'service_update', 'Read'),
(3, 86, 'New service categories have been added to your account.', 'service_update', 'Unread'),
(8, NULL, 'Reminder: Your home cleaning service is due for a review.', 'reminder', 'Unread'),
(4, 87, 'Your service request for car wash has been completed.', 'service_update', 'Read'),
(5, NULL, 'Limited-time offer on electrical repairs! Check it out!', 'offer', 'Unread'),
(6, NULL, 'Your request for gardening service has been assigned to a provider.', 'new_request', 'Unread'),
(7, 88, 'You have a new message from your service provider.', 'service_update', 'Unread'),
(8, NULL, 'Special offer on plumbing services for returning customers!', 'offer', 'Unread'),
(9, NULL, 'Reminder: Your furniture assembly service is scheduled for next week.', 'reminder', 'Unread'),
(10, 89, 'Your feedback is appreciated! Thanks for reviewing the service.', 'service_update', 'Read'),
(11, NULL, 'New service alert: We now offer pest control in your area!', 'offer', 'Unread'),
(12, 90, 'Your service provider has updated their availability for the week.', 'service_update', 'Unread'),
(13, NULL, 'Your service request for door repair has been completed.', 'service_update', 'Read'),
(14, 91, 'A new provider has been assigned to your cleaning service.', 'new_request', 'Unread'),
(15, 92, 'Your service feedback is important! Please share your thoughts.', 'service_update', 'Read'),
(16, NULL, 'Last chance to avail discounts on home renovation services!', 'offer', 'Unread'),
(17, NULL, 'Your appointment for appliance repair is confirmed.', 'reminder', 'Unread'),
(18, 93, 'Your recent payment was successful. Thank you!', 'service_update', 'Read'),
(19, NULL, 'New offers available for electrical inspections!', 'offer', 'Unread'),
(20, NULL, 'Your service request for sofa cleaning is pending confirmation.', 'new_request', 'Unread');


INSERT INTO Service_History (user_id, provider_id, service_category_id, service_description, service_date, completion_status) VALUES
(1, 81, 1, 'Plumbing service to fix leaky faucet in kitchen.', '2024-10-01 10:30:00', 'completed'),
(2, 82, 2, 'Electrical wiring installation for living room lights.', '2024-10-02 14:00:00', 'completed'),
(3, 83, 3, 'AC maintenance and cleaning service.', '2024-10-03 09:15:00', 'completed'),
(1, 84, 4, 'TV repair for malfunctioning remote control.', '2024-10-04 11:00:00', 'completed'),
(4, 81, 1, 'Pest control treatment for kitchen area.', '2024-10-05 13:45:00', 'completed'),
(2, 85, 5, 'Carpentry work for custom shelving in bedroom.', '2024-10-06 12:00:00', 'completed'),
(3, 86, 6, 'Painting service for living room walls.', '2024-10-07 15:00:00', 'completed'),
(5, 82, 2, 'Electrical inspection of house wiring.', '2024-10-08 16:30:00', 'completed'),
(6, 83, 3, 'AC repair for cooling issues.', '2024-10-09 08:30:00', 'completed'),
(1, 84, 4, 'Door repair service for front door.', '2024-10-10 10:00:00', 'completed'),
(2, 81, 1, 'Cancelled plumbing service due to scheduling conflict.', '2024-10-11 11:00:00', 'cancelled'),
(3, 85, 5, 'Requested pest control service for bedroom.', '2024-10-12 14:15:00', 'completed'),
(4, 86, 6, 'TV wall mounting service completed.', '2024-10-13 09:00:00', 'completed'),
(5, 82, 2, 'Installed new electrical outlets in kitchen.', '2024-10-14 13:30:00', 'completed'),
(6, 83, 3, 'AC filter replacement and servicing.', '2024-10-15 11:30:00', 'completed'),
(7, 84, 4, 'Completed furniture assembly service.', '2024-10-16 12:45:00', 'completed'),
(8, 81, 1, 'Installed new plumbing fixtures in bathroom.', '2024-10-17 10:15:00', 'completed'),
(9, 82, 2, 'Electrical panel upgrade service completed.', '2024-10-18 15:00:00', 'completed'),
(10, 85, 5, 'Repaired broken shelves in garage.', '2024-10-19 09:30:00', 'completed'),
(11, 86, 6, 'Cancelled service for wall painting due to rain.', '2024-10-20 11:15:00', 'cancelled'),
(12, 83, 3, 'Scheduled AC maintenance check completed.', '2024-10-21 10:45:00', 'completed'),
(13, 81, 1, 'Emergency plumbing service for burst pipe.', '2024-10-22 08:00:00', 'completed'),
(14, 82, 2, 'Completed wiring installation for outdoor lighting.', '2024-10-23 14:30:00', 'completed'),
(15, 84, 4, 'Fixed TV screen issues and updated software.', '2024-10-24 16:00:00', 'completed'),
(16, 85, 5, 'Carpentry service for building custom furniture.', '2024-10-25 10:30:00', 'completed'),
(17, 86, 6, 'Pest control for backyard service completed.', '2024-10-26 13:00:00', 'completed'),
(18, 83, 3, 'AC repair service due to gas leak.', '2024-10-27 12:00:00', 'completed'),
(19, 82, 2, 'Completed electrical maintenance check.', '2024-10-28 09:15:00', 'completed'),
(20, 81, 1, 'Cancelled service request for water heater repair.', '2024-10-29 11:30:00', 'cancelled'),
(21, 87, 3, 'AC thermostat replacement and calibration.', '2024-10-30 10:45:00', 'completed'),
(21, 88, 4, 'Home entertainment system installation.', '2024-10-31 14:15:00', 'completed'),
(20, 89, 5, 'Repaired dining table and reinforced joints.', '2024-11-01 09:00:00', 'completed'),
(19, 90, 6, 'Exterior house painting.', '2024-11-02 13:30:00', 'completed'),
(18, 91, 1, 'Sink installation in guest bathroom.', '2024-11-03 15:00:00', 'completed'),
(17, 92, 2, 'Replaced outdated electrical fuse box.', '2024-11-04 11:30:00', 'completed'),
(16, 93, 3, 'AC servicing for bedroom unit.', '2024-11-05 08:45:00', 'completed'),
(15, 94, 4, 'Set up wireless router and smart TV.', '2024-11-06 10:00:00', 'completed'),
(14, 95, 5, 'Built custom workbench in garage.', '2024-11-07 13:15:00', 'completed'),
(13, 96, 6, 'Interior painting of bedroom and hallways.', '2024-11-08 14:30:00', 'completed'),
(12, 97, 1, 'Fixed drainage blockage in kitchen.', '2024-11-09 09:45:00', 'completed'),
(11, 98, 2, 'Upgraded kitchen lighting system.', '2024-11-10 12:30:00', 'completed'),
(10, 99, 3, 'Annual maintenance for AC units.', '2024-11-11 10:15:00', 'completed'),
(9, 100, 4, 'Replaced faulty remote control for TV.', '2024-11-12 14:00:00', 'completed'),
(8, 101, 5, 'Constructed custom wooden bookcase.', '2024-11-13 15:45:00', 'completed'),
(7, 102, 6, 'Painted garden shed and exterior fence.', '2024-11-14 13:00:00', 'completed'),
(6, 103, 1, 'Repaired bathroom shower drain.', '2024-11-15 10:30:00', 'completed'),
(5, 104, 2, 'Installed dimmer switches in living room.', '2024-11-16 09:00:00', 'completed'),
(4, 105, 3, 'Recharged AC refrigerant and cleaned filters.', '2024-11-17 08:30:00', 'completed'),
(3, 106, 4, 'Configured new cable setup for TV.', '2024-11-18 12:15:00', 'completed');



select * from Users ;
select * from Service_Providers ;
select * from Service_Categories ;
select * from Requests ;
select * from Reviews ; 
select * from Locations ;
select * from Service_Availability ; 
select * from Payment ; --
select * from Notifications ; --
select * from Service_History ; --

DESC Users ;
DESC Service_Providers ;
DESC Service_Categories ;
DESC Requests ;
DESC Reviews ;
DESC Locations ;
DESC Service_Availability ;
DESC Payment ;
DESC Notifications ;
DESC Service_History ;

-- Questions --

-- all users whose names start with "Amit"
SELECT * FROM Users WHERE Full_name LIKE 'Amit%';

-- retrieves all users with an email address that ends with "@example.com"
SELECT * FROM Users WHERE email LIKE '%rahul.mehta@example.com';



-- Get a List of Service Providers by Category:
SELECT sp.Full_name, sp.experience, sp.rating
FROM Service_Providers sp
JOIN Service_Categories sc ON sp.service_category_id = sc.service_category_id
WHERE sc.Full_name = 'Plumbing'; 

select * from requests;
-- Find All Requests Made by a Specific User:
SELECT r.*
FROM Requests r
WHERE r.user_id = 7;

-- Count the Number of Service Requests by Status:
SELECT status, COUNT(*) AS request_count
FROM Requests
GROUP BY status;

-- Get Reviews for a Specific Service Provider:
SELECT r.review_text, r.rating, u.Full_name AS reviewer_name
FROM Reviews r
JOIN Users u ON r.user_id = u.user_id
WHERE r.provider_id = 85;

-- Retrieve Notifications for a Specific User:
SELECT n.*
FROM Notifications n
WHERE n.user_id = 15;

-- Find All Services Provided in a Specific Location:
SELECT sp.Full_name, sp.availability_status
FROM Service_Providers sp
JOIN Locations l ON sp.location_id = l.location_id
WHERE l.city = 'Mumbai' AND l.state = 'Maharashtra';

-- Get Service History for a Specific User:
SELECT sh.service_description, sh.service_date, sh.completion_status
FROM Service_History sh
WHERE sh.user_id = 11;

-- Get Average Rating for Each Service Provider:
SELECT sp.Full_name, AVG(r.rating) AS average_rating
FROM Service_Providers sp
LEFT JOIN Reviews r ON sp.provider_id = r.provider_id
GROUP BY sp.provider_id;

-- Retrieve All Payments Made by a User:
SELECT p.amount, p.payment_status, p.payment_method
FROM Payment p
WHERE p.user_id =9;

-- Find the Top 5 Service Categories by Number of Requests:
SELECT sc.Full_name, COUNT(r.request_id) AS request_count
FROM Service_Categories sc
LEFT JOIN Requests r ON sc.service_category_id = r.service_category_id
GROUP BY sc.service_category_id
ORDER BY request_count DESC
LIMIT 5;

-- Check Availability of a Provider on a Specific Day:
SELECT sa.*
FROM Service_Availability sa
WHERE sa.provider_id =99 AND sa.day_of_week = 'Monday';

-- Get Users Who Have Given a Review with a Rating of 5:
SELECT DISTINCT u.Full_name
FROM Users u
JOIN Reviews r ON u.user_id = r.user_id
WHERE r.rating = 5;

-- Find Service Providers with More than a Certain Years of Experience:
SELECT Full_name, experience
FROM Service_Providers
WHERE experience > 5;

-- Retrieve All Requests and Their Associated Service Provider Names:
SELECT r.request_id, u.Full_name AS user_name, sp.Full_name AS provider_name, r.status
FROM Requests r
JOIN Users u ON r.user_id = u.user_id
LEFT JOIN Service_Providers sp ON r.provider_id = sp.provider_id 
limit 10;

-- Count Users by Role:
SELECT role, COUNT(*) AS user_count
FROM Users
GROUP BY role;

-- Get Service Category Descriptions:
SELECT Full_name, Description
FROM Service_Categories;

-- Find the Most Recent Service Request for Each User:
SELECT r.user_id, r.request_id, r.description, r.status
FROM Requests r
WHERE r.request_id IN (
    SELECT MAX(request_id)
    FROM Requests
    GROUP BY user_id
);

-- Retrieve All Notifications That Are Unread:
SELECT *
FROM Notifications
WHERE is_read = 'Unread' limit 10;

-- Get the Number of Reviews per Service Provider:
SELECT sp.Full_name, COUNT(r.review_id) AS review_count
FROM Service_Providers sp
LEFT JOIN Reviews r ON sp.provider_id = r.provider_id
GROUP BY sp.provider_id limit 10;

-- Get Users and Their Latest Review:
SELECT u.Full_name AS user_name, r.review_text, r.rating
FROM Users u
JOIN Reviews r ON u.user_id = r.user_id
WHERE r.review_id IN (
    SELECT MAX(review_id)
    FROM Reviews
    GROUP BY user_id
);

-- List Service Availability for All Providers:
SELECT sp.Full_name, sa.day_of_week, sa.start_time, sa.end_time
FROM Service_Providers sp
JOIN Service_Availability sa ON sp.provider_id = sa.provider_id limit 15;

-- Calculate the Total Amount of Payments Made by Each User:
SELECT p.user_id, SUM(p.amount) AS total_payments
FROM Payment p
GROUP BY p.user_id;

-- Get Service Providers Who Are Currently Unavailable:
SELECT Full_name, location_id
FROM Service_Providers
WHERE availability_status = 'unavailable';

-- List All Unique Cities Where Service Providers Are Located:
SELECT DISTINCT l.city
FROM Locations l
JOIN Service_Providers sp ON l.location_id = sp.location_id;

-- Count of Service Requests for Each Category:
SELECT sc.Full_name, COUNT(r.request_id) AS request_count
FROM Service_Categories sc
LEFT JOIN Requests r ON sc.service_category_id = r.service_category_id
GROUP BY sc.service_category_id limit 10;

