# Purge-k8s-jobs-cli

Purge-k8s-jobs-cli is a [cobra](https://github.com/spf13/cobra) based CLI 
wrapper over the [purgek8sjobs](https://raw.githubusercontent.com/azharullah/purgek8sjobs) 
package.

### Why purge-k8s-jobs-cli?

This utility provides a command line tool based interface to the 
[purgek8sjobs](https://raw.githubusercontent.com/azharullah/purgek8sjobs), which 
would be the most appropriate way to consume the package.

The reasons to why anyone might want use this tool are 
[mentioned here](https://github.com/azharullah/purgek8sjobs/blob/master/README.md#why-purgek8sjobs) 

### Usage

The docker image with the tool's binary is 
[available here](https://hub.docker.com/r/azharullah/purge-k8s-jobs)

#### Kubernetes deployment via helm
A helm chart is available to enable easy deployment to k8s clusters.
```bash
cd purge-k8s-jobs-cli/helm
helm upgrade --install purge-k8s-jobs .
```

#### As a standalone CLI tool

The binary is available as a release artifact 
[here](https://github.com/azharullah/purge-k8s-jobs-cli/releases/download/v0.1.0/purge-completed-k8s-jobs-v0.1.0)

To build a binary from source:
```bash
make build  # For OSX
make build-linux  # For Linux
make build-linux BINARYNAME=xyz  # For custom binary names
```

#### CLI usage
For command help text:
```bash
./bin/purge-k8s-jobs-cli-v0.1.0 -h
This utility helps purge all kubernetes jobs that have completed their execution more than `b` hours ago in the namespace `n`. Optionally, this also write the job spec and events to a provided log file path

Usage:
  purge-completed-k8s-jobs --namespace xyz --before-hours 5 --events-log-file=./events.txt --spec-log-file=./spec.txt

Flags:
  -b, --before-hours int16       Query and delete jobs that were complete before x hours (default 1)
  -e, --events-log-file string   Log file to write the job events to
  -h, --help                     help for purge-completed-k8s-jobs
  -n, --namespace string         Namespace in which the operations are to be performed (default "default")
  -s, --spec-log-file string     Log file to write the job spec to
```

To use kubeconfig file for authentication:
```bash
export KUBECONFIG=~/.kube/config
purge-completed-k8s-jobs-v0.1.0 --namespace xyz --before-hours 0 \
    --events-log-file=./events.txt --spec-log-file=./spec.txt
```

To set custom log levels: (The default log level is debug )
```bash
export LOG_LEVEL=warn
purge-completed-k8s-jobs-v0.1.0 --namespace xyz --before-hours 0 \
    --events-log-file=./events.txt --spec-log-file=./spec.txt
```