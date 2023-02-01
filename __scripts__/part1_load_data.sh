#!/bin/env bash

DATADIR=$(dirname $0)/../__data__
mkdir -p ${DATADIR}

# Download and unzip trip data
curl https://bicycletransit.wpenginepowered.com/wp-content/uploads/2022/12/indego-trips-2022-q3.zip > ${DATADIR}/indego-trips-2022-q3.zip
unzip ${DATADIR}/indego-trips-2022-q3.zip -d ${DATADIR}

curl https://bicycletransit.wpenginepowered.com/wp-content/uploads/2021/10/indego-trips-2021-q3.zip > ${DATADIR}/indego-trips-2021-q3.zip
unzip ${DATADIR}/indego-trips-2021-q3.zip -d ${DATADIR}

# Create database and initialize table structure
PG_PASSWORD=postgres createdb \
  -h localhost \
  -p 5432 \
  -U postgres \
  -d musa_509 \
  musa_509
PG_PASSWORD=postgres psql \
  -h localhost \
  -p 5432 \
  -U postgres \
  -d musa_509 \
  -f "${DATADIR}/part1_create_trip_tables.sql"

# Load trip data into database
PG_PASSWORD=postgres psql \
  -h localhost \
  -p 5432 \
  -U postgres \
  -d musa_509 \
  -c "\copy indego.trips_2021_q3 FROM '${DATADIR}/indego-trips-2021-q3.csv' DELIMITER ',' CSV HEADER;"
PG_PASSWORD=postgres psql \
  -h localhost \
  -p 5432 \
  -U postgres \
  -d musa_509 \
  -c "\copy indego.trips_2022_q3 FROM '${DATADIR}/indego-trips-2022-q3.csv' DELIMITER ',' CSV HEADER;"

# Download and load station data into database
curl http://www.rideindego.com/stations/json/ > ${DATADIR}/indego-station-statuses.json
ogr2ogr \
  -f "PostgreSQL" \
  -nln "indego.station_statuses" \
  -lco "OVERWRITE=yes" \
  -lco "GEOM_TYPE=geography" \
  -lco "GEOMETRY_NAME=geog" \
  PG:"host=localhost port=5432 dbname=musa_509 user=postgres password=postgres" \
  ${DATADIR}/indego-station-statuses.json
