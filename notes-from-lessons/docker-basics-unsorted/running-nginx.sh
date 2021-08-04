# You can start the container simply by publishing to any local port.
$ docker cotainer run --publish 80:80 nginx
# Sample output below.
ubuntu@ip-172-31-7-255:~$ docker container run --publish 80:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
b4d181a07f80: Pull complete
edb81c9bc1f5: Pull complete
b21fed559b9f: Pull complete
03e6a2452751: Pull complete
b82f7f888feb: Pull complete
5430e98eba64: Pull complete
Digest: sha256:47ae43cdfc7064d28800bc42e79a429540c7c80168e8c8952778c0d5af1c09db
Status: Downloaded newer image for nginx:latest
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2021/07/05 03:18:12 [notice] 1#1: using the "epoll" event method
2021/07/05 03:18:12 [notice] 1#1: nginx/1.21.0
2021/07/05 03:18:12 [notice] 1#1: built by gcc 8.3.0 (Debian 8.3.0-6)
2021/07/05 03:18:12 [notice] 1#1: OS: Linux 5.4.0-1045-aws
2021/07/05 03:18:12 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2021/07/05 03:18:12 [notice] 1#1: start worker processes
2021/07/05 03:18:12 [notice] 1#1: start worker process 35
2021/07/05 03:18:12 [notice] 1#1: start worker process 36
49.37.157.59 - - [05/Jul/2021:03:21:29 +0000] "GET / HTTP/1.1" 200 612 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "-"
2021/07/05 03:21:30 [error] 35#35: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 49.37.157.59, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "ec2-15-207-88-235.ap-south-1.compute.amazonaws.com", referrer: "http://ec2-15-207-88-235.ap-south-1.compute.amazonaws.com/"
49.37.157.59 - - [05/Jul/2021:03:21:30 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://ec2-15-207-88-235.ap-south-1.compute.amazonaws.com/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "-"
49.37.157.59 - - [05/Jul/2021:03:21:30 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "-"
49.37.157.59 - - [05/Jul/2021:03:21:44 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "-"
# Giving Ctrl + c at CLI to stop the container.
^C2021/07/05 03:22:04 [notice] 1#1: signal 2 (SIGINT) received, exiting
2021/07/05 03:22:04 [notice] 35#35: exiting
2021/07/05 03:22:04 [notice] 36#36: exiting
2021/07/05 03:22:04 [notice] 35#35: exit
2021/07/05 03:22:04 [notice] 36#36: exit
2021/07/05 03:22:04 [notice] 1#1: signal 17 (SIGCHLD) received from 36
2021/07/05 03:22:04 [notice] 1#1: worker process 36 exited with code 0
2021/07/05 03:22:04 [notice] 1#1: worker process 35 exited with code 0
2021/07/05 03:22:04 [notice] 1#1: exit

## This command will run the command in the forground.

# Now we will run the container in the background.
$ docker container run --publish 80:80 --detach nginx
# Sample output below.
ubuntu@ip-172-31-7-255:~$ docker container run --publish 80:80 --detach nginx
a24cf2680c11f94e36342e1d21ebbf0f5e16460b2517257fd4c9db0e2357b022

# Listing the containers.
ubuntu@ip-172-31-7-255:~$ docker container ls
CONTAINER ID   IMAGE     COMMAND                  CREATED              STATUS              PORTS                               NAMES
a24cf2680c11   nginx     "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp, :::80->80/tcp   musing_austin

# You can stop the container by giving some unique numbers from the start.
ubuntu@ip-172-31-7-255:~$ docker container stop a24
a24
# Once stopped, you won't see the container as running using container ls
ubuntu@ip-172-31-7-255:~$ docker container ls
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

# Listing all the stopped containers.
ubuntu@ip-172-31-7-255:~$ docker container ls -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS                          PORTS     NAMES
a24cf2680c11   nginx     "/docker-entrypoint.…"   3 minutes ago    Exited (0) About a minute ago             musing_austin
b79ca2342bf0   nginx     "/docker-entrypoint.…"   12 minutes ago   Exited (0) 8 minutes ago                  goofy_williams

# Running the container with the specified name.
ubuntu@ip-172-31-7-255:~$ docker container run --publish 80:80 --detach --name webhost1 nginx
0acaafeef74755b2c303b8486529fc289ff08087263893264f92bc7789e0016b
ubuntu@ip-172-31-7-255:~$ docker container ls -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS                      PORTS                               NAMES
0acaafeef747   nginx     "/docker-entrypoint.…"   7 seconds ago    Up 6 seconds                0.0.0.0:80->80/tcp, :::80->80/tcp   webhost1
a24cf2680c11   nginx     "/docker-entrypoint.…"   6 minutes ago    Exited (0) 3 minutes ago                                        musing_austin
b79ca2342bf0   nginx     "/docker-entrypoint.…"   14 minutes ago   Exited (0) 10 minutes ago                                       goofy_williams

# You can see the logs of the running container as below.
ubuntu@ip-172-31-7-255:~$ docker container logs webhost1
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2021/07/05 03:32:17 [notice] 1#1: using the "epoll" event method
2021/07/05 03:32:17 [notice] 1#1: nginx/1.21.0
2021/07/05 03:32:17 [notice] 1#1: built by gcc 8.3.0 (Debian 8.3.0-6)
2021/07/05 03:32:17 [notice] 1#1: OS: Linux 5.4.0-1045-aws
2021/07/05 03:32:17 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2021/07/05 03:32:17 [notice] 1#1: start worker processes
2021/07/05 03:32:17 [notice] 1#1: start worker process 31
2021/07/05 03:32:17 [notice] 1#1: start worker process 32
49.37.157.59 - - [05/Jul/2021:03:32:48 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "-"
49.37.157.59 - - [05/Jul/2021:03:33:54 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "-"
49.37.157.59 - - [05/Jul/2021:03:33:55 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "-"
49.37.157.59 - - [05/Jul/2021:03:33:56 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "-"
49.37.157.59 - - [05/Jul/2021:03:33:57 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" "-"

# You can see the running process in the container as below.
ubuntu@ip-172-31-7-255:~$ docker container top
"docker container top" requires at least 1 argument.
See 'docker container top --help'.

Usage:  docker container top CONTAINER [ps OPTIONS]

Display the running processes of a container
ubuntu@ip-172-31-7-255:~$ docker container top webhost1
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                24479               24460               0                   03:32               ?                   00:00:00            nginx: master process nginx -g daemon off;
systemd+            24551               24479               0                   03:32               ?                   00:00:00            nginx: worker process
systemd+            24552               24479               0                   03:32               ?                   00:00:00            nginx: worker process

# Clean up. using rm and rm -f

ubuntu@ip-172-31-7-255:~$ docker container ls -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS                      PORTS                               NAMES
0acaafeef747   nginx     "/docker-entrypoint.…"   6 minutes ago    Up 6 minutes                0.0.0.0:80->80/tcp, :::80->80/tcp   webhost1
a24cf2680c11   nginx     "/docker-entrypoint.…"   12 minutes ago   Exited (0) 10 minutes ago                                       musing_austin
b79ca2342bf0   nginx     "/docker-entrypoint.…"   20 minutes ago   Exited (0) 16 minutes ago                                       goofy_williams
ubuntu@ip-172-31-7-255:~$ docker container rm 0ac a24 b79
a24
b79
Error response from daemon: You cannot remove a running container 0acaafeef74755b2c303b8486529fc289ff08087263893264f92bc7789e0016b. Stop the container before attempting removal or force remove
ubuntu@ip-172-31-7-255:~$ docker container ls -a
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                               NAMES
0acaafeef747   nginx     "/docker-entrypoint.…"   6 minutes ago   Up 6 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp   webhost1
ubuntu@ip-172-31-7-255:~$ docker container rm -f 0ac
0ac
ubuntu@ip-172-31-7-255:~$ docker container ls -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
