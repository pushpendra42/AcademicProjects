/*1  List all reservations source and destination only for valid trips; source/destination cannot be null*/
/*----List all reservations source  only for valid trips-----*/

select cityname,q3.tripid from (select citycode,q2.tripid from (select originalAirCode, q1.tripid from (select flightscheduleid,customertrip.tripid from customertrip join flighttrip on flighttrip.flighttripid= customertrip.flighttripid where ticketid is not null)q1
join flightschedule on flightschedule.flightscheduleid=q1.flightscheduleid where originalAirCode is not null and destAirCode is not null) q2 join airport on airport.airportCode=q2.originalAirCode) q3
join city on city.citycode=q3.citycode;

/*----List all reservations destination  only for valid trips-----*/

select cityname,q3.tripid from (select citycode,q2.tripid from (select destAirCode, q1.tripid from (select flightscheduleid,customertrip.tripid from customertrip join flighttrip on flighttrip.flighttripid= customertrip.flighttripid where ticketid is not null)q1
join flightschedule on flightschedule.flightscheduleid=q1.flightscheduleid where originalAirCode is not null and destAirCode is not null) q2 join airport on airport.airportCode=q2.destAirCode) q3
join city on city.citycode=q3.citycode;



/*2 List all reservations source and destination only for invalid trips; source/destination can be null. */

select originalAirCode, destAirCode, q1.tripid from (select flightscheduleid, customertrip.tripid from customertrip join flighttrip on flighttrip.flighttripid=customertrip.flighttripid) q1 
join flightschedule on flightschedule.flightscheduleid=q1.flightscheduleid where originalAirCode is null or destAirCode is null;

/*3 List trips not purchased by anyone.*/

select flighttripid from flighttrip where flighttripid not in (select customertrip.flighttripid from customertrip join  flighttrip on customertrip.flighttripid=flighttrip.flighttripid );

/*4 Customers who have traveled to every available city*/

select distinct(customerid) from (select customerid,city.citycode from (select * from customer join city on customer.customercitycode=city.citycode) as cu join city on city.countrycode=cu.countrycode except  (select customerid,citycode from (select  q1.customerid,destaircode from (select flightscheduleid, customerid from customertrip join flighttrip on flighttrip.flighttripid=customertrip.flighttripid) q1 join flightschedule on q1.flightscheduleid=flightschedule.flightscheduleid) t1 join airport on t1.destaircode=airport.airportcode)) as result1;


/*5 List customers who have two or more invalid trips ; List those invalid trips sorted by customer. */
 select customerid from (select customerid, flightscheduleid, customertrip.tripid from customertrip join flighttrip on customertrip.flighttripid=flighttrip.flighttripid) q1 
join flightschedule on q1.flightscheduleid =flightschedule.flightscheduleid where originalAirCode is  null or destAirCode is  null 
 group by customerid  having count(customerid)>1


6) Identify the top ”active” month: the month with more reservations. */
   select to_char(bookingDate,'YY-MM') AS YYMM, count(*), extract(year from now()) from ticket group by YYMM order by count(*) DESC; 

7) A table having city as row and each day of the week as column, showing a percentage based on number of trips. That is, ﬁnding out the busiest days*/



