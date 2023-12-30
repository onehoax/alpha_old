#!/bin/bash

psql -h localhost -p 5432 -U alpha -d alpha -a -f ./client_injured.sql > ../../logs/dev/test_out.txt