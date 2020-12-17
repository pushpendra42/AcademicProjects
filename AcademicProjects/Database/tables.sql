CREATE SEQUENCE book_id_seq
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

/*creata country table */
create table country (countryCode INT, countryName VARCHAR(20),  primary key (countryCode));

/*create city table*/
create table city (cityCode int, cityName VARCHAR(20), countryCode int, primary key(cityCode), foreign key(countryCode) references country(countryCode));

/*create customer table*/
create table customer(customerId INT, customerName VARCHAR(20), customerGender VARCHAR(6), customerAddress VARCHAR(40), customerDOB DATE, customerPhone numeric(10), 
customerCityCode int, primary key (customerId), foreign key (customerCityCode) references city(citycode) );

/*create airport table*/
create table airport(airportCode int, cityCode int, airportName VARCHAR(40), localTax numeric(3), internationalTax numeric(3), miscellaneouscharges INT, primary key(airportCode), 
foreign key (cityCode) references city(cityCode) );

/*create flight model*/
create table flightModel(flightModelId INT, flightModelName VARCHAR(15), primary key(flightModelId));

/*create paymethod */
create table payMethod(payMethodId INT, payType VARCHAR(8), primary key(payMethodid));

/*create flight table*/
create table flight(flightId INT, flightName VARCHAR(20), flightModelId INT, flightCountry int, primary key (flightId), foreign key (flightCountry) references country(countryCode),
foreign key(flightModelId) references flightModel(flightModelId));

/*create flight schedule table*/
create table flightSchedule(flightScheduleId INT, flightId INT, originalAirCode int, destAirCode int, startTime timestamp, duration INT, validfrom DATE, validtill DATE, fare INT,
Monday BOOLEAN, Tuesday BOOLEAN, Wednesday BOOLEAN, Thurday BOOLEAN, Friday BOOLEAN, Saturday BOOLEAN, Sunday BOOLEAN, internationalflight BOOLEAN, primary key (flightScheduleId), 
foreign key (originalAirCode) references airport(airportCode), foreign key (destAirCode) references airport(airportCode), foreign key (flightId) references flight(flightId));



/*create flight status table*/
create table flightTripStatus(flightStatusId INT, flightStatus VARCHAR(10), primary key(flightStatusId));




/*create fligt trip table*/
create table flightTrip(flightTripID INT, actualDuration INT, actualSourceStartTime TIMESTAMP, flightScheduleId INT,flightStatusId INT, flightId INT, scheduleSourceStartDate timestamp, primary key (flightTripID),
foreign key (flightScheduleId) references flightSchedule(flightScheduleId), foreign key (flightStatusId) references flightTripStatus(flightStatusId), foreign key (flightId) references flight(flightId));

/*create flight instance */

--create table flightInstance(flightInstanceid int, flighttripid int, seatB int, seatE int,  primary key (flightInstanceid), foreign key (flightTripid) references flightTrip(flightTripID));
create table flightInstance(flightInstanceid int, flighttripid int, seatB int, seatE int, totalSeatB int, totalSeatE int, primary key (flightInstanceid), foreign key (flightTripid) references flightTrip(flightTripID));

/*create seat class table*/
create table seatClass(seatClassId INT, seatClass VARCHAR(10), seatFare INT, primary key(seatClassId));

/*create flight seat */
create table flightSeat (flightseatId INT, flightModelID INT, seatNo int,seatClassId INT, primary key (flightseatId), foreign key(flightModelID) references flightModel(flightModelID), 
foreign key (seatClassId) references seatClass(seatClassId));

/*create customer trip status*/
create table customerTripStatus(conStatusId INT, statusType VARCHAR(10), primary key (conStatusId) );

/*create payment table */
create table payment (paymentID INT , payMethodID INT, paydate timestamp, subtotal INT, primary key (paymentID), foreign key (payMethodID) references payMethod(payMethodID));
ALTER TABLE payment ALTER COLUMN paymentID SET DEFAULT nextval('book_id_seq');

/*create table ticket type*/
create table ticketType(ticketTypeId INT, ticketType VARCHAR(10), primary key (ticketTypeId));

/*create table ticket */
create table ticket (ticketId INT , customerId INT, bookingDate TIMESTAMP, paymentID INT, parentTicketId INT, ticketTypeId INT, paymentStatus VARCHAR(10), primary key (ticketId), 
foreign key (customerId) references customer(customerId),foreign key (paymentID) references payment (paymentID), foreign key (ticketTypeId) references ticketType (ticketTypeId));

ALTER TABLE ticket ALTER COLUMN ticketId SET DEFAULT nextval('book_id_seq');

create table customerTrip(tripId INT , ticketId INT, seatId int, conStatusId INT, flightTripID INT, tripFare INT, customerId INT, flightId INT,primary key (tripId), 
foreign key(ticketId) references ticket(ticketId), foreign key (conStatusId) references customerTripStatus(conStatusId), foreign key (flightTripID) references flightTrip(flightTripID), 
foreign key (customerId) references customer(customerId), foreign key(flightId) references flight(flightId) );

ALTER TABLE customerTrip ALTER COLUMN tripId SET DEFAULT nextval('book_id_seq');

create table final (finalid  int, flighttripid int, seatB int , seatE int,  dollars int, primary key (finalid), foreign key (flighttripid)  references flightTrip(flighttripid));

ALTER TABLE final ALTER COLUMN finalid SET DEFAULT nextval('book_id_seq');