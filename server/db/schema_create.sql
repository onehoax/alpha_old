/*
  ================================================== Users ==================================================
*/

CREATE TABLE IF NOT EXISTS app_user (
  user_id           INT GENERATED ALWAYS AS IDENTITY,
  given_names       VARCHAR(30) NOT NULL,
  last_names        VARCHAR(30) NOT NULL,
  government_id     VARCHAR(15) NOT NULL,
  email             VARCHAR(50) NOT NULL,
  cell_phone_number VARCHAR(20) NOT NULL,
  dob               DATE        NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMPTZ	NOT NULL, 
    PRIMARY KEY(user_id),
    UNIQUE(government_id),
    UNIQUE(email)
)
;
COMMENT ON TABLE app_user IS 
'User of the application; a user can be ''Administrador'' (administrator), ''Entrenador'' (trainer), and/or ''Cliente'' (client).
''Entrenador'' and ''Cliente'' have their own relations; ''Administrador'' doesn''t.'
;


CREATE TABLE IF NOT EXISTS role (
  role_id           INT GENERATED ALWAYS AS IDENTITY,
  code_name         VARCHAR(30) NOT NULL,
  ui_name           VARCHAR(50) NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMPTZ	NOT NULL, 
    PRIMARY KEY(role_id),
    UNIQUE(code_name),
    UNIQUE(ui_name)
)
;
INSERT INTO role 
(code_name, ui_name, updated_at)
VALUES 
('admin', 'Administrador', now()),
('trainer', 'Entrenador', now()),
('sports_professional', 'Profesional del Deporte', now()),
('physio', 'Fisioterapeuta', now()),
('client', 'Cliente', now()),
('injured', 'Lesionado', now()),
('athlete', 'Deportista', now())
;
COMMENT ON TABLE role IS 
'Roles available in the application.
A user can be any of [admin, trainer, client];
A trainer can be any of [sports_professional, physio];
A client can be any of [injured, athlete].'
;

