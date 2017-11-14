CREATE USER DEMO_NOMIS_OWNER IDENTIFIED BY DEMO_NOMIS_OWNER TEMPORARY TABLESPACE temp DEFAULT TABLESPACE users;
GRANT CONNECT TO DEMO_NOMIS_OWNER;
GRANT RESOURCE TO DEMO_NOMIS_OWNER;
ALTER USER DEMO_NOMIS_OWNER QUOTA 20G ON USERS;
GRANT UNLIMITED TABLESPACE TO DEMO_NOMIS_OWNER;

grant select on v$database to DEMO_NOMIS_OWNER;

CREATE ROLE DEMO_NOMIS_USER;
GRANT CREATE SESSION TO DEMO_NOMIS_USER;
