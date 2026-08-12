#!/bin/bash

echo "Terminating IngestD pods"

kubectl get pods -n lsst-drp-kafka \
    | awk '/ingestd/ {print $1}' \
    | while read -r pod
do
    echo "Terminating $pod"

    kubectl delete pod -n lsst-drp-kafka "$pod"

done

echo "Completed terminating IngestD pods"