/*creata country table */
/*create table country (countryCode char(3), countryName VARCHAR(20),  primary key (countryCode));*/
insert into country values(10001,'CT1');
insert into country values(10002,'CT2');
insert into country values(10003,'CT3');
insert into country values(10004,'CT4');
insert into country values(10005,'CT5');
insert into country values(10006,'CT6');
insert into country values(10007,'CT7');


/*create table city (cityCode char(4), cityName VARCHAR(20), countryCode char(3), primary key(cityCode), foreign key(countryCode) references country(countryCode));*/
insert into city values(20001,'C1',10001);
insert into city values(20002,'C2',10001);
insert into city values(20003,'C3',10001);
insert into city values(20004,'C4',10001);
insert into city values(20005,'C5',10001);
insert into city values(20006,'C6',10001);
insert into city values(20007,'C7',10001);
insert into city values(20008,'C8',10001);
insert into city values(20009,'C9',10001);
insert into city values(20010,'C10',10001);


/*create table customer(customerId INT, customerName VARCHAR(20), customerGender VARCHAR(6), customerAddress VARCHAR(40), customerDOB DATE, customerPhone BIGINT(10), 
customerCityCode char(4), primary key (customerId), foreign key (customerCityCode) references city(citycode) );*/
insert into customer values(30001,'cus1','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30002,'cus2','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30003,'cus3','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30004,'cus4','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30005,'cus5','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30006,'cus6','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30007,'cus7','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30008,'cus8','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30009,'cus9','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30010,'cus10','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30011,'cus11','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30012,'cus12','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30013,'cus13','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30014,'cus14','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30015,'cus15','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30016,'cus16','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30017,'cus17','female','a1','1999-01-01',1234567890,20001);
insert into customer values(30018,'cus18','female','a1','1999-01-01',1234567890,20001);

/*create table airport(airportCode int, cityCode int, airportName VARCHAR(40), localTax INT(3), internationalTax INT(3), miscellaneouscharges INT, primary key(airportCode), 
foreign key (cityCode) references city(cityCode) );*/
insert into airport values(40001,20001,'a1',8,2,3);
insert into airport values(40002,20002,'a2',8,2,3);
insert into airport values(40003,20003,'a3',8,2,3);
insert into airport values(40004,20004,'a4',8,2,3);
insert into airport values(40005,20005,'a5',8,2,3);
insert into airport values(40006,20006,'a6',8,2,3);
insert into airport values(40007,20007,'a7',8,2,3);
insert into airport values(40008,20008,'a8',8,2,3);
insert into airport values(40009,20009,'a9',8,2,3);
insert into airport values(40010,20010,'a10',8,2,3);

/*create table flightModel(flightModelId INT, flightModelName VARCHAR(15), primary key(flightModelId));*/
insert into flightModel values(50001,'M1');
insert into flightModel values(50002,'M2');
insert into flightModel values(50003,'M3');
insert into flightModel values(50004,'M4');
insert into flightModel values(50005,'M5');
insert into flightModel values(50006,'M6');
insert into flightModel values(50007,'M7');
insert into flightModel values(50008,'M8');
insert into flightModel values(50009,'M9');
insert into flightModel values(50010,'M10');
insert into flightModel values(50011,'M11');

/*payment method*/
/*create table payMethod(payMethodId INT, payType VARCHAR(8), primary key(payMethod));*/

insert into payMethod values(60001,'credit');
insert into payMethod values(60002,'debit');
insert into payMethod values(60003,'cash');
insert into payMethod values(60004,'bitcoin');

/*create table flight*/
/*create table flight(flightId INT, flightName VARCHAR(20), flightModelId INT, flightContry CHAR(3), primary key (flightId), foreign key(flightCountry) references country(countryCode),
#foreign key(flightModelId) references flightModel(flightModelId));*/

insert into flight values(70001,'f1',50001,10001);
insert into flight values(70002,'f2',50001,10002);
insert into flight values(70003,'f3',50001,10003);
insert into flight values(70004,'f4',50001,10004);
insert into flight values(70005,'f5',50001,10005);
insert into flight values(70006,'f6',50001,10001);
insert into flight values(70007,'f7',50001,10002);
insert into flight values(70008,'f8',50001,10003);
insert into flight values(70009,'f9',50001,10004);
insert into flight values(70010,'f10',50001,10005);

/*create table flightSchedule(flightScheduleId INT, flightId INT, originalAirCode int, destAirCode int, startTime timestamp, duration INT, validfrom DATE, validtill DATE, fair INT,
Monday BOOLEAN, Tuesday BOOLEAN, Wednesday BOOLEAN, Thurday BOOLEAN, Friday BOOLEAN, Saturday BOOLEAN, Sunday BOOLEAN, internationalflight BOOLEAN, primary key (flightScheduleId), 
foreign key (originalAirCode) references airport(airportCode), foreign key (destAirCode) references airport(airportCode), foreign key (flightId) references flight(flightId));*/

