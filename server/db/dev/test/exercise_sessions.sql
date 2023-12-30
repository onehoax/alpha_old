/*
  ================================================== Exercise Sessions ==================================================
*/

INSERT INTO exercise
(name, updated_at)
VALUES
('bench press', now()),
('pull down', now()),
('squats', now())
;

with 
  s AS (
    INSERT INTO exercise_session
    (client_id, trainer_name, updated_at)
    VALUES
    ((SELECT user_id FROM app_user WHERE given_names = 'Manuela'), 'some trainer', now())
    RETURNING session_id
  )
INSERT INTO exercise_object
(session_id, exercise_id, updated_at)
VALUES
((SELECT session_id FROM s), (SELECT exercise_id FROM exercise WHERE name = 'pull down'), now()),
((SELECT session_id FROM s), (SELECT exercise_id FROM exercise WHERE name = 'bench press'), now()),
((SELECT session_id FROM s), (SELECT exercise_id FROM exercise WHERE name = 'squats'), now()),
((SELECT session_id FROM s), (SELECT exercise_id FROM exercise WHERE name = 'squats'), now())
;

SELECT 
  u.user_id, u.given_names, s.session_id, o.object_id, e.exercise_id, e.name 
FROM 
  app_user u 
  JOIN exercise_session s ON u.user_id = s.client_id
  JOIN exercise_object o ON s.session_id = o.session_id
  JOIN exercise e ON o.exercise_id = e.exercise_id
;