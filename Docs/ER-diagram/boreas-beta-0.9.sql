-- Generated by Oracle SQL Developer Data Modeler 3.1.3.706
--   at:        2014-05-20 00:48:09 EEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



CREATE TABLE Cables 
    ( 
     id NUMBER (8)  NOT NULL , 
     Port_id NUMBER (12)  NOT NULL , 
     Service_Location_id NUMBER (12)  NOT NULL , 
     name VARCHAR2 (200) 
    ) 
;



ALTER TABLE Cables 
    ADD CONSTRAINT Cable_PK PRIMARY KEY ( id ) ;


ALTER TABLE Cables 
    ADD CONSTRAINT cbl_unq_prt_id UNIQUE ( Port_id ) ;


ALTER TABLE Cables 
    ADD CONSTRAINT cbl_unq_sl_id UNIQUE ( Service_Location_id ) ;



CREATE TABLE Circuits 
    ( 
     id NUMBER (8)  NOT NULL , 
     Service_Instance_id NUMBER (8)  NOT NULL , 
     Port_id NUMBER (12) , 
     name VARCHAR2 (200) 
    ) 
;


CREATE UNIQUE INDEX crc_indx_port_id ON Circuits 
    ( 
     Port_id ASC 
    ) 
;

ALTER TABLE Circuits 
    ADD CONSTRAINT Circuit_PK PRIMARY KEY ( id ) ;


ALTER TABLE Circuits 
    ADD CONSTRAINT crc_unq_si UNIQUE ( Service_Instance_id ) ;


ALTER TABLE Circuits 
    ADD CONSTRAINT crc_unq_prt_id UNIQUE ( Port_id ) ;



CREATE TABLE Devices 
    ( 
     id NUMBER (8)  NOT NULL , 
     name VARCHAR2 (200) 
    ) 
;



ALTER TABLE Devices 
    ADD CONSTRAINT Device_PK PRIMARY KEY ( id ) ;



CREATE TABLE Ports 
    ( 
     id NUMBER (12)  NOT NULL , 
     Device_id NUMBER (8)  NOT NULL , 
     free CHAR (1) DEFAULT '1' , 
     name VARCHAR2 (200) 
    ) 
;



ALTER TABLE Ports 
    ADD CONSTRAINT Ports_PK PRIMARY KEY ( id ) ;



CREATE TABLE Prices 
    ( 
     id NUMBER (20)  NOT NULL , 
     Provider_Location_id NUMBER (8)  NOT NULL , 
     Service_id NUMBER (5)  NOT NULL , 
     price NUMBER  NOT NULL 
    ) 
;


CREATE UNIQUE INDEX prc_indx_pl_s ON Prices 
    ( 
     Provider_Location_id ASC , 
     Service_id ASC 
    ) 
;

ALTER TABLE Prices 
    ADD CONSTRAINT Price_PK PRIMARY KEY ( id ) ;


ALTER TABLE Prices 
    ADD CONSTRAINT prc_unq_srv_and_pl UNIQUE ( Provider_Location_id , Service_id ) ;



CREATE TABLE Provider_Locations 
    ( 
     id NUMBER (8)  NOT NULL , 
     pos_x NUMBER  NOT NULL , 
     pos_y NUMBER  NOT NULL , 
     address VARCHAR2 (200) , 
     name VARCHAR2 (200) 
    ) 
;



ALTER TABLE Provider_Locations 
    ADD CONSTRAINT Provider_Locations_PK PRIMARY KEY ( id ) ;



CREATE TABLE Roles 
    ( 
     id NUMBER (3)  NOT NULL , 
     Name VARCHAR2 (50)  NOT NULL 
    ) 
;



ALTER TABLE Roles 
    ADD CONSTRAINT Roles_PK PRIMARY KEY ( id ) ;



CREATE TABLE Service_Instances 
    ( 
     id NUMBER (8)  NOT NULL , 
     User_id NUMBER (8)  NOT NULL , 
     Service_Order_id NUMBER (8)  NOT NULL , 
     Status VARCHAR2 (30) , 
     Service_id NUMBER (5)  NOT NULL , 
     name VARCHAR2 (200) 
    ) 
;


CREATE INDEX si_indx_user ON Service_Instances 
    ( 
     User_id ASC 
    ) 
;

ALTER TABLE Service_Instances 
    ADD CONSTRAINT Service_Instances_PK PRIMARY KEY ( id ) ;


ALTER TABLE Service_Instances 
    ADD CONSTRAINT srv_ins_unq_srv_ord UNIQUE ( Service_Order_id ) ;



CREATE TABLE Service_Locations 
    ( 
     id NUMBER (12)  NOT NULL , 
     pos_x NUMBER  NOT NULL , 
     pos_y NUMBER  NOT NULL , 
     address VARCHAR2 (200) , 
     name VARCHAR2 (200) 
    ) 
