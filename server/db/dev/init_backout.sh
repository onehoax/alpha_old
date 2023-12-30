#!/bin/bash

sudo -u postgres psql -a -c "drop user if exists alpha;"
sudo -u postgres psql -a -c "drop database if exists alpha;"