insert into flightSchedule values(80001,70001,40001,40002,'2019-05-12 04:01',4,'2019-03-01','2019-03-25', 200, 'true','false','false','false','false','false','false','false');
insert into flightSchedule values(80002,70002,40002,40003,'2019-05-12 04:01',4,'2019-03-01','2019-03-25', 200, 'true','false','false','false','false','false','false','false');
insert into flightSchedule values(80003,70003,40003,40004,'2019-05-12 04:01',4,'2019-03-01','2019-03-25', 200, 'true','false','false','false','false','false','false','false');
insert into flightSchedule values(80004,70004,40004,40005,'2019-05-12 04:01',4,'2019-03-01','2019-03-25', 200, 'true','false','false','false','false','false','false','false');
insert into flightSchedule values(80005,70005,40005,40006,'2019-05-12 04:01',4,'2019-03-01','2019-03-25', 200, 'true','false','false','false','false','false','false','false');

/*create flight status table*/
/*create table flightTripStatus(flightStatusId INT, flightStatus VARCHAR(10), primary key(flightStatusId));*/

insert into  flightTripStatus values(90001,'cancel');
insert into  flightTripStatus values(90002,'delay');
insert into  flightTripStatus values(90003,'ontime');


/* create flight trip*/
/*create table flightTrip(flightTripID INT, actualDuration INT, actualSourceStartTime TIMESTAMP, flightScheduleId INT,flightStatusId INT, flightId INT, scheduleSourceStartDate timestamp, primary key (flightTripID),
foreign key (flightScheduleId) references flightSchedule(flightScheduleId), foreign key (flightStatusId) references flightTripStatus(flightStatusId), foreign key (flightId) references flight(flightId));
*/
insert into flightTrip values(100001, 5, null,80001,90003,70001,'2019-05-12 04:01'); 
insert into flightTrip values(100002, 5, null,80002,90003,70002,'2019-05-12 04:01'); 
insert into flightTrip values(100003, 5, null,80003,90003,70003,'2019-05-12 04:01'); 
insert into flightTrip values(100004, 5, null,80004,90003,70004,'2019-05-12 04:01'); 
insert into flightTrip values(100005, 5, null,80005,90003,70005,'2019-05-12 04:01'); 


/*create table flightInstance(flightInstanceid int, flighttripid int, seatB int, seatE int, primary key (flightInstanceid), foreign key (flightTripid) references flightTrip(flightTripID));*/
insert into  flightInstance values(300,100001,19,38,20,40);
insert into  flightInstance values(301,100002,20,39,20,40);
insert into  flightInstance values(302,100003,20,40,20,40);
insert into  flightInstance values(303,100004,20,40,20,40);
insert into  flightInstance values(304,100005,20,40,20,40);


/*create seat class table*/
/*create table seatClass(seatClassId INT, seatClass VARCHAR(10), seatFair INT, primary key(seatClassId));*/

insert into seatClass values(0,'economy',35);
insert into seatClass values(1,'business',85);

/*create flight seat */
/*create table flightSeat (flightseatId INT, flightModelId INT, seatNo int,seatClassId INT, primary key (flightseatId,flightId), foreign key(flightId) references flight(flightId),
 foreign key seatClass(seatClassId));*/
insert into flightSeat values(200001,50001,0001,0);
insert into flightSeat values(200002,50001,0002,0);
insert into flightSeat values(200003,50001,0003,0);
insert into flightSeat values(200004,50001,0004,0);
insert into flightSeat values(200005,50001,0005,0);
insert into flightSeat values(200006,50001,0006,0);
insert into flightSeat values(200007,50001,0007,0);
insert into flightSeat values(200008,50001,0008,0);
insert into flightSeat values(200009,50001,0009,0);
insert into flightSeat values(200010,50001,0010,0);

insert into flightSeat values(200011,50001,0011,0);
insert into flightSeat values(200012,50001,0012,0);
insert into flightSeat values(200013,50001,0013,0);
insert into flightSeat values(200014,50001,0014,0);
insert into flightSeat values(200015,50001,0015,0);
insert into flightSeat values(200016,50001,0016,0);
insert into flightSeat values(200017,50001,0017,0);
insert into flightSeat values(200018,50001,0018,0);
insert into flightSeat values(200019,50001,0019,0);
insert into flightSeat values(200020,50001,0020,0);

insert into flightSeat values(200021,50001,0021,1);
insert into flightSeat values(200022,50001,0022,1);
insert into flightSeat values(200023,50001,0023,1);
insert into flightSeat values(200024,50001,0024,1);
insert into flightSeat values(200025,50001,0025,1);
insert into flightSeat values(200026,50001,0026,1);
insert into flightSeat values(200027,50001,0027,1);
insert into flightSeat values(200028,50001,0028,1);
insert into flightSeat values(200029,50001,0029,1);
insert into flightSeat values(200030,50001,0030,1);

