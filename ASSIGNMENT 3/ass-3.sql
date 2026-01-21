-- Views & Materialized Views

-- CREATE VIEW users_details AS
-- SELECT u.user_id,u.first_name || ' ' || u.last_name AS full_name,u.email,r.role_name
-- FROM hc.users u
-- JOIN hc.roles r
-- ON u.role_id = r.role_id;


-- SELECT * FROM users_details;

-- CREATE VIEW is_active_under_month AS
-- SELECT * FROM hc.users
-- WHERE is_active='true' AND created_date >= CURRENT_DATE - INTERVAL '30 days';

-- SELECT * FROM is_active_under_month;


-- CREATE MATERIALIZED VIEW role_per_users AS
-- SELECT r.role_name,COUNT(*) AS total_users
-- FROM hc.roles r
-- JOIN hc.users u
-- ON r.role_id = u.role_id
-- GROUP BY r.role_name;

-- SELECT * FROM role_per_users;

-- REFRESH MATERIALIZED VIEW role_per_users;

-- Functions


-- SELECT * FROM role_per_users;

-- CREATE OR REPLACE FUNCTION hc.get_user_count_by_role(p_role_id UUID)
-- RETURNS INTEGER
-- LANGUAGE SQL
-- AS $$
-- SELECT COUNT(*)
-- FROM hc.users
-- WHERE role_id = p_role_id;
-- $$;

-- SELECT * FROM hc.get_user_count_by_role('a6f65b5c-9ce1-4829-b353-bc8324fdea37');


-- CREATE OR REPLACE FUNCTION hc.get_user_full_name(p_user_id UUID)
-- RETURNS TEXT
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
-- full_name TEXT;
-- BEGIN
-- SELECT first_name || ' ' || last_name
-- INTO full_name
-- FROM hc.users
-- WHERE user_id = p_user_id;
-- RETURN full_name;
-- END;
-- $$;


-- SELECT * FROM hc.get_user_full_name('314d81ea-05fa-43a9-acb6-cd0e94704aba');



-- CREATE OR REPLACE FUNCTION hc.calculate_age(p_birth_date DATE)
-- RETURNS INTEGER
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     age INTEGER;
-- BEGIN
--     age := (CURRENT_DATE - p_birth_date) / 365;
--     RETURN age;
-- END;
-- $$;
-- SELECT hc.calculate_age('2004-12-14');



