#!/bin/bash -eux

PUSHGATEWAY_URL=http://192.168.1.170:9091
PUSHGATEWAY_ENDPOINT=metrics/job/testjob/instance/testinstance
USER=${PUSHGATEWAY_HTTP_USER:-"admin"}
PASSWORD=$PUSHGATEWAY_HTTP_PASSWORD

echo "
# TYPE some_metric gauge
some_metric 42
# TYPE awesomeness_total counter
# HELP awesomeness_total How awesome is this article.
awesomeness_total 99999999
" | curl -u $USER:$PASSWORD --data-binary @- "${PUSHGATEWAY_URL}/${PUSHGATEWAY_ENDPOINT}"
