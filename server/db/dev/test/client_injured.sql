/*
  ================================================== Injured Clients ==================================================
*/

INSERT INTO injury_session 
(client_injured_id, trainer_name, activity_intolerance, updated_at)
VALUES
((SELECT user_id FROM app_user WHERE given_names = 'Manuela'), 'some trainer', 'go up stairs', now()),
((SELECT user_id FROM app_user WHERE given_names = 'Nicolas'), 'some trainer', 'pivot in soccer', now()),
((SELECT user_id FROM app_user WHERE given_names = 'Nicolas'), 'some trainer', 'take free kicks', now())
;

SELECT 
  u.user_id, u.given_names, i.injury_type, i.sport_type, r.session_id, r.trainer_name, r.activity_intolerance
FROM 
  app_user u 
  JOIN client_injured i ON u.user_id = i.client_injured_id
  JOIN injury_session r ON i.client_injured_id = r.client_injured_id
;