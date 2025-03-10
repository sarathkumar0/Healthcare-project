sql final project 

///Healthcare Appointment scheduling system


create database Healthcare;

use healthcare

create table patients(

patients_id int primary key,
name varchar(30),
date_of_birth varchar(20),
phone_number varchar(20))

create table doctors( 

name varchar(30),
doctor_id int,
place varchar(30),
foreign key (doctor_id) references patients (patients_id))

create table appointment( 

appointment_id int,
doctor_id int,  
patients_id int,
phone_number varchar(15),
foreign key (patients_id) references patients (patients_id),
foreign key (doctor_id) references doctors (doctor_id))

create table  medicalhistories(

history_id int,
patients_id int,
name varchar(30),
records_date varchar(30),
foreign key (patients_id) references patients (patients_id))


create table appiontmentslots(

doctor_id int,
name varchar(30),
slots_date varchar(20),
foreign key (doctor_id) references doctors (doctor_id))

create table record( 

name varchar(30),
record_date varchar(20),
place varchar(30),
doctor_name varchar(10),
patient_name varchar(20),
patients_id int,
foreign key (patients_id) references patients (patients_id))

create table hospital( 

hospital_name varchar(30),
doctor_name varchar(20),
doctor_id int,
 foreign key (doctor_id) references doctors (doctor_id))
 
Insert into patients ( patients_id, name, date_of_birth, phone_number ) values
(1,'vishal','2002-09-11','3655896854'),
(2,'muthuvel','2003-07-12','4545628518'),
(3,'gokulnath','2004-05-13','4458215967'),
(4,'nithish','2001-04-20','4851289624'),
(5,'sarath','2003-09-27','7485120090');

Insert into doctors ( name, doctor_id, place ) values
("vimmal", 1,"chennai"),
("sowdarya",2,"newyork"),
("sachin",3,"america"),
("dharshini",4,"arcot"),
("john",5,"newzealand");

Insert into appointment ( appointment_id, doctor_id, patients_id, phone_number ) values
(101, 1, 1,"7485961230"),
(102, 2, 2,"6352417890"),
(103, 3, 3,"8596741236"),
(104, 4, 4,"7596841256"),
(105, 5, 5,"936195688"); 

Insert into medicalhistories ( history_id, patients_id, name, records_date ) values
(001, 1,"vishal", "2001-02-20"),
(002, 2, "gokulath", "2003-09-27"),
(003, 3, "muthuvel", "2004-03-22"),
(004, 4, "nithish", "2006-01-23"),
(005, 5, "sarath", "2003-09-27"); 

Insert into appiontmentslots ( doctor_id, name, slots_date ) values
(1, "dr.smith","2026-01-11"),
(2, "dr.john", "2027-02-12"),
(3, "dr.sam", "2006-07-13"),
(4,"dr.sound","2005-08-14"),
(5,"dr.maran","2004-04-25");

Insert into record( name, record_date, place, doctor_name, patient_name, patients_id ) values
("saran", "2001-02-20", "chennai", "dr.john", "vishal", 1 ),
("gunal", "2003-09-27", "newyork", "dr.smith", "gokulnath", 2),
("kishore","2004-03-22", "america", "dr.sam", "muthuvel", 3 ),
("babu", "2006-01-23", "arcot", "dr.sound", "nitish", 4 ),
("ravindra","2003-09-27","newzealand", "dr.maran", "sarath", 5 );

Insert into hospital( hospital_name, doctor_name, doctor_id ) values
("apollo","dr.smith", 1),
("kavery"," dr.john", 2),
("rajiv","dr.sam", 3), 
("global","dr.sound", 4),
("health","dr.maran", 5);

select p.name as patientname, d.name as doctors, d.place, p.phone_number
from patients as p
join doctors as d on p.patients_id = d.doctor_id

select d.doctor_id, a.appointment_id, a.phone_number
from doctors as d
join appointment as a on d.doctor_id = d.doctor_id

select m.history_id, a.doctor_id, a.phone_number,m.records_date
from appointment as a
join medicalhistories as m on m.patients_id = a.doctor_id 

select a.doctor_id, a.name, a.slots_date, m.records_date
from medicalhistories as m
join appiontmentslots as a on m.patients_id = a.doctor_id

select r.patients_id, doctor_name, r.patient_name, r.place
from appiontmentslots as a
join record as r on r.patients_id = a.doctor_id

select h.hospital_name, h.doctor_name, r.place
from record as r
join hospital as h on h.doctor_id = r.patients_id

select p.name, d.name, p.phone_number
from patients as p, doctors as d
where  p.name = d.name 

select p.patients_id,  d.doctor_id, p.name
from patients as p, doctors as d
where p.patients_id = d.doctor_id

select d.doctor_id, a.appointment_id,  d.place
from appointment as a, doctors as d
where d.doctor_id = a.appointment_id

select m.history_id, a.patients_id, m.name, m.records_date
from medicalhistories as m, appointment as a
where m.history_id = a.patients_id

select count(*) from patients

select count(*) from doctors

select count(*) from appointment

select count(*) from medicalhistories

select count(*) from appiontmentslots

select count(*)  from hospital

select count(*) from record

select max(doctor_id) from doctors

select avg(doctor_id) from doctors

select max(records_date) from medicalhistories

select count(patients_id) from appointment

select count(phone_number) from appointment

select
patients_id,
count(h.doctor_name) as no_of_doc
from
hospital h
left join
record as r on h.doctor_id = r.patients_id
group by
patients_id;

select
doctor_id,
count(r.name) as no_of_na
from 
hospital h
left join
record as r on h.doctor_id = r.patients_id
group by
doctor_id;

select 
patients_id,
count(r.doctor_name) as no_of_doc
from 
hospital
left join
record as r on r.patients_id = r.patients_id
group by
patients_id;

select * from doctors limit 2

select * from patients limit 4

select * from medicalhistories limit 3

select * from appointment limit 5

select * from record limit 4

select count(place) from record

delimiter //
create trigger final
after insert on appointment
for each row
begin
insert into  medicalhistories (patients_id,doctor_id) values
(new.patients_id,new.doctor_id);
end ;
//
delimiter ;

delimiter //
create trigger final2
after insert on record
for each row
begin
insert into  hospital (doctor_name) values
(new.doctor_name);
end ;
//
delimiter 

delimiter //
create trigger final4
after insert on doctors
for each row
begin
insert into appointment  (doctor_id) values
(new.doctor_id);
end ;
//
delimiter 

delimiter //
create trigger mom
after insert on appointment
for each row
begin
insert into medicalhistories  (patients_id) values
(new.patients_id);
end ;
//
delimiter 

select* from patients order by patients_id 

select * from doctors order by place

select * from appointment order by phone_number

select * from medicalhistories order by records_date

select * from medicalhistories order by history_id 

delimiter //
create trigger boy
after insert on medicalhistories
for each row
begin
insert into record (patients_id) values
(new.patients_id);
end ;
//
delimiter 

delimiter //
create trigger rash
after insert on record 
for each row
begin
insert into hospital (doctor_id) values
(new.patients_id);
end ;
//
delimiter 

delimiter //
create trigger hi
after insert on hospital 
for each row
begin
insert into appointslots (doctor_id) values
(new.doctor_id);
end ;
//
delimiter 

delimiter //
create trigger end
after insert on  appiontmentslots
for each row
begin
insert into record (doctor_id) values
(new.doctor_id);
end ;
//
delimiter 

select * from patients

select * from doctors

select * from appointment

select * from medicalhistories

select * from appiontmentslots

select * from record

select * from hospital

;