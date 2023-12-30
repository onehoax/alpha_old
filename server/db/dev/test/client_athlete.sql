/*
  ================================================== Athelete Clients ==================================================
*/

INSERT INTO clinical_examination 
(client_athlete_id, title, description, updated_at)
VALUES
((SELECT user_id FROM app_user WHERE given_names = 'Manuela'), 'examination 1', 'primera examinacion', now()),
((SELECT user_id FROM app_user WHERE given_names = 'Manuela'), 'examination 2', 'segunda examinacion', now())
;

SELECT 
  u.user_id, u.given_names, a.sport, a.objective, r.record_id, r.title, r.description
FROM 
  app_user u 
  JOIN client_athlete a ON u.user_id = a.client_athlete_id
  JOIN clinical_examination r ON a.client_athlete_id = r.client_athlete_id
;

INSERT INTO strength_test 
(client_athlete_id, trainer_name, cmj, updated_at)
VALUES 
((SELECT user_id FROM app_user WHERE given_names = 'Manuela'), 'some trainer', '{2.0, 3.5, 6.2}', now()),
((SELECT user_id FROM app_user WHERE given_names = 'Manuela'), 'some trainer', '{5.3, 1.3, 2.4}', now())
;

SELECT 
  u.user_id, u.given_names, a.sport, a.objective, r.record_id, r.trainer_name, r.cmj, (SELECT SUM(vals) FROM UNNEST(r.cmj) vals) as total_cmj
FROM 
  app_user u 
  JOIN client_athlete a ON u.user_id = a.client_athlete_id
  JOIN strength_test r ON a.client_athlete_id = r.client_athlete_id
;