# We will cover the below items in this sheet.

1. Show networks 'docker network ls'
2. Inspect a network 'docker network inspect'
3. Create a network 'docker network create --driver'
4. Attatch a network to container 'docker network connect'
5. Detach a network from container 'docker network disconnect'

ubuntu@ip-172-31-7-255:~$ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
56eff2d1ef83   bridge    bridge    local
93762da4aeea   host      host      local
84bd74bcc6af   none      null      local

# bridge network is a Default docker virtual network which is NAT'ed behind the Host IP.
# host network gains performance by skipping virtual networks but sacrifices security of container model.
# none - removes eth0 and only leaves you with localhost interface in container.

# We will create a new network and inspect the same. Later we will use the new network on the container. We will also attatch and detach the interfaces.
# Created new network below.
ubuntu@ip-172-31-7-255:~$ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
cfdd3f444b0e   bridge    bridge    local
93762da4aeea   host      host      local
84bd74bcc6af   none      null      local
ubuntu@ip-172-31-7-255:~$ docker network create my_app_nw1
ad0597e82cb75b8cd3cf6681c1518acac8d4dc610a11bc8bd27bfe0283b05650
ubuntu@ip-172-31-7-255:~$ docker network ls
NETWORK ID     NAME         DRIVER    SCOPE
cfdd3f444b0e   bridge       bridge    local
93762da4aeea   host         host      local
ad0597e82cb7   my_app_nw1   bridge    local
84bd74bcc6af   none         null      local
ubuntu@ip-172-31-7-255:~$ docker network inspect my_app_nw1
[
    {
        "Name": "my_app_nw1",
        "Id": "ad0597e82cb75b8cd3cf6681c1518acac8d4dc610a11bc8bd27bfe0283b05650",
        "Created": "2021-07-13T04:33:38.040754147Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]

ubuntu@ip-172-31-7-255:~$ docker network create --help

Usage:  docker network create [OPTIONS] NETWORK

Create a network

Options:
      --attachable           Enable manual container attachment
      --aux-address map      Auxiliary IPv4 or IPv6 addresses used by Network driver (default map[])
      --config-from string   The network from which to copy the configuration
      --config-only          Create a configuration only network
  -d, --driver string        Driver to manage the Network (default "bridge")
      --gateway strings      IPv4 or IPv6 Gateway for the master subnet
      --ingress              Create swarm routing-mesh network
      --internal             Restrict external access to the network
      --ip-range strings     Allocate container ip from a sub-range
      --ipam-driver string   IP Address Management Driver (default "default")
      --ipam-opt map         Set IPAM driver specific options (default map[])
      --ipv6                 Enable IPv6 networking
      --label list           Set metadata on a network
  -o, --opt map              Set driver specific options (default map[])
      --scope string         Control the network's scope
      --subnet strings       Subnet in CIDR format that represents a network segment
# Creating a container with new network.

ubuntu@ip-172-31-7-255:~$ docker container run -d --name nginx3 --network my_app_nw1 nginx:alpine
21441f2eff63648f7f4058d5a557ea0ad40fdc89124056df86190fd203c35f0a

ubuntu@ip-172-31-7-255:~$ docker network inspect my_app_nw1
[
    {
        "Name": "my_app_nw1",
        "Id": "ad0597e82cb75b8cd3cf6681c1518acac8d4dc610a11bc8bd27bfe0283b05650",
        "Created": "2021-07-13T04:33:38.040754147Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "21441f2eff63648f7f4058d5a557ea0ad40fdc89124056df86190fd203c35f0a": {
                "Name": "nginx3",
                "EndpointID": "f396fb163f7d5e1803e6b3f7cd89e301b87f00d2f54ced6fbab5be271e8ddf42",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]

# Connecting nginx3 container to a different network.

ubuntu@ip-172-31-7-255:~$ docker network ls
NETWORK ID     NAME         DRIVER    SCOPE
cfdd3f444b0e   bridge       bridge    local
93762da4aeea   host         host      local
ad0597e82cb7   my_app_nw1   bridge    local
84bd74bcc6af   none         null      local
ubuntu@ip-172-31-7-255:~$ docker network connect ^C
ubuntu@ip-172-31-7-255:~$ docker container ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS     NAMES
21441f2eff63   nginx:alpine   "/docker-entrypoint.…"   7 minutes ago   Up 7 minutes   80/tcp    nginx3
ubuntu@ip-172-31-7-255:~$ docker network connect
bridge      host        my_app_nw1  none
ubuntu@ip-172-31-7-255:~$ docker network connect
bridge      host        my_app_nw1  none
ubuntu@ip-172-31-7-255:~$ docker network connect ad0597e82cb7 21441f2eff63
Error response from daemon: endpoint with name nginx3 already exists in network my_app_nw1
ubuntu@ip-172-31-7-255:~$ docker network connect cfdd3f444b0e 21441f2eff63
ubuntu@ip-172-31-7-255:~$ docker container inspect nginx3
...truncated output...
"Networks": {
    "bridge": {
        "IPAMConfig": {},
        "Links": null,
        "Aliases": [],
        "NetworkID": "cfdd3f444b0e3f7057eba35dbc4f7b68267895204ceea2a7b658efbc7b44555a",
        "EndpointID": "0da418b164e83079f9f2aff103d1d2f6acae423e2a321b0c0054cbc592e63f9b",
        "Gateway": "172.17.0.1",
        "IPAddress": "172.17.0.2",
        "IPPrefixLen": 16,
        "IPv6Gateway": "",
        "GlobalIPv6Address": "",
        "GlobalIPv6PrefixLen": 0,
        "MacAddress": "02:42:ac:11:00:02",
        "DriverOpts": {}
    },
    "my_app_nw1": {
        "IPAMConfig": null,
        "Links": null,
        "Aliases": [
            "21441f2eff63"
        ],
        "NetworkID": "ad0597e82cb75b8cd3cf6681c1518acac8d4dc610a11bc8bd27bfe0283b05650",
        "EndpointID": "f396fb163f7d5e1803e6b3f7cd89e301b87f00d2f54ced6fbab5be271e8ddf42",
        "Gateway": "172.18.0.1",
        "IPAddress": "172.18.0.2",
        "IPPrefixLen": 16,
        "IPv6Gateway": "",
        "GlobalIPv6Address": "",
        "GlobalIPv6PrefixLen": 0,
        "MacAddress": "02:42:ac:12:00:02",
        "DriverOpts": null
    }
}

# You can disconnect the containers from networks in same way.
ubuntu@ip-172-31-7-255:~$ docker network disconnect cfdd3f444b0e 21441f2eff63
ubuntu@ip-172-31-7-255:~$ docker container inspect nginx3
...truncated outputs...
"Networks": {
    "my_app_nw1": {
        "IPAMConfig": null,
        "Links": null,
        "Aliases": [
            "21441f2eff63"
        ],
        "NetworkID": "ad0597e82cb75b8cd3cf6681c1518acac8d4dc610a11bc8bd27bfe0283b05650",
        "EndpointID": "f396fb163f7d5e1803e6b3f7cd89e301b87f00d2f54ced6fbab5be271e8ddf42",
        "Gateway": "172.18.0.1",
        "IPAddress": "172.18.0.2",
        "IPPrefixLen": 16,
        "IPv6Gateway": "",
        "GlobalIPv6Address": "",
        "GlobalIPv6PrefixLen": 0,
        "MacAddress": "02:42:ac:12:00:02",
        "DriverOpts": null
    }
}