/*
  A user_role record only depends on an app_user and/or a role; if a given user and/or role is deleted, the corresponding user_role record is deleted automatically.
  However, since the user_role table contains info about all roles (client and trainer sub-types), whenever a client and/or trainer is deleted (or a sub-type of them),
  the corresponding records in user_role must be deleted manually; same goes for updates.
*/
CREATE TABLE IF NOT EXISTS user_role (
  user_id           INT NOT NULL,
  role_id           INT NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMPTZ	NOT NULL, 
    PRIMARY KEY(user_id, role_id),
    FOREIGN KEY(user_id)
      REFERENCES app_user(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(role_id)
      REFERENCES role(role_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE user_role IS 'Users assigned corresponding roles. A user can be any of [general, admin, trainer, client]';


/*
  ================================================== Trainers ==================================================
*/

CREATE TABLE IF NOT EXISTS trainer (
  trainer_id        INT NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(trainer_id),
    FOREIGN KEY(trainer_id)
      REFERENCES app_user(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE trainer IS 
'User of type ''Entrenador'' (trainer): there can only be 1 trainer per user (1:1).
A trainer can be further categorized as ''Profesional del Deporte'' (sports_profesional), and/or ''Fisioterapeuta'' (physio).
';


/*
  ================================================== Clients ==================================================
*/

CREATE TABLE IF NOT EXISTS client (
  client_id         INT NOT NULL,
  is_active         BOOLEAN NOT NULL,
  age               SMALLINT NOT NULL,
  jump_test         SMALLINT,
  blood_pressure    SMALLINT,
  triglycerides     SMALLINT,
  blood_glucose     SMALLINT,
  cholesterol       SMALLINT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(client_id),
    FOREIGN KEY(client_id)
      REFERENCES app_user(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE client IS 
'User of type ''Cliente'' (client): there can only be 1 client per user (1:1).
A client can be further categorized as ''Lesionado'' (injured), and/or ''Deportista'' (athlete).
''Lesionado'' and ''Deportista'' have their own relations.'
;


CREATE TABLE IF NOT EXISTS exercise_session (
  session_id           INT GENERATED ALWAYS AS IDENTITY,
  client_id            INT NOT NULL,
  trainer_name         VARCHAR(30) NOT NULL,
  created_at           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at           TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(session_id),
    FOREIGN KEY(client_id)
      REFERENCES client(client_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE exercise_session IS 
'Exercise sessions: each client can have multiple exercise sessions (1:N).
An exercise session depends on the client but not on the trainer.'
;


CREATE TABLE IF NOT EXISTS exercise (
  exercise_id          INT GENERATED ALWAYS AS IDENTITY,
  name                 VARCHAR(50) NOT NULL,
  description          TEXT,
  link                 VARCHAR(250),
  created_at           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at           TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(exercise_id),
    UNIQUE(name)
)
;
COMMENT ON TABLE exercise IS 'List of exercises available in the app.';


CREATE TABLE IF NOT EXISTS exercise_object (
  object_id            INT GENERATED ALWAYS AS IDENTITY,
  session_id           INT NOT NULL,
  exercise_id          INT NOT NULL,
  series_num           SMALLINT,
  weight               SMALLINT,
  reps                 SMALLINT,
  total_wheight        SMALLINT,
  created_at           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at           TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(object_id),
    FOREIGN KEY(session_id)
      REFERENCES exercise_session(session_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(exercise_id)
      REFERENCES exercise(exercise_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE exercise_object IS 
'Exercise object: represents exercise performed by client;
An exercise session can have multiple exercise objects (1:N).
Any given exercise can appear multiple times in this table (1:N).'
;


CREATE TABLE IF NOT EXISTS injury_history (
  record_id         INT GENERATED ALWAYS AS IDENTITY,
  client_id         INT NOT NULL,
  title             VARCHAR(50) NOT NULL,
  description       TEXT NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(record_id),
    FOREIGN KEY(client_id)
      REFERENCES client(client_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE injury_history IS 'History of injuries: each client can have multiple injuries (1:N).';


CREATE TABLE IF NOT EXISTS client_injured (
  client_injured_id INT NOT NULL,
  injury_type       VARCHAR(30),
  sport_type        VARCHAR(30),
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(client_injured_id),
    FOREIGN KEY(client_injured_id)
      REFERENCES client(client_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE client_injured IS 'Client of type ''Lesionado'' (injured): there can only be 1 injured client per general client (1:1).';


CREATE TABLE IF NOT EXISTS injury_session (
  session_id           INT GENERATED ALWAYS AS IDENTITY,
  client_injured_id    INT NOT NULL,
  trainer_name         VARCHAR(30) NOT NULL,
  activity_intolerance VARCHAR(100),
  functional_diagnosis VARCHAR(100),
  movement_goals       VARCHAR(100),
  believes             VARCHAR(100),
  clinical_diagnosis   TEXT,
  description          TEXT,
  created_at           TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at           TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(session_id),
    FOREIGN KEY(client_injured_id)
      REFERENCES client_injured(client_injured_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE injury_session IS 
'Injury sessions: each injured client can have multiple injury sessions (1:N). 
An injury session depends on the client but not on the trainer.'
;


CREATE TABLE IF NOT EXISTS client_athlete (
  client_athlete_id INT NOT NULL,
  sport             VARCHAR(30),
  objective         TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(client_athlete_id),
    FOREIGN KEY(client_athlete_id)
      REFERENCES client(client_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE client_athlete IS 'Client of type ''Cliente Deportista'' (athlete client): there can only be 1 athlete client per general client (1:1).';


CREATE TABLE IF NOT EXISTS clinical_examination (
  record_id         INT GENERATED ALWAYS AS IDENTITY,
  client_athlete_id INT NOT NULL,
  title             VARCHAR(50) NOT NULL,
  description       TEXT NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(record_id),
    FOREIGN KEY(client_athlete_id)
      REFERENCES client_athlete(client_athlete_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE clinical_examination IS 'Clinical examinations: each athlete client can have multiple clinical examinations (1:N).';


CREATE TABLE IF NOT EXISTS strength_test (
  record_id             INT GENERATED ALWAYS AS IDENTITY,
  client_athlete_id     INT NOT NULL,
  trainer_name          VARCHAR(30) NOT NULL,
  press_banca           FLOAT(2)[],
  dominadas             FLOAT(2)[],
  sentadilla            FLOAT(2)[],
  peso_muerto           FLOAT(2)[],
  cmj                   FLOAT(2)[],
  sj                    FLOAT(2)[],
  ie                    FLOAT(2)[],
  observaciones         TEXT,
  created_at            TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at            TIMESTAMPTZ NOT NULL,
    PRIMARY KEY(record_id),
    FOREIGN KEY(client_athlete_id)
      REFERENCES client_athlete(client_athlete_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
;
COMMENT ON TABLE strength_test IS 
'Strength tests: each athlete client can have multiple strength tests (1:N). 
A test depends on the client but not on the trainer.'
;
COMMENT ON COLUMN strength_test.press_banca IS 'in kg.';
COMMENT ON COLUMN strength_test.dominadas IS 'in kg.';
COMMENT ON COLUMN strength_test.sentadilla IS 'in kg.';
COMMENT ON COLUMN strength_test.peso_muerto IS 'in kg.';
COMMENT ON COLUMN strength_test.cmj IS 'Counter Movement Jump in cm.';
COMMENT ON COLUMN strength_test.sj IS 'Squat Jump in cm.';
COMMENT ON COLUMN strength_test.ie IS 'Elastic Index in %.';