;



ALTER TABLE Service_Locations 
    ADD CONSTRAINT Service_Locations_PK PRIMARY KEY ( id ) ;



CREATE TABLE Service_Orders 
    ( 
     id NUMBER (8)  NOT NULL , 
     enterDate DATE , 
     procesDate DATE , 
     completeDate DATE , 
     User_id NUMBER (8)  NOT NULL , 
     Service_id NUMBER (5) , 
     Provider_Location_id NUMBER (8)  NOT NULL , 
     Service_Location_id NUMBER (12)  NOT NULL , 
     Status VARCHAR2 (30) DEFAULT 'Entering' , 
     Scenario VARCHAR2 (30)  NOT NULL , 
     Service_Instance_id NUMBER (8) , 
     name VARCHAR2 (200) 
    ) 
;



ALTER TABLE Service_Orders 
    ADD CONSTRAINT srv_ord_to_srv_inst_id_check 
    CHECK (UPPER(Scenario) = 'NEW' OR Service_Instance_id IS NOT NULL)
;


ALTER TABLE Service_Orders 
    ADD CONSTRAINT srv_ord_to_srv__id_check 
    CHECK (UPPER(Scenario) = 'DISCONNECT' OR Service_id IS NOT NULL)
;

CREATE INDEX so_indx_user ON Service_Orders 
    ( 
     User_id ASC 
    ) 
;

ALTER TABLE Service_Orders 
    ADD CONSTRAINT Service_Order_PK PRIMARY KEY ( id ) ;



CREATE TABLE Services 
    ( 
     id NUMBER (5)  NOT NULL , 
     Name VARCHAR2 (50)  NOT NULL , 
     Description VARCHAR2 (300) 
    ) 
;



ALTER TABLE Services 
    ADD CONSTRAINT Service_PK PRIMARY KEY ( id ) ;



CREATE TABLE Tasks 
    ( 
     id NUMBER (12)  NOT NULL , 
     User_id NUMBER (8) , 
     type VARCHAR2 (30) , 
     Status VARCHAR2 (30) , 
     Role_id NUMBER (3)  NOT NULL , 
     Service_Orders_id NUMBER (8)  NOT NULL 
    ) 
;



ALTER TABLE Tasks 
    ADD CONSTRAINT Task_PK PRIMARY KEY ( id ) ;



CREATE TABLE Users 
    ( 
     id NUMBER (8)  NOT NULL , 
     Name VARCHAR2 (50) , 
     email VARCHAR2 (50) , 
     password VARCHAR2 (32)  NOT NULL , 
     blocked CHAR (1) DEFAULT '0' , 
     Role_id NUMBER (3)  NOT NULL 
    ) 
;


CREATE UNIQUE INDEX usr_indx_email ON Users 
    ( 
     email ASC 
    ) 
;

ALTER TABLE Users 
    ADD CONSTRAINT User_PK PRIMARY KEY ( id ) ;


ALTER TABLE Users 
    ADD CONSTRAINT usr_unq_email UNIQUE ( email ) ;




ALTER TABLE Cables 
    ADD CONSTRAINT Cable_Ports_FK FOREIGN KEY 
    ( 
     Port_id
    ) 
    REFERENCES Ports 
    ( 
     id
    ) 
;


ALTER TABLE Cables 
    ADD CONSTRAINT Cables_Service_Locations_FK FOREIGN KEY 
    ( 
     Service_Location_id
    ) 
    REFERENCES Service_Locations 
    ( 
     id
    ) 
;


ALTER TABLE Circuits 
    ADD CONSTRAINT Circuit_Ports_FK FOREIGN KEY 
    ( 
     Port_id
    ) 
    REFERENCES Ports 
    ( 
     id
    ) 
;


ALTER TABLE Circuits 
    ADD CONSTRAINT Circuit_Service_Instance_FK FOREIGN KEY 
    ( 
     Service_Instance_id
    ) 
    REFERENCES Service_Instances 
    ( 
     id
    ) 
;


ALTER TABLE Ports 
    ADD CONSTRAINT Ports_Device_FK FOREIGN KEY 
    ( 
     Device_id
    ) 
    REFERENCES Devices 
    ( 
     id
    ) 
;


ALTER TABLE Prices 
    ADD CONSTRAINT Price_Provider_Location_FK FOREIGN KEY 
    ( 
     Provider_Location_id
    ) 
    REFERENCES Provider_Locations 
    ( 
     id
    ) 
;


ALTER TABLE Prices 
    ADD CONSTRAINT Price_Service_FK FOREIGN KEY 
    ( 
     Service_id
    ) 
    REFERENCES Services 
    ( 
     id
    ) 
;


ALTER TABLE Service_Instances 
    ADD CONSTRAINT Service_Inst_Service_Ord_FK FOREIGN KEY 
    ( 
     Service_Order_id
    ) 
    REFERENCES Service_Orders 
    ( 
     id
    ) 
