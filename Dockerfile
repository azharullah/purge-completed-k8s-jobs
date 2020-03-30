FROM alpine

ARG BINARYNAME

ADD bin/purge-completed-k8s-jobs /purge-completed-k8s-jobs
