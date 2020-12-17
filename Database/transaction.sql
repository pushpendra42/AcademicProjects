--customerid="select customerid from customer order by random() limit 1 ;"
--flighttripid, flightid ="select flighttripid, flightid from flighttrip order by random() limit 1;
-- seatclassid="select seatclassid from seatclass order by random () limit 1 ;" return bsuiness or econamy
tripfare="select sum(fare+seatfare) from (select fare from flighttrip  join flightschedule on flighttrip.flightScheduleId=flightschedule.flightScheduleId where flighttrip.flighttripid=flighttripid (this is a valuable )) as a, seatclass where seatclassid=0 ;"
---currentseat=select * from flightinstance where flightTripid=flightTripid(this is a valuable) and seatclass(this is a valuable )=0;
---if currentseat=0 --break
---paymethodid="select payMethodID from payMethod order by random() limit 1 ;"
---begin;
---savepoint init;
--payment="insert into payment values(3000016,60001,'2019-04-12 4:22',235) returning paymentID;"
insert into payment(payMethodID, paydate,subtotal)  values(60001,now(),235) returning paymentID;
---not required ---paymentid=select paymentid from paymentid where paymentid=paymentid(this is a valuable)
---insert into ticket(customerId, bookingDate,paymentID, parentTicketId,ticketTypeId) values(30001,'2019-04-12 4:22',3000016,null,32) returning ticketid;
--ticketid="insert into ticket(customerId, bookingDate,paymentID) values(customerid,now(),paymentid) returning ticketid ; "

-- change   u need to generate seatid random,  for Business (0,20) economy(20,60), i use seatNo=1 flighttripid=100001 to test
if seatClass= seatB then -- generate seatNo range(1,20) end if
if seatClass=seatE then --generate seatNo range(21,60) end if

--program--------------------------this query is to make sure that seatNo exist or not
select seatid from customertrip where flightTripid=100001 and seatid =1;
--sql
seatid="select seatid from customertrip where flightTripid=flightTripid(this is the valuable) and seatid =seatNo(this is the valuable) ;"
--if seatid is not null, mean the seat is not avaliable 
if seatid != null then rollback to init end if ;
---tripid=insert into customertrip(ticketid,seatid,flightTripID,tripfare,customerid,flightid) values(ticketid, seatid,flightTripid, tripfare,customerid,flightid) returning tripid  ;
---update flightinstance set seatB=seatB-1 where flighttripid=100001;
--update flightinstance set seatB=seatB-1 where flighttripid=flighttripid(this is a valuable);
commit;

