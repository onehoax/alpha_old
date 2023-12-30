/*
  ================================================== Users ==================================================
*/

/*
  This is for demonstration purposes only
  Registration of new users in the actual app will be as follows:
    1. User registers with:
       - given names
       - last names
       - email
       - government_id (serves as password)
       - cell_#
       - dob
    2. The system saves the user in 'app_user' table and doesn't give it any role
    3. An admin user can then modify the recently registered user to give it specific roles

  A user_role record only depends on an app_user and/or a role; if a given user and/or role is deleted, the corresponding user_role record is deleted automatically.
  However, since the user_role table contains info about all roles (client and trainer sub-types), whenever a client and/or trainer is deleted (or a sub-type of them),
  the corresponding records in user_role must be deleted manually; same goes for updates.
*/

-- user with admin and trainer (general) roles
WITH
  -- insert the user in the users table
  usr AS (
    INSERT INTO app_user
    (given_names, last_names, government_id, email, cell_phone_number, dob, updated_at)
    VALUES
    ('Carlos Andres', 'Osorio Giraldo', '1088291213', 'carlos@email.com', '123456', '1991-02-15',  now())
    RETURNING user_id
  ),
  -- insert the corresponding roles for the user
  role AS (
    INSERT INTO user_role
    (user_id, role_id, updated_at)
    VALUES 
    ((SELECT usr.user_id FROM usr), 2, now()),
    ((SELECT usr.user_id FROM usr), 3, now())
  )
  -- since this user is admin and trainer, create a corresponding record in the trainer table
INSERT INTO trainer 
(trainer_id, updated_at)
SELECT 
  usr.user_id,
  now()
FROM 
  usr
;

-- user with trainer role; trainer is both 'sports profesional' and 'physio'
WITH
  usr AS (
    INSERT INTO app_user
    (given_names, last_names, government_id, email, cell_phone_number, dob, updated_at)
    VALUES
    ('Mauricio', 'Solano', '1088656414', 'mauro@email.com', '123456', '1990-05-11', now())
    RETURNING user_id
  ),
  -- insert the corresponding roles for the user
  role AS (
    INSERT INTO user_role
    (user_id, role_id, updated_at)
    VALUES 
    ((SELECT usr.user_id FROM usr), 3, now()),
    ((SELECT usr.user_id FROM usr), 4, now()),
    ((SELECT usr.user_id FROM usr), 5, now())
  )
-- since this user is trainer, create a corresponding record in the trainer table
INSERT INTO trainer 
(trainer_id, updated_at)
SELECT 
  usr.user_id,
  now()
FROM 
  usr
;

-- user with client role; client is of type 'athelte' and 'injured'
WITH
  usr AS (
    INSERT INTO app_user
    (given_names, last_names, government_id, email, cell_phone_number, dob, updated_at)
    VALUES
    ('Manuela', 'Cardona', '1088547777', 'nela@email.com', '123456', '1995-09-19', now())
    RETURNING user_id
  ),
  -- insert the corresponding roles for the user
  role AS (
    INSERT INTO user_role
    (user_id, role_id, updated_at)
    VALUES 
    ((SELECT usr.user_id FROM usr), 6, now()),
    ((SELECT usr.user_id FROM usr), 7, now()),
    ((SELECT usr.user_id FROM usr), 8, now())
  ),
  -- since this user is client, create a corresponding record in the client table
  client AS (
    INSERT INTO client
    (client_id, is_active, age, updated_at)
    SELECT 
      usr.user_id,
      true,
      29,
      now()
    FROM 
      usr
  ),
  -- every client as an injury_history
  injury_record AS (
    INSERT INTO injury_history
    (client_id, title, description, updated_at)
    VALUES
    ((SELECT user_id FROM usr), 'ankle twist', 'twsited ankle while playing sports', now())
  ),
  -- since this client is injured, create a corresponding record in the client_injured table
  client_injured AS (
    INSERT INTO client_injured
    (client_injured_id, injury_type, sport_type, updated_at)
    SELECT
      usr.user_id, 
      'knee injury',
      'futbol',
      now()
    FROM 
      usr
  )
-- since this client is an athlete, create a corresponding record in the client_athlete table
INSERT INTO client_athlete
(client_athlete_id, sport, objective, updated_at)
SELECT
  usr.user_id, 
  'futbol',
  'get better',
  now()
FROM 
  usr
;

-- user with client role; client is of type 'injured'
WITH
  usr AS (
    INSERT INTO app_user
    (given_names, last_names, government_id, email, cell_phone_number, dob, updated_at)
    VALUES
    ('Nicolas', 'Correa', '1088789321', 'nico@email.com', '123456', '1991-09-12', now())
    RETURNING user_id
  ),
  -- insert the corresponding roles for the user
  role AS (
    INSERT INTO user_role
    (user_id, role_id, updated_at)
    VALUES 
    ((SELECT usr.user_id FROM usr), 6, now()),
    ((SELECT usr.user_id FROM usr), 7, now())
  ),
  -- since this user is client, create a corresponding record in the client table
  client AS (
    INSERT INTO client
    (client_id, is_active, age, updated_at)
    SELECT 
      usr.user_id,
      true,
      31,
      now()
    FROM 
      usr
  ),
  -- every client as an injury_history
  injury_record AS (
    INSERT INTO injury_history
    (client_id, title, description, updated_at)
    VALUES
    ((SELECT user_id FROM usr), 'ACL tear', 'Tore ACL playing soccer', now()),
    ((SELECT user_id FROM usr), 'Ankle sprain', 'Sprained ankle: 3 degree', now())
  )
-- since this client is injured, create a corresponding record in the client_injured table
INSERT INTO client_injured
(client_injured_id, injury_type, sport_type, updated_at)
SELECT
  usr.user_id, 
  'knee injury',
  'futbol',
  now()
FROM 
  usr
;

-- get all possible roles
SELECT * FROM role;

-- get all users
SELECT * FROM app_user;

-- get all trainers
SELECT 
  t.trainer_id, u.given_names 
FROM 
  trainer t
  JOIN app_user u ON t.trainer_id = u.user_id
;

-- get all clients
SELECT 
  c.client_id, u.given_names
FROM
  client c 
  JOIN app_user u ON c.client_id = u.user_id 
;
SELECT 
  c.client_athlete_id, u.given_names
FROM
  client_athlete c 
  JOIN app_user u ON c.client_athlete_id = u.user_id 
;
SELECT 
  c.client_injured_id, u.given_names
FROM
  client_injured c 
  JOIN app_user u ON c.client_injured_id = u.user_id 
;

-- get all roles for existing users
SELECT 
  u.user_id, u.given_names, string_agg(r.code_name, ', ') roles
FROM 
  user_role ur
  JOIN app_user u ON ur.user_id = u.user_id 
  JOIN role r on ur.role_id = r.role_id
GROUP BY 
  u.user_id, u.given_names
ORDER BY 
  u.given_names
;

-- get all clients and their injury records
SELECT 
  u.user_id, u.given_names, i.record_id, i.title, i.description
FROM 
  injury_history i 
  JOIN app_user u ON i.client_id = u.user_id
;