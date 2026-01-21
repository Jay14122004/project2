-- SELECT * FROM hc.users;
-- CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- BEGIN TRANSACTION;
-- 	INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,is_active,is_deleted,birth_date,address,mobile_number,role_id)
-- 		VALUES
-- 	('deep','barvadiya','deep@gmail.com',crypt('2356',gen_salt('bf')),'cfd236e1-301c-4e05-bc1e-a8dc9a8bb1c4','2026-01-21','cbdb1f67-5ce9-4f2a-a756-182b3f6df012','2026-01-21',false,false,'2004-12-14','prestige','5623674351','8ce272c6-8a07-4a55-88ca-0c8fa05708f0');                                                                  

-- 	UPDATE hc.users
-- 	SET is_active='true'
-- 	WHERE first_name='deep';

-- COMMIT TRANSACTION;

-- BEGIN TRANSACTION;
-- 	INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,is_active,is_deleted,birth_date,address,mobile_number,role_id)
-- 		VALUES
-- 	('vrajesh','sardhara','vrajesh@gmail.com',crypt('2696',gen_salt('bf')),'314d81ea-05fa-43a9-acb6-cd0e94704aba','2026-01-20','880eb8bb-e10d-4a5b-bdf1-d076e9b23f7e','2026-01-21',true,false,'2002-12-27','ayodhya parisar','5627375496','951bef29-1923-4d6a-9656-be03c0c70272'); 

-- INSERT INTO hc.roles(role_name,created_date)
-- 	VALUES
-- 	('recepcinist','2026-01-21');

-- COMMIT TRANSACTION;


-- SELECT * FROM hc.roles;
-- CREATE ROLE db_admin;
-- CREATE ROLE app_owner;
-- CREATE ROLE app_user;
-- CREATE ROLE app_readonly;


-- db_admin

GRANT CONNECT ON DATABASE homecare_db TO db_admin;
GRANT CREATE,USAGE ON SCHEMA public TO db_admin;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO db_admin;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO db_admin;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON TABLES TO db_admin;

-- app_owner

GRANT CONNECT ON DATABASE homecare_db TO app_owner;
GRANT CREATE,USAGE ON SCHEMA public TO app_owner;


-- app_user

GRANT CONNECT ON DATABASE homecare_db TO app_user;
GRANT USAGE,CREATE ON SCHEMA public TO app_user;

GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA public TO app_user;


-- app_readonly

GRANT CONNECT ON DATABASE homecare_db TO app_readonly;
GRANT USAGE ON SCHEMA hc TO app_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA hc TO app_readonly;

-- revoke

REVOKE DELETE ON TABLE hc.users FROM app_readonly;

-- demostrate
--  schema level


GRANT CREATE ON SCHEMA hc TO app_readonly;
REVOKE CREATE ON SCHEMA hc FROM app_readonly;

-- table level

GRANT DELETE ON TABLE hc.users TO app_readonly;
REVOKE DELETE ON TABLE hc.users FROM app_readonly;


-- public

REVOKE ALL PRIVILEGES ON SCHEMA hc FROM PUBLIC;
REVOKE ALL PRIVILEGES ON DATABASE homecare_db FROM PUBLIC;




GRANT SELECT,UPDATE,INSERT,DELETE ON ALL TABLES IN SCHEMA hc TO app_user;

GRANT SELECT ON ALL TABLES IN SCHEMA hc TO app_readonly;


-- REVOKE CREATE ON SCHEMA hc FROM app_user;

-- REVOKE TRUNCATE ON ALL TABLES IN SCHEMA hc FROM app_user;
