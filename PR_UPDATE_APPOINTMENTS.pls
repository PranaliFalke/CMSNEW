create or replace PROCEDURE pr_update_appointments
AS
BEGIN

  UPDATE appointment
  SET APPOINTMENT_DATETIME= null
     ,CHECKIN_DATETIME  = NULL
     ,CHECKOUT_DATETIME = NULL
     ,CHECKED_OUT_BY = NULL
     ,IS_CLIENT_BROUGHT_DOCS = NULL
     ,IS_CLIENT_PROVIDED_RA = NULL
  where appointment_datetime is not null;--to_char(trunc(appointment_datetime,'dd'))=to_char(sysdate); 
  
  UPDATE appointment
  SET APPOINTMENT_DATETIME= systimestamp+interval '3' hour
     ,CHECKIN_DATETIME  = NULL 
     ,CHECKOUT_DATETIME = NULL
  WHERE appointment_id IN (65,21,1,44,116,119,120,122);
  UPDATE appointment
  SET APPOINTMENT_DATETIME= systimestamp+interval '4' hour
     ,CHECKIN_DATETIME  = NULL
     ,CHECKOUT_DATETIME = NULL
  WHERE appointment_id IN (92,66,69,115,174,117,121);

  UPDATE appointment
  SET APPOINTMENT_DATETIME= systimestamp+interval '6' hour
     ,reschedule_count = 0
     ,appointment_status_id = 1919
     ,CHECKIN_DATETIME  = NULL
     ,CHECKOUT_DATETIME = NULL
  WHERE appointment_id IN (94,84,88,89,90,118,123);
  
update appointment set appointment_datetime = systimestamp where appointment_id in (82,93,41,61,67);

delete from ra_checkin_appointment where appointment_id in 
(select appointment_id from appointment where appointment_datetime is not null and CHECKIN_DATETIME is null);

  UPDATE appointment
  SET CHECKIN_DATETIME  = APPOINTMENT_DATETIME
      ,CHECKOUT_DATETIME = NULL
      ,CHECKED_OUT_BY = NULL
      ,SM_SITE_ID = 1
      ,IS_CLIENT_BROUGHT_DOCS =  'Y'
      ,IS_CLIENT_PROVIDED_RA =  'Y'     
  WHERE appointment_id IN (82,93,41,61,67,116,117,118,119,120,121,122,123);

INSERT INTO RA_CHECKIN_APPOINTMENT(APPOINTMENT_ID,RA_LOOKUP_ID,OTHER_RA,CREATED_DATE,UPDATED_DATE,CREATED_BY_ID,UPDATED_BY_ID) 
VALUES 
(82,1,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,5,5);
INSERT INTO RA_CHECKIN_APPOINTMENT(APPOINTMENT_ID,RA_LOOKUP_ID,OTHER_RA,CREATED_DATE,UPDATED_DATE,CREATED_BY_ID,UPDATED_BY_ID) 
VALUES 
(93,1,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,5,5);
INSERT INTO RA_CHECKIN_APPOINTMENT(APPOINTMENT_ID,RA_LOOKUP_ID,OTHER_RA,CREATED_DATE,UPDATED_DATE,CREATED_BY_ID,UPDATED_BY_ID) 
VALUES 
(41,1,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,5,5);
INSERT INTO RA_CHECKIN_APPOINTMENT(APPOINTMENT_ID,RA_LOOKUP_ID,OTHER_RA,CREATED_DATE,UPDATED_DATE,CREATED_BY_ID,UPDATED_BY_ID) 
VALUES 
(61,1,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,5,5);
INSERT INTO RA_CHECKIN_APPOINTMENT(APPOINTMENT_ID,RA_LOOKUP_ID,OTHER_RA,CREATED_DATE,UPDATED_DATE,CREATED_BY_ID,UPDATED_BY_ID) 
VALUES 
(67,1,NULL,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,5,5);

  UPDATE CASE_ACTIVITY
  SET ACTIVITY_STATUS_ID  = 2336
      ,CMS_USER_ID = 5
      ,ACTIVITY_END_DATE = NULL
      ,IS_VISIBLE = 'Y'
  WHERE appointment_id IN (82,93,41,61,67);
  
/*
  UPDATE appointment
  SET CHECKIN_DATETIME  = systimestamp+interval '4' hour
  WHERE appointment_id IN (66,94);

update appointment set checkout_datetime = systimestamp+interval '7' hour WHERE appointment_id IN (21,94);
*/

update appointment set first_appointment_datetime = (systimestamp-interval '10' day) where appointment_id IN (42,82,65); --3 appointments
update appointment set first_appointment_datetime = (systimestamp+interval '3' hour) where appointment_id NOT IN (42,82,65,82,184,93); --3 appointments
update appointment set first_appointment_datetime = systimestamp where appointment_id in (82,41,61,67,93);

update appointment set reschedule_count = 2 where appointment_id IN (93,92);

update appointment set appointment_datetime = systimestamp+interval '2' day 
 , first_appointment_datetime = systimestamp+interval '2' day
where appointment_id in 
(145,62,202,70,81,98,99,107,97,114,91);

update appointment set appointment_datetime = systimestamp-interval '1' day
                     , CHECKIN_DATETIME  =  systimestamp   
                     , first_appointment_datetime = systimestamp
where appointment_id in 
(63,68);

update appointment set appointment_datetime = systimestamp+interval '10' day
, first_appointment_datetime = systimestamp+interval '10' day
where appointment_id in 
(83,64,85,110,111,86,95,87,96,108,188,189);--,41,42,43);

UPDATE CASE_ACTIVITY SET CMS_USER_ID = NULL, ACTIVITY_STATUS_ID  = 1066 WHERE APPOINTMENT_ID IN 
(SELECT APPOINTMENT_ID FROM APPOINTMENT WHERE CHECKIN_DATETIME IS NULL AND APPOINTMENT_DATETIME IS NOT NULL);

UPDATE CASE_ACTIVITY SET CMS_USER_ID = 5 WHERE APPOINTMENT_ID IN 
(SELECT APPOINTMENT_ID FROM APPOINTMENT WHERE CHECKOUT_DATETIME IS NOT NULL) AND CMS_USER_ID IS NULL;

UPDATE CASE_ACTIVITY SET ACTIVITY_STATUS_ID  = 1065 WHERE APPOINTMENT_ID IN 
(SELECT APPOINTMENT_ID FROM APPOINTMENT WHERE CHECKOUT_DATETIME IS NOT NULL);

--41,82,115,90,88

UPDATE appointment
  SET CHECKIN_DATETIME  = systimestamp
 where to_char(trunc(appointment_datetime,'dd'))<to_char(sysdate);
 
  COMMIT;
END;