insert into flightSeat values(200031,50001,0031,1);
insert into flightSeat values(200032,50001,0032,1);
insert into flightSeat values(200033,50001,0033,1);
insert into flightSeat values(200034,50001,0034,1);
insert into flightSeat values(200035,50001,0035,1);
insert into flightSeat values(200036,50001,0036,1);
insert into flightSeat values(200037,50001,0037,1);
insert into flightSeat values(200038,50001,0038,1);
insert into flightSeat values(200039,50001,0039,1);
insert into flightSeat values(200040,50001,0040,1);

insert into flightSeat values(200041,50001,0041,1);
insert into flightSeat values(200042,50001,0042,1);
insert into flightSeat values(200043,50001,0043,1);
insert into flightSeat values(200044,50001,0044,1);
insert into flightSeat values(200045,50001,0045,1);
insert into flightSeat values(200046,50001,0046,1);
insert into flightSeat values(200047,50001,0047,1);
insert into flightSeat values(200048,50001,0048,1);
insert into flightSeat values(200049,50001,0049,1);
insert into flightSeat values(200050,50001,0050,1);

insert into flightSeat values(200051,50001,0051,1);
insert into flightSeat values(200052,50001,0052,1);
insert into flightSeat values(200053,50001,0053,1);
insert into flightSeat values(200054,50001,0054,1);
insert into flightSeat values(200055,50001,0055,1);
insert into flightSeat values(200056,50001,0056,1);
insert into flightSeat values(200057,50001,0057,1);
insert into flightSeat values(200058,50001,0058,1);
insert into flightSeat values(200059,50001,0059,1);
insert into flightSeat values(200060,50001,0060,1);


/*create table customerTripStatus(conStatusId INT, statusType VARCHAR(10), primary key (conStatusId) );*/

insert into customerTripStatus values(20,'cancel');
insert into customerTripStatus values(21,'ontime');

/*create payment table */
/*create table payment (paymentID INT, payMethodID INT, paydate timestamp, subtotal INT, primary key (paymentID), foreign key (payMethodID) references payMethod(payMethodID));*/
/*insert into  payment values(3000001, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000002, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000003, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000004, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000005, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000006, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000007, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000008, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000009, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000010, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000011, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000012, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000013, 60001, '2019-02-21 12:00', 567);
insert into  payment values(3000014, 60001, '2019-02-21 12:00', 567);*/

insert into  payment values(1, 60001, '2019-02-21 12:00', 567);
insert into  payment values(2, 60001, '2019-02-21 12:00', 580);
insert into  payment values(3, 60001, '2019-02-21 12:00', 580);

insert into  payment values(4, 60001, '2019-02-21 12:00', 580);	
/*create table ticket type*/
/*create table ticketType(ticketTypeId INT, ticketType VARCHAR(10) primary key (ticketTypeId));*/

insert into ticketType values(31,'round');
insert into ticketType values(32,'multidest');


/*create table ticket */
/*create table ticket (ticketId INT, customerId INT, bookingDate TIMESTAMP, paymentID INT, parentTicketId INT, ticketTypeId INT, paymentStatus VARCHAR(10), primary key (ticketId), 
foreign key (customerId) references customer(customerId),
foreign key (paymentID) references payment (paymentID), foreign key (ticketTypeId) references ticketType (ticketTypeId));*/

--insert into ticket values(4000001,30001,'2019-02-12 02:03',3000001,null,32,'success');
insert into ticket values(1,30001,'2019-02-12 02:03',1,null,32,'success');

insert into ticket values(2,30002,'2019-02-12 02:03',2,null,32,'success');

insert into ticket values(3,30003,'2019-02-12 02:03',3,null,32,'success');

insert into ticket values(4,30003,'2019-02-12 02:03',3,null,32,'success');
/* create consume trip*/
/*create table customerTrip(tripId INT, ticketId INT, seatId int, conStatusId INT, flightTripID INT, tripFare INT, customerId INT, flightId INT,primary key (tripId), 
foreign key(ticketId) references ticket(ticketId), foreign key (conStatusId) references customerTripStatus(conStatusId), foreign key (flightTripID) references flightTrip(flightTripID), 
foreign key (customerId) references customer(customerId), foreign key(flightId) references flight(flightId) );*/

--insert into customerTrip values(5000001,4000001,0001,20,100001,200,30002,70001);
insert into customerTrip values(1,1,0001,20,100001,200,30002,70001);

insert into customerTrip values(2,2,0021,20,100001,300,30003,70001);

insert into customerTrip values(3,3,0023,20,100001,300,30003,70001);

insert into customerTrip values(4,4,0023,20,100002,300,30003,70001);