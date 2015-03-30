#!/bin/bash
cd /var/lib/cloudforecast

service gearman-job-server start

./cloudforecast_radar -c config/cloudforecast.yaml -l config/server_list.yaml &
./cf_fetcher_worker -r -c config/cloudforecast.yaml -max-workers 4 -max-request-per-child 1000 -max-exection-time 60 &
./cf_updater_worker -r -c config/cloudforecast.yaml -max-workers 4 -max-request-per-child 1000 -max-exection-time 60 &

[ ! -z "$FRONT_PROXY" ] && FRONT_PROXY="--front-proxy=${FRONT_PROXY}"
./cloudforecast_web -p 5000 ${FRONT_PROXY} -c config/cloudforecast.yaml -l config/server_list.yaml &

trap '
service gearman-job-server stop;
exit 0' TERM

tail -f /dev/null