-- CREATE OR REPLACE FUNCTION hc.users_created_today()
-- RETURNS TABLE (
--     user_id UUID,
--     first_name VARCHAR,
--     last_name VARCHAR,
--     email VARCHAR
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     RETURN QUERY
--     SELECT 
--         u.user_id,
--         u.first_name,
--         u.last_name,
--         u.email
--     FROM hc.users u
--     WHERE u.created_date = CURRENT_DATE;
-- END;
-- $$;


-- SELECT * FROM hc.users_created_today();


-- CREATE OR REPLACE FUNCTION hc.get_user_email(
-- IN p_user_id UUID,
-- OUT p_email VARCHAR
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- SELECT email INTO p_email
-- FROM hc.users
-- WHERE user_id = p_user_id;
-- END;
-- $$;



-- SELECT * FROM hc.get_user_email('fcae6878-c907-4ee1-bc60-cc91ed087679');


-- CREATE OR REPLACE FUNCTION hc.get_user_detail(p_user_id UUID)
-- RETURNS TABLE(
-- 	first_name VARCHAR(50),
-- 	last_name VARCHAR(50)
-- )
-- LANGUAGE plpgsql
-- AS $$
-- 	BEGIN
-- 	RETURN QUERY
-- 	SELECT u.first_name,u.last_name
-- 	FROM hc.users u
-- 	WHERE user_id = p_user_id;
-- 	END;
-- $$;


-- SELECT * FROM hc.get_user_detail('ab867a64-0fa0-46d3-b69b-31dd061b1e2f');


-- Stored Procedures

-- CREATE OR REPLACE PROCEDURE hc.insert_user(
-- p_first_name VARCHAR,
-- p_last_name VARCHAR,
-- p_email VARCHAR,
-- p_password TEXT,
-- p_created_by UUID,
-- p_mobile VARCHAR,
-- p_birth_date DATE,
-- p_address VARCHAR,
-- p_role_id UUID
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- IF EXISTS (SELECT 1 FROM hc.users WHERE email = p_email) THEN
-- RAISE EXCEPTION 'Email already exists';
-- END IF;


-- INSERT INTO hc.users (
-- first_name, last_name, email, password,
-- created_by, modified_by, created_date, modified_date,birth_date,address, mobile_number,role_id
-- ) VALUES (
-- p_first_name, p_last_name, p_email,
-- crypt('2356', gen_salt('bf')),
-- p_created_by, p_created_by, CURRENT_DATE, CURRENT_DATE,p_birth_date,p_address, p_mobile,p_role_id
-- );
-- END;
-- $$;


-- CALL hc.insert_user('aditya','dave','aditya555@gmail.com','adiytya@2003','1f4e0a30-53fb-442c-8fae-126de36639fa','8469712119','2005-12-15','canal road','f2fe24b9-93d1-4a9c-8fee-fe9d7a674f10');


-- CREATE OR REPLACE PROCEDURE hc.soft_delete_user(p_user_id UUID)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- UPDATE hc.users
-- SET is_deleted = TRUE
-- WHERE user_id = p_user_id;
-- END;
-- $$;

-- CALL hc.soft_delete_user('0541d19b-7874-4108-9475-db12bc423ee5');


-- CREATE OR REPLACE PROCEDURE hc.update_role(get_user_id UUID,get_role_id UUID)
-- LANGUAGE plpgsql
-- AS $$
-- 	BEGIN
-- 		UPDATE hc.users
-- 		SET role_id = get_role_id
-- 		WHERE user_id = get_user_id;
-- 	END;
-- $$;


-- CALL hc.update_role('4105aa7f-38ed-4730-a97e-85277b87db19','91c49c79-2a88-44ac-9afe-444c771325a7');

-- CREATE TABLE audit_table(
-- 	user_name VARCHAR(50),
-- 	old_role VARCHAR(50),
-- 	new_role VARCHAR(50)
-- );

-- CREATE OR REPLACE PROCEDURE hc.update_role(get_user_id UUID,get_role_id UUID)
-- LANGUAGE plpgsql
-- AS $$

-- 	DECLARE
-- 		user_name VARCHAR(50);
-- 		old_role VARCHAR(50);
-- 		new_role VARCHAR(50);
-- 	BEGIN
-- 		SELECT first_name || ' ' || last_name
-- 		INTO user_name
-- 		FROM hc.users
-- 		WHERE user_id = get_user_id;

-- 		SELECT role_name
-- 		INTO old_role
-- 		FROM hc.users u
-- 		JOIN hc.roles r
-- 		ON u.role_id = r.role_id
-- 		WHERE u.user_id = get_user_id;
	
-- 		UPDATE hc.users
-- 		SET role_id = get_role_id
-- 		WHERE user_id = get_user_id;

-- 		SELECT role_name
-- 		INTO new_role
-- 		FROM hc.users u
-- 		JOIN hc.roles r
-- 		ON u.role_id = r.role_id
-- 		WHERE u.user_id = get_user_id;

-- 		INSERT INTO audit_table (user_name,old_role,new_role) VALUES (user_name,old_role,new_role);
-- 	END;
-- $$;


-- CALL hc.update_role('ccb2a956-8401-40eb-a226-6bd93d31dfba','a6f65b5c-9ce1-4829-b353-bc8324fdea37');
-- SELECT * FROM audit_table;

-- DELETE FROM audit_table
-- WHERE user_name IS NULL;


-- Triggers

-- CREATE OR REPLACE FUNCTION hc.update_modified_date()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- NEW.modified_date = CURRENT_DATE;
-- RETURN NEW;
-- END;
-- $$;


-- CREATE TRIGGER trg_update_modified_date
-- BEFORE UPDATE ON hc.users
-- FOR EACH ROW
-- EXECUTE FUNCTION hc.update_modified_date();


-- UPDATE hc.users
-- SET birth_date = '2003-08-23'
-- WHERE user_id = '95e6e132-433f-4be2-bf81-788592a252ff';


-- CREATE OR REPLACE FUNCTION hc.prevent_user_delete()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- RAISE EXCEPTION 'User deletion is not allowed by admin';
-- END;
-- $$;


-- CREATE TRIGGER trg_prevent_delete
-- BEFORE DELETE ON hc.users
-- FOR EACH ROW
-- EXECUTE FUNCTION hc.prevent_user_delete();

-- DELETE FROM hc.users
-- WHERE birth_date = '2003-08-23';


-- CREATE TABLE hc.user_creation_audit(
--  user_name VARCHAR(50)
-- );

-- CREATE OR REPLACE FUNCTION hc.after_user_insert()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- INSERT INTO hc.user_creation_audit(user_name)
-- VALUES (NEW.first_name || ' ' || NEW.last_name);
-- RETURN NEW;
-- END;
-- $$;


-- CREATE TRIGGER trg_after_user_insert
-- AFTER INSERT ON hc.users
-- FOR EACH ROW
-- EXECUTE FUNCTION hc.after_user_insert();

-- INSERT INTO hc.users(first_name,last_name,email,password,created_by,created_date,modified_by,modified_date,birth_date,address,mobile_number)
-- VALUES ('divyang','nakarani','dvnk@outlook.com',crypt('5555', gen_salt('bf')),'95e6e132-433f-4be2-bf81-788592a252ff','2026-01-20','1b3c731f-5a5e-4603-95d2-ea579953fe32','2026-01-20','2002-02-22','sp hostel','7568998945');


-- SELECT * FROM hc.user_creation_audit;

-- Cursors



-- CREATE OR REPLACE PROCEDURE get_user_id_email()
-- LANGUAGE plpgsql AS $$
-- 	DECLARE
-- 		user_record RECORD;
-- 		user_curl CURSOR FOR 
-- 			SELECT user_id, email FROM hc.users;
-- 	BEGIN
-- 		OPEN user_curl;
-- 		LOOP
-- 		FETCH user_curl INTO user_record;
-- 		EXIT WHEN NOT FOUND;

-- 		RAISE NOTICE 'user_id:- %,email:-%',user_record.user_id,user_record.email;
-- 		END LOOP;
-- 		CLOSE user_curl;
-- 	END;
-- 	$$;




-- CALL get_user_id_email();








