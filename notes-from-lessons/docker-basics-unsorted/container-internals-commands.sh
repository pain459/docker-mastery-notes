# We will create new containers and nagigate across the containers.

# Starting 2 containers.
ubuntu@ip-172-31-7-255:~$ docker container run --publish 80:80 --detach --name nginx nginx:latest
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
b4d181a07f80: Pull complete
66b1c490df3f: Pull complete
d0f91ae9b44c: Pull complete
baf987068537: Pull complete
6bbc76cbebeb: Pull complete
32b766478bc2: Pull complete
Digest: sha256:353c20f74d9b6aee359f30e8e4f69c3d7eaea2f610681c4a95849a2fd7c497f9
Status: Downloaded newer image for nginx:latest
b06142e3f3a153d9a13b0386c30c72cdf18e9b0dfaa455fc543b4d5c941dc409
ubuntu@ip-172-31-7-255:~$ docker container run --publish 3306:3306 --env MYSQL_RANDOM_ROOT_PASSWORD=yes --detach --name mysql mysql:latest
Unable to find image 'mysql:latest' locally
latest: Pulling from library/mysql
b4d181a07f80: Already exists
a462b60610f5: Pull complete
578fafb77ab8: Pull complete
524046006037: Pull complete
d0cbe54c8855: Pull complete
aa18e05cc46d: Pull complete
32ca814c833f: Pull complete
9ecc8abdb7f5: Pull complete
ad042b682e0f: Pull complete
71d327c6bb78: Pull complete
165d1d10a3fa: Pull complete
2f40c47d0626: Pull complete
Digest: sha256:52b8406e4c32b8cf0557f1b74517e14c5393aff5cf0384eff62d9e81f4985d4b
Status: Downloaded newer image for mysql:latest
d8448f0bc19751d8cd0d19950a45a230e5fd39c887fabac9ac1d4b078c844bd0

# Now we will see top, inspect, stats for the running containers.

# Listing running containers.
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS              PORTS                                                  NAMES
d8448f0bc197   mysql:latest   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
b06142e3f3a1   nginx:latest   "/docker-entrypoint.…"   2 minutes ago        Up 2 minutes        0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx

# Running top on the running containers.
ubuntu@ip-172-31-7-255:~$ docker container top d8448f0bc197
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
systemd+            3903                3881                0                   07:08               ?                   00:00:01            mysqld
ubuntu@ip-172-31-7-255:~$ docker container top d8448f0bc197
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
systemd+            3903                3881                0                   07:08               ?                   00:00:01            mysqld

