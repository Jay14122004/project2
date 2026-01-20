-- CREATE VIEW users_details AS
-- SELECT u.user_id,u.first_name || ' ' || u.last_name,u.email,r.role_name
-- FROM hc.users u
-- JOIN hc.roles r
-- ON u.role_id = r.role_id;


-- SELECT * FROM users_details;
-- SELECT * FROM hc.users;


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

-- REFRESH MATERIALIZED VIEW role_per_users;


-- SELECT * FROM role_per_users;

CREATE FUNCTION



