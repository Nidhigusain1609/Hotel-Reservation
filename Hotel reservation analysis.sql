USE [Hotel reservation]
GO

SELECT *
  FROM [dbo].[Hotel Reservation Dataset]

GO
----------------------------------(1). What is the total number of reservations in the dataset?---------------------------

 SELECT count(Booking_ID) AS 'Total Reservation'
 FROM [dbo].[Hotel Reservation Dataset]



----------------------------------(2). Which meal plan is the most popular among guests?--------------------------
  SELECT TOP 1 type_of_meal_plan, COUNT(*) AS 'Top_Meal_Plan'
  FROM [dbo].[Hotel Reservation Dataset] 
  GROUP BY type_of_meal_plan
  ORDER BY Top_Meal_Plan DESC

------------------------------------(3). What is the average price per room for reservations involving children?------------------------------
SELECT ROUND(AVG(avg_price_per_room),2) as 'Average price per room'
FROM [dbo].[Hotel Reservation Dataset]
WHERE no_of_children>0

-------------------------------------(4).How many reservations were made for the year 20XX (replace XX with the desired year)?--------------------

SELECT COUNT(*) AS 'Reservation in 2017'
FROM [dbo].[Hotel Reservation Dataset]
WHERE YEAR(arrival_date) = 2017

-------------------------------------(5). What is the most commonly booked room type?--------------------------------
 SELECT TOP 1 room_type_reserved,COUNT(*) AS 'Top Room'
 FROM [dbo].[Hotel Reservation Dataset]
 GROUP BY room_type_reserved
 ORDER BY 'Top Room' DESC

------------------------------------(6).How many reservations fall on a weekend (no_of_weekend_nights > 0)?------------------------
SELECT COUNT(*) AS 'Weekend_Reservations'
FROM [dbo].[Hotel Reservation Dataset]
WHERE no_of_weekend_nights > 0

------------------------------------(7). What is the highest and lowest lead time for reservations?--------------------------------
  SELECT MAX(lead_time)AS 'highest lead', MIN(lead_time)AS 'lowest lead'
  FROM [dbo].[Hotel Reservation Dataset]

----------------------------------(8). What is the most common market segment type for reservations?-------------------------------
SELECT Top 1 market_segment_type, COUNT(*)AS 'Most common market segment type'
FROM [dbo].[Hotel Reservation Dataset]
GROUP BY market_segment_type 
ORDER BY 'Most common market segment type' DESC


-----------------------------------(9). How many reservations have a booking status of "Confirmed"?--------------------------------
 SELECT COUNT(booking_status)AS 'Total Booking Confirmed'
 FROM [dbo].[Hotel Reservation Dataset]
 where booking_status='Not_canceled'

----------------------------------(10).What is the total number of adults and children across all reservations?----------------------------
 SELECT SUM(no_of_adults)AS 'Total Adults', 
 SUM(no_of_children)AS 'Total childrens',
 SUM(no_of_adults + no_of_children)AS 'Total guests'
 FROM [dbo].[Hotel Reservation Dataset]

------------------------------------(11). What is the average number of weekend nights for reservations involving children?------------

 SELECT AVG(no_of_weekend_nights)AS 'Avg of weekend_nights'
 FROM [dbo].[Hotel Reservation Dataset]
 WHERE no_of_children > 0
----------------------------------(12). How many reservations were made in each month of the year?--------------------------

  SELECT LEFT(DATENAME(month, arrival_date), 3) AS 'Month', DATENAME(YEAR, arrival_date) AS 'Year',
  COUNT(*) AS 'No_of_reservations'
  FROM [dbo].[Hotel Reservation Dataset]
  GROUP BY LEFT(DATENAME(month, arrival_date), 3),  DATENAME(YEAR, arrival_date)
  ORDER BY 'No_of_reservations' desc

----------------comparing with both month and  year------------------
SELECT 
       LEFT(DATENAME(month, arrival_date), 3) + ' ' + CAST(YEAR(arrival_date) AS VARCHAR(4)) AS 'month_year',
       COUNT(*) AS 'no_of_reservation'
FROM [dbo].[Hotel Reservation Dataset]
GROUP BY 
   LEFT(DATENAME(month, arrival_date), 3) + ' ' + CAST(YEAR(arrival_date) AS VARCHAR(4))
ORDER BY 
   'no_of_reservation'desc
   
-----------------(13).What is the average number of nights (both weekend and weekday) spent by guests for each room type?---------------
 SELECT room_type_reserved, AVG(no_of_weekend_nights) ,avg(no_of_week_nights)AS 'Avg_no_days_spent_by_guests'
 FROM  [dbo].[Hotel Reservation Dataset]
 GROUP BY room_type_reserved

-----(14). For reservations involving children, what is the most common room type, and what is the average price for that room type?--------

 SELECT room_type_reserved , count(room_type_reserved)AS 'Reservation_count', ROUND(AVG(avg_price_per_room),2) AS 'Room price'
 FROM  [dbo].[Hotel Reservation Dataset]
 where no_of_children > 0
 GROUP BY room_type_reserved
 ORDER BY Reservation_count DESC

----------------(15). Find the market segment type that generates the highest average price per room.------------
  SELECT market_segment_type,ROUND(AVG(avg_price_per_room), 2) AS 'Room price'
  FROM [dbo].[Hotel Reservation Dataset]
  GROUP BY market_segment_type
  ORDER BY [Room price] DESC