# Docker inspect will give a huge json output. it is nos useful for normal debugging unless you query for exact data.
ubuntu@ip-172-31-7-255:~$ docker container inspect d8448f0bc197
[
    {
        "Id": "d8448f0bc19751d8cd0d19950a45a230e5fd39c887fabac9ac1d4b078c844bd0",
        "Created": "2021-07-12T07:08:42.721221449Z",
        "Path": "docker-entrypoint.sh",
        "Args": [
            "mysqld"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 3903,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2021-07-12T07:08:47.087983254Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:5c62e459e087e3bd3d963092b58e50ae2af881076b43c29e38e2b5db253e0287",
        "ResolvConfPath": "/var/lib/docker/containers/d8448f0bc19751d8cd0d19950a45a230e5fd39c887fabac9ac1d4b078c844bd0/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/d8448f0bc19751d8cd0d19950a45a230e5fd39c887fabac9ac1d4b078c844bd0/hostname",
        "HostsPath": "/var/lib/docker/containers/d8448f0bc19751d8cd0d19950a45a230e5fd39c887fabac9ac1d4b078c844bd0/hosts",
        "LogPath": "/var/lib/docker/containers/d8448f0bc19751d8cd0d19950a45a230e5fd39c887fabac9ac1d4b078c844bd0/d8448f0bc19751d8cd0d19950a45a230e5fd39c887fabac9ac1d4b078c844bd0-json.log",
        "Name": "/mysql",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "docker-default",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {
                "3306/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "3306"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "CapAdd": null,
            "CapDrop": null,
            "CgroupnsMode": "host",
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "private",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "ConsoleSize": [
                0,
                0
            ],
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": null,
            "BlkioDeviceWriteBps": null,
            "BlkioDeviceReadIOps": null,
            "BlkioDeviceWriteIOps": null,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DeviceRequests": null,
            "KernelMemory": 0,
            "KernelMemoryTCP": 0,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": false,
            "PidsLimit": null,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/10eac6480ae3585142ba99fe2e9e114959b036fdf8a7993e38d319011cad4482-init/diff:/var/lib/docker/overlay2/c3e3c1b7df84297c504a792af955d969f4f1c78a9e4ab87eb86cdf8be7ec1b03/diff:/var/lib/docker/overlay2/012b61e37e457f0b28a1b102eea63d75b24bf65f248bc7871a58fbe72229add3/diff:/var/lib/docker/overlay2/090766ab54ef306a2ce81d5190f8a37df210b2b60da0d44fc437a9e13ba4d317/diff:/var/lib/docker/overlay2/9e0b414e535af001445ff91820b167133b256de09dd49bbef849f18f03ac5ef4/diff:/var/lib/docker/overlay2/e5d228d786128d154e5a27bbfdc489c7ecde3c41406aa1153457c1325b627706/diff:/var/lib/docker/overlay2/8a70edc3e290c49aee2e63822dce10f555b6557318e63a9bd7a8e262ba7b34ec/diff:/var/lib/docker/overlay2/67f25b605ec02b2beb027be988a4b5b7d01aa471ceebd4d275f1459090f406b0/diff:/var/lib/docker/overlay2/5d6f805a0732f66ca12ecbf746e77a0674338ab925a489c4afec1e6f2539304d/diff:/var/lib/docker/overlay2/83a1a15bebfe43d8c9a23a4d2b55e3939d67d7ccaecedd16a284c2e3f8afdc9b/diff:/var/lib/docker/overlay2/26d12572795584ce75949387f626f5777d077fca365b11e613cfa222d6ce9a58/diff:/var/lib/docker/overlay2/7c7c3684d8616ef3980d46b0abc1b712a12d776eb9067dfcb75b15b8b3ff5c56/diff:/var/lib/docker/overlay2/3d1dfd53b808a09db1781ad7671cc7d93a9c3ec7c1e399bd490a245d840c5bff/diff",
                "MergedDir": "/var/lib/docker/overlay2/10eac6480ae3585142ba99fe2e9e114959b036fdf8a7993e38d319011cad4482/merged",
                "UpperDir": "/var/lib/docker/overlay2/10eac6480ae3585142ba99fe2e9e114959b036fdf8a7993e38d319011cad4482/diff",
                "WorkDir": "/var/lib/docker/overlay2/10eac6480ae3585142ba99fe2e9e114959b036fdf8a7993e38d319011cad4482/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [
            {
                "Type": "volume",
                "Name": "8f179ec38f2192dd8d2702acf6e18d71169e6826cca57769ddcae6628fbe4b4e",
                "Source": "/var/lib/docker/volumes/8f179ec38f2192dd8d2702acf6e18d71169e6826cca57769ddcae6628fbe4b4e/_data",
                "Destination": "/var/lib/mysql",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            }
        ],
        "Config": {
            "Hostname": "d8448f0bc197",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "3306/tcp": {},
                "33060/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "MYSQL_RANDOM_ROOT_PASSWORD=yes",
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "GOSU_VERSION=1.12",
                "MYSQL_MAJOR=8.0",
                "MYSQL_VERSION=8.0.25-1debian10"
            ],
            "Cmd": [
                "mysqld"
            ],
            "Image": "mysql:latest",
            "Volumes": {
                "/var/lib/mysql": {}
            },
            "WorkingDir": "",
            "Entrypoint": [
                "docker-entrypoint.sh"
            ],
            "OnBuild": null,
            "Labels": {}
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "47d5943f3a0977dd79889ec6b849b0692640b95bfbf85640a6b27bafdab2fe11",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
                "3306/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "3306"
                    },
                    {
                        "HostIp": "::",
                        "HostPort": "3306"
                    }
                ],
                "33060/tcp": null
            },
            "SandboxKey": "/var/run/docker/netns/47d5943f3a09",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "ce5af44b21a62741ee82ccdec88dd4fb1feb67a20e49e327bd25ae6771024209",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.3",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:03",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "a29d2dea9ee0981139d81b649cdf4a46d7fa8d336f2331d0883d87224c45cfa7",
                    "EndpointID": "ce5af44b21a62741ee82ccdec88dd4fb1feb67a20e49e327bd25ae6771024209",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.3",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:03",
                    "DriverOpts": null
                }
            }
        }
    }
]

# running docker stats to see the consumption.
ubuntu@ip-172-31-7-255:~$ docker container stats
CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O         BLOCK I/O       PIDS
d8448f0bc197   mysql     0.15%     346.2MiB / 3.841GiB   8.80%     1.46kB / 795B   115kB / 249MB   38
b06142e3f3a1   nginx     0.00%     3.656MiB / 3.841GiB   0.09%     1.34kB / 432B   0B / 8.19kB     3
^C
# Hit Ctrl + c to exit the stats output.
