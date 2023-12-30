#!/bin/bash

sudo -u postgres createuser -e -d alpha
sudo -u postgres createdb -e alpha
. ../../.env
sudo -u postgres psql -a -c "alter user alpha with password '$DB_PWD';"