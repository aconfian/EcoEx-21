OVHcloud Link Aggregation - EcoExp-21
=====================================

### default.sh
Deploys the default configuration for 4 interfaces servers.
Default configuration is a public LACP with 2 interfaces and a private LACP with also 2 interfaces

### ola.sh
Deploys the OLA configuration. LACP with all 4 interfaces

### lacp.sh
Generic tool to configure LACP

### logs.sh
Tails the kern.log and cut the logger prefix

### iperf-server.sh
Start 16 iperf3 in server mode, then print the current bandwidth usage

### iperf-client.sh
Start 16 iperf3 clients and print the current bandwidth usage


alexandre.confiant-latour@ovhcloud.com
