#!/bin/bash

psql -h localhost -p 5432 -U alpha -d alpha -a -f ./exercise_sessions.sql > ../../logs/dev/test_out.txt