;


ALTER TABLE Service_Instances 
    ADD CONSTRAINT Service_Instances_Services_FK FOREIGN KEY 
    ( 
     Service_id
    ) 
    REFERENCES Services 
    ( 
     id
    ) 
;


ALTER TABLE Service_Instances 
    ADD CONSTRAINT Service_Instances_Users_FK FOREIGN KEY 
    ( 
     User_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
;


ALTER TABLE Service_Orders 
    ADD CONSTRAINT Service_Ord_Service_Inst_FK FOREIGN KEY 
    ( 
     Service_Instance_id
    ) 
    REFERENCES Service_Instances 
    ( 
     id
    ) 
;


ALTER TABLE Service_Orders 
    ADD CONSTRAINT Service_Order_ProvLoc_FK FOREIGN KEY 
    ( 
     Provider_Location_id
    ) 
    REFERENCES Provider_Locations 
    ( 
     id
    ) 
;


ALTER TABLE Service_Orders 
    ADD CONSTRAINT Service_Order_ServLoc_FK FOREIGN KEY 
    ( 
     Service_Location_id
    ) 
    REFERENCES Service_Locations 
    ( 
     id
    ) 
;


ALTER TABLE Service_Orders 
    ADD CONSTRAINT Service_Order_Service_FK FOREIGN KEY 
    ( 
     Service_id
    ) 
    REFERENCES Services 
    ( 
     id
    ) 
;


ALTER TABLE Service_Orders 
    ADD CONSTRAINT Service_Order_User_FK FOREIGN KEY 
    ( 
     User_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
;


ALTER TABLE Tasks 
    ADD CONSTRAINT Tasks_Roles_FK FOREIGN KEY 
    ( 
     Role_id
    ) 
    REFERENCES Roles 
    ( 
     id
    ) 
;


ALTER TABLE Tasks 
    ADD CONSTRAINT Tasks_Service_Orders_FK FOREIGN KEY 
    ( 
     Service_Orders_id
    ) 
    REFERENCES Service_Orders 
    ( 
     id
    ) 
;


ALTER TABLE Tasks 
    ADD CONSTRAINT Tasks_Users_FK FOREIGN KEY 
    ( 
     User_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
;


ALTER TABLE Users 
    ADD CONSTRAINT User_Roles_FK FOREIGN KEY 
    ( 
     Role_id
    ) 
    REFERENCES Roles 
    ( 
     id
    ) 
;

CREATE OR REPLACE VIEW usergroup AS
SELECT Users.email,
  Roles.Name
FROM Users
INNER JOIN Roles
ON Users.Role_id = Roles.id ;




CREATE OR REPLACE FUNCTION md5(input_string IN VARCHAR2) RETURN VARCHAR2
  IS
  hex_digest varchar2(32);
  digest varchar2(16);
  BEGIN
  digest := DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT_STRING => input_string);
  SELECT Lower(RAWTOHEX(digest)) INTO hex_digest FROM dual;
  RETURN hex_digest;
  END;
/
CREATE SEQUENCE cbl_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER cbl_id_TRG 
BEFORE INSERT ON Cables 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT cbl_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE crt_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER crt_id_TRG 
BEFORE INSERT ON Circuits 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT crt_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE dev_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER dev_id_TRG 
BEFORE INSERT ON Devices 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT dev_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE prt_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER prt_id_TRG 
BEFORE INSERT ON Ports 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT prt_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE prc_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER prc_id_TRG 
BEFORE INSERT ON Prices 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT prc_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE prloc_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER prloc_id_TRG 
BEFORE INSERT ON Provider_Locations 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT prloc_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE rls_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER rls_id_TRG 
BEFORE INSERT ON Roles 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT rls_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE SI_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SI_id_TRG 
BEFORE INSERT ON Service_Instances 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT SI_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE srvloc_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER srvloc_id_TRG 
BEFORE INSERT ON Service_Locations 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT srvloc_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE SO_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER SO_id_TRG 
BEFORE INSERT ON Service_Orders 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT SO_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE srv_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER srv_id_TRG 
BEFORE INSERT ON Services 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT srv_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE tsk_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER tsk_id_TRG 
BEFORE INSERT ON Tasks 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT tsk_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/

CREATE SEQUENCE usr_id_SEQ 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER usr_id_TRG 
BEFORE INSERT ON Users 
FOR EACH ROW 
WHEN (NEW.id IS NULL) 
BEGIN 
    SELECT usr_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             5
-- ALTER TABLE                             41
-- CREATE VIEW                              1
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          1
-- CREATE TRIGGER                          13
-- ALTER TRIGGER                            0
-- CREATE STRUCTURED TYPE                   0
-- CREATE COLLECTION TYPE                   0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                         13
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
