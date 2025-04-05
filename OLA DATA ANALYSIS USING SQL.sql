CREATE TABLE OLA(
Date TEXT,
Time TIME,
Booking_ID TEXT,
Booking_Status VARCHAR(100),
Customer_ID TEXT,
Vehicle_Type VARCHAR(100),
Pickup_Location VARCHAR(100),
Drop_Location VARCHAR(100),
V_TAT NUMERIC(10),
C_TAT NUMERIC(10),
Canceled_Rides_by_Customer VARCHAR(100),
Canceled_Rides_by_Driver VARCHAR(100),
Incomplete_Rides VARCHAR(20),
Incomplete_Rides_Reason VARCHAR(100),
Booking_Value NUMERIC(5,2),
Payment_Method VARCHAR(50),
Ride_Distance NUMERIC(10,2),
Driver_Ratings NUMERIC(5,2),
Customer_Rating NUMERIC(5,2)
)

ALTER TABLE OLA
ALTER COLUMN Booking_Value TYPE NUMERIC(10,4);

--Retrieve all successful bookings:--
Create view successful_bookings AS
SELECT * FROM OLA
WHERE booking_status ='Success';

--Find the average ride distance for each vehicle type:--
CREATE VIEW avg_ride_distance_each_vehicle AS
SELECT vehicle_type,ROUND(AVG(ride_distance)) AS
avg_distance FROM OLA
GROUP BY vehicle_type;

-- Get the total number of cancelled rides by customers:--
CREATE VIEW total_number_of_cancelled_rides_by_cust AS
SELECT COUNT(*) 
FROM OLA
WHERE Booking_Status = 'Canceled by Customer';

-- List the top 5 customers who booked the highest number of rides:--

CREATE VIEW top_5_customers_who_booked_the_highest AS
SELECT Customer_id, COUNT(Booking_id) AS total_rides
FROM OLA
GROUP BY Customer_id
ORDER BY total_rides DESC 
LIMIT 5;

--. Get the number of rides cancelled by drivers due to personal and car-related issues:--
CREATE VIEW rides_cancelled_by_drivers_due_to_P_C_I AS
SELECT COUNT(*)
FROM OLA
WHERE Canceled_rides_by_driver = 'Personal & Car related issue';

-- Find the maximum and minimum driver ratings for Prime Sedan bookings:--
CREATE VIEW min_max_ratigs_prime_sedan AS
SELECT MAX(Driver_Ratings)AS max_rating,
		MIN(Driver_Ratings) AS min_rating
FROM OLA
WHERE  Vehicle_Type = 'Prime Sedan';
-- Retrieve all rides where payment was made using UPI:--
CREATE VIEW UPI_Payment As
SELECT * FROM OLA
WHERE Payment_Method = 'UPI';

-- Find the average customer rating per vehicle type--
CREATE VIEW AVG_Cust_Rating As
SELECT Vehicle_type,ROUND(AVG(Customer_Rating)) AS avg_cust_ratings
FROM OLA
GROUP BY Vehicle_type;

--Calculate the total booking value of rides completed successfully:--

CREATE VIEW  total_successful_ride_value AS
SELECT SUM(Booking_value) AS total_successful_ride_value
FROM OLA
WHERE Booking_Status = 'Success';

--List all incomplete rides along with the reason:
 Create View Incomplete_Rides_Reason As
 SELECT Booking_id, Incomplete_Rides_Reason
 FROM OLA
 WHERE Incomplete_Rides = 'Yes';
--DATA VIEW--
SELECT * FROM successful_bookings;
SELECT * FROM avg_ride_distance_each_vehicle;
SELECT * FROM total_number_of_cancelled_rides_by_cust;
SELECT * FROM top_5_customers_who_booked_the_highest;
SELECT * FROM rides_cancelled_by_drivers_due_to_P_C_I;
SELECT * FROM min_max_ratigs_prime_sedan;
SELECT * FROM UPI_Payment;
SELECT * FROM AVG_Cust_Rating;
SELECT * FROM  total_successful_ride_value;
SELECT * FROM Incomplete_Rides_Reason;
SELECT * FROM OLA; 