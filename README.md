### LSST-DRP-kafka

## Overview

This repository contains configuration files and operational settings used to deploy and manage the [LSST Messaging Stack](https://stfc.atlassian.net/wiki/spaces/RO/pages/617054222/Messaging+Stack) for the [LSST Data Reprocessing Pipeline (DRP)](https://stfc.atlassian.net/wiki/spaces/RO/pages/207487345/Data+Reprocessing+Pipeline+DRP), part of the wider [Legacy Survey of Space and Time](https://stfc.atlassian.net/wiki/spaces/RO/pages/1101987874/LSST+Summary) project. These include:

- Apache Kafka 
- Strimzi Cluster Operator
- Kafka MirrorMaker2
- Strimzi Bridge
- ingestD
- Prometheus

This repository includes the helm charts and kubernetes manifests to deploy a new messaging stack for the LSST DRP at RAL. Kubernets was chosen as a highly available and fault tolerant successor to the original [Docker implementation](https://github.com/stfc/lsst-drp-kafka).

## Deployment & Pre-requisites

To deploy into a new kubernetes cluster, you will need to:

- Add the Butler postgres DB credential db-auth.yaml into the cluster as a kubernetes secret ahead of deployment. This must contain a valid DB account and password.
- Add x509 credential on the host as a kubernetes secret ahead of deployment. This must be a long lived VOMS x509 certificate.
- Update Grafana Vande with the new ingress address for the host cluster to enable monitoring following deployment.

## Components

# - Apache Kafka

    Apache Kafka is an open‑source distributed event‑streaming platform from the Apache Software Foundation. It provides durable, fault‑tolerant storage and high‑throughput messaging via topics, partitions, and a distributed cluster of brokers, enabling real‑time data pipelines and streaming applications.

    The Kafka ecosystem includes core APIs for producers, consumers, stream processing, and connectors. These components allow Kafka to integrate with external systems, support real‑time stream processing, and run reliably across a scalable, distributed architecture.

# - Strimzi

    Strimzi is an open‑source Kubernetes operator that automates the deployment and lifecycle management of Apache Kafka clusters on Kubernetes. It provides Kubernetes‑native Kafka management using custom resources for clusters, topics, and users, allowing Kafka to be run and operated through standard Kubernetes workflows.

    The Strimzi Cluster Operator is a component of the Strimzi open‑source project. It is an operator that deploys and manages Apache Kafka clusters by watching Kafka-related custom resources and reconciling their desired state. It provides the operators, container images, and CRDs needed to run Kafka natively on Kubernetes.

# - Kafka MirrorMaker2 (MM2)

    Kafka MirrorMaker2 is Kafka’s built‑in tool for replicating topics, configurations, and consumer offsets between Kafka clusters, enabling cross‑cluster data migration and multi‑datacenter architectures. It is built on the Kafka Connect framework of specialised connectors that mirror data, synchronize offsets, and track replication health. In this use case, MM2 replicates the upstream USDF Kafka topics designated for reprocessing at RAL.

# - Strimzi Bridge

    The Strimzi Kafka HTTP Bridge is a component of the Strimzi project that provides a RESTful HTTP interface for producing and consuming messages in Apache Kafka, allowing applications that cannot speak the native Kafka protocol to interact with Kafka over standard HTTP.

    This enables simplified interativity with the Kafka cluster, allowing the user to produce and consume messages to topics using curl or other http interfaces for testing and troubleshooting.

# - IngestD

    Ingestd is the Python ingestion daemon designed to consume messages from the LSST Kafka topics and write the metadata embedded in each message into the corresponding repository in the Butler postgres DB. It is deployed as a Kubernetes service and run as multiple replicas in a shared consumer group, allowing parallel ingestion of distinct datasets.

# - Prometheus

    Prometheus is an open‑source monitoring and alerting toolkit that collects and stores metrics as time‑series data by scraping HTTP endpoints.It is widely adopted for monitoring cloud‑native systems such as Kubernetes due to its reliability and strong ecosystem of exporters and integrations. 

    Prometheus uses dedicated pod monitors to scrape time series metrics from kubernetes applications over HTTP, which can be exposed externally using a kubernetes ingress. Tools such as Grafana can subscribe to these metrics and visualise them for application observability and moitoring.

## Contributors

- Timothy Noble
- Mathew Simms
- Chris Winterburn