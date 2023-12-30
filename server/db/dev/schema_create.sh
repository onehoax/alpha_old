#!/bin/bash

psql -h localhost -p 5432 -U alpha -d alpha -a -f ../schema_create.sql > ../logs/dev/create_out.txt