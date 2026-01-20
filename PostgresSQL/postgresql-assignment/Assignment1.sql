-- CREATE SCHEMA hc;

-- CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- CREATE TABLE hc.users(
-- 	user_id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
-- 	first_name VARCHAR(100) NOT NULL,
-- 	last_name VARCHAR(100) NOT NULL,
-- 	email VARCHAR(50) UNIQUE NOT NULL,
-- 	password TEXT NOT NULL,
-- 	created_by UUID NOT NULL,
-- 	created_date DATE DEFAULT CURRENT_DATE,
-- 	modified_by UUID NOT NULL,
-- 	modified_date DATE DEFAULT CURRENT_DATE,
-- 	is_active BOOLEAN NOT NULL DEFAULT TRUE,
-- 	is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
-- 	birth_date DATE,
-- 	address VARCHAR(200),
-- 	mobile_number VARCHAR(15) UNIQUE NOT NULL
-- );



-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,birth_date,address,mobile_number)
-- VALUES
-- ('Axay','kapadiya','axay@example.com',crypt('1234', gen_salt('bf')),'550e8400-e29b-41d4-a716-446655440000','2025-01-01','550e8400-e29b-41d4-a716-446655440000','2025-04-02','1999-04-18','A 123,Park Avenue','9712119065');


-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,birth_date,address,mobile_number)
-- VALUES
-- ('akash','kapadiya','akash@example.com',crypt('2356', gen_salt('bf')),'2773f677-de5d-44dd-b6e4-d765710a0245','2025-02-01','2773f677-de5d-44dd-b6e4-d765710a0245','2025-05-26','2000-03-17','A 124, BALAJI Avenue','9712115065');

-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,is_active,is_deleted,birth_date,address,mobile_number)
-- VALUES
-- ('jaimin','vaghasiya','jaimin@google.com',crypt('2452', gen_salt('bf')),'2773f677-de5d-44dd-b6e4-d765710a0245','2024-12-23','2773f677-de5d-44dd-b6e4-d765710a0245','2025-01-05','false','true','2001-03-16','A 124,Taxshil Apartment','9812165065');


-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,is_active,is_deleted,birth_date,address,mobile_number)
-- VALUES
-- ('prince','vaghasiya','prince@google.com',crypt('9537', gen_salt('bf')),'cfd236e1-301c-4e05-bc1e-a8dc9a8bb1c4','2025-03-27','cfd236e1-301c-4e05-bc1e-a8dc9a8bb1c4','2025-04-20','false','true','2004-03-14','ayodhya Apartment','8781210652');


-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,is_active,is_deleted,birth_date,address,mobile_number)
-- VALUES
-- ('axi','chovatiya','axi@example.com',crypt('9500', gen_salt('bf')),'cfd236e1-301c-4e05-bc1e-a8dc9a8bb1c4','2025-04-20','cfd236e1-301c-4e05-bc1e-a8dc9a8bb1c4','2025-04-29','true','false','2004-12-14','pinal park Apartment','8997937435');


-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,is_active,is_deleted,birth_date,address,mobile_number)
-- VALUES
-- ('Anni','tanna','anni@outlook.com',crypt('8502', gen_salt('bf')),'cbdb1f67-5ce9-4f2a-a756-182b3f6df012','2023-11-20','cefd56fc-5f98-4fdf-98d4-38ab0b562e54','2024-02-25','true','false','2005-02-26','Aradhana Apartment','7523693136');

-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,birth_date,address,mobile_number)
-- VALUES
-- ('aradhy','raghuvanshi','aradhyr@example.com',crypt('5555', gen_salt('bf')),'4918323d-34da-45a1-a75e-568c6818480d','2021-01-23','cbdb1f67-5ce9-4f2a-a756-182b3f6df012','2023-10-02','1998-09-28','b 206,Shiv park','7512120065');


-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,birth_date,address,mobile_number)
-- VALUES
-- ('kishan','bhanderi','kishanb@google.com',crypt('5895', gen_salt('bf')),'4918323d-34da-45a1-a75e-568c6818480d','2022-10-22','cbdb1f67-5ce9-4f2a-a756-182b3f6df012','2023-01-02','1997-08-07','c 23,shiv ganga apartment','8651212332');

-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,birth_date,address,mobile_number)
-- VALUES
-- ('prit','gopani','preet@google.com',crypt('5123', gen_salt('bf')),'f16a1fc1-573f-490b-8c48-1ea88464c9bd','2025-06-21','f16a1fc1-573f-490b-8c48-1ea88464c9bd','2025-07-05','1999-12-08','A 208,shiv dhara apartment','9553260070');

-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,birth_date,address,mobile_number)
-- VALUES
-- ('bhargav','mesiya','bhargav@example.com',crypt('1255', gen_salt('bf')),'4918323d-34da-45a1-a75e-568c6818480d','2023-09-29','cbdb1f67-5ce9-4f2a-a756-182b3f6df012','2024-01-15','2003-11-14','D 703,shukan residency','6652332536');


-- SELECT * FROM hc.users;

-- SELECT CONCAT(first_name,' ',last_name) AS full_name,email
-- FROM hc.users;

-- SELECT * FROM hc.users 
-- WHERE first_name LIKE 'A%' AND last_name LIKE '%i';

-- SELECT * FROM hc.users
-- WHERE is_active = 'false';

-- SELECT * FROM hc.users 
-- WHERE first_name LIKE 'A%' AND last_name LIKE '%i'; 

-- SELECT * FROM hc.users
-- WHERE email LIKE '%@example%';

-- SELECT * FROM hc.users
-- WHERE first_name ILIKE 'A%';


-- SELECT * FROM hc.users
-- ORDER BY created_date DESC;

-- SELECT * FROM hc.users
-- ORDER BY created_date DESC
-- LIMIT 5;

-- SELECT * FROM hc.users
-- ORDER BY created_date DESC
-- OFFSET 5
-- LIMIT 5;



