# We will see the ways to connect to the containers (not via ssh) and execute commands here.
$ docker container run -it # This command starts new container interactively
$ docker container exec -it # Run additional command in existing container.
# We will test this on the existing containers.

# Current State
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
d8448f0bc197   mysql:latest   "docker-entrypoint.s…"   22 minutes ago   Up 22 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
b06142e3f3a1   nginx:latest   "/docker-entrypoint.…"   22 minutes ago   Up 22 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx

# starting the container named proxy and getting a shell inside it.

ubuntu@ip-172-31-7-255:~$ docker container run -it --name proxy nginx bash
root@b8b0b47a7d10:/# ls
bin  boot  dev  docker-entrypoint.d  docker-entrypoint.sh  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@b8b0b47a7d10:/# ll
bash: ll: command not found
root@b8b0b47a7d10:/# exit
exit
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                       PORTS                                                  NAMES
b8b0b47a7d10   nginx          "/docker-entrypoint.…"   36 seconds ago   Exited (100) 2 seconds ago                                                          proxy
d8448f0bc197   mysql:latest   "docker-entrypoint.s…"   23 minutes ago   Up 23 minutes                0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
b06142e3f3a1   nginx:latest   "/docker-entrypoint.…"   24 minutes ago   Up 24 minutes                0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx

# Connecting to an existing container.
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS                            PORTS                                                  NAMES
b8b0b47a7d10   nginx          "/docker-entrypoint.…"   About a minute ago   Exited (100) About a minute ago                                                          proxy
d8448f0bc197   mysql:latest   "docker-entrypoint.s…"   25 minutes ago       Up 25 minutes                     0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
b06142e3f3a1   nginx:latest   "/docker-entrypoint.…"   25 minutes ago       Up 25 minutes                     0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx
ubuntu@ip-172-31-7-255:~$ docker container exec -it nginx bash
root@b06142e3f3a1:/# ls
bin  boot  dev  docker-entrypoint.d  docker-entrypoint.sh  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@b06142e3f3a1:/# ps
bash: ps: command not found
root@b06142e3f3a1:/# exit
exit
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                            PORTS                                                  NAMES
b8b0b47a7d10   nginx          "/docker-entrypoint.…"   2 minutes ago    Exited (100) About a minute ago                                                          proxy
d8448f0bc197   mysql:latest   "docker-entrypoint.s…"   25 minutes ago   Up 25 minutes                     0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
b06142e3f3a1   nginx:latest   "/docker-entrypoint.…"   26 minutes ago   Up 26 minutes                     0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx

# Starting an ubuntu container and installing curl package.

ubuntu@ip-172-31-7-255:~$ docker container run -it --name ubuntu1 ubuntu:latest bash
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
c549ccf8d472: Pull complete
Digest: sha256:aba80b77e27148d99c034a987e7da3a287ed455390352663418c0f2ed40417fe
Status: Downloaded newer image for ubuntu:latest
root@dda713de6fb9:/# ls
bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@dda713de6fb9:/# ps
    PID TTY          TIME CMD
      1 pts/0    00:00:00 bash
     14 pts/0    00:00:00 ps
root@dda713de6fb9:/# curl
bash: curl: command not found
root@dda713de6fb9:/# apt-get install curl
Reading package lists... Done
Building dependency tree
Reading state information... Done
E: Unable to locate package curl
root@dda713de6fb9:/# apt update
Get:1 http://archive.ubuntu.com/ubuntu focal InRelease [265 kB]
<Truncated>
...
Get:18 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [779 kB]
Fetched 18.4 MB in 4s (4992 kB/s)
Reading package lists... Done
Building dependency tree
Reading state information... Done
11 packages can be upgraded. Run 'apt list --upgradable' to see them.
root@dda713de6fb9:/# apt install curl
Reading package lists... Done
Building dependency tree
Reading state information... Done
<Truncated>
...
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
root@dda713de6fb9:/# curl google.com
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

root@dda713de6fb9:/# exit
exit
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE           COMMAND                  CREATED          STATUS                       PORTS                                                  NAMES
dda713de6fb9   ubuntu:latest   "bash"                   3 minutes ago    Exited (0) 8 seconds ago                                                            ubuntu1
b8b0b47a7d10   nginx           "/docker-entrypoint.…"   7 minutes ago    Exited (100) 6 minutes ago                                                          proxy
d8448f0bc197   mysql:latest    "docker-entrypoint.s…"   30 minutes ago   Up 30 minutes                0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
b06142e3f3a1   nginx:latest    "/docker-entrypoint.…"   30 minutes ago   Up 30 minutes                0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx

# Connecting to a stopped container and checking the changes made to packages. We installed curl in the previous example.

ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE           COMMAND                  CREATED          STATUS                       PORTS                                                  NAMES
dda713de6fb9   ubuntu:latest   "bash"                   3 minutes ago    Exited (0) 8 seconds ago                                                            ubuntu1
b8b0b47a7d10   nginx           "/docker-entrypoint.…"   7 minutes ago    Exited (100) 6 minutes ago                                                          proxy
d8448f0bc197   mysql:latest    "docker-entrypoint.s…"   30 minutes ago   Up 30 minutes                0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
b06142e3f3a1   nginx:latest    "/docker-entrypoint.…"   30 minutes ago   Up 30 minutes                0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx

ubuntu@ip-172-31-7-255:~$ docker container start -ai ubuntu1
root@dda713de6fb9:/# curl google.com
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

# Experimenting with Alpine.
ubuntu@ip-172-31-7-255:~$ docker pull alpine:latest
latest: Pulling from library/alpine
5843afab3874: Pull complete
Digest: sha256:234cb88d3020898631af0ccbbcca9a66ae7306ecd30c9720690858c1b007d2a0
Status: Downloaded newer image for alpine:latest
docker.io/library/alpine:latest
ubuntu@ip-172-31-7-255:~$ docker image ls
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
nginx        latest    4cdc5dd7eaad   5 days ago    133MB
mysql        latest    5c62e459e087   2 weeks ago   556MB
ubuntu       latest    9873176a8ff5   3 weeks ago   72.7MB
alpine       latest    d4ff818577bc   3 weeks ago   5.6MB

# Container startup failed as bash shell is not available in alpine image.
ubuntu@ip-172-31-7-255:~$ docker container run -it --name alpine1 alpine:latest bash
docker: Error response from daemon: OCI runtime create failed: container_linux.go:380: starting container process caused: exec: "bash": executable file not found in $PATH: unknown.
ERRO[0000] error waiting for container: context canceled
# Note that we have to specify a differnt name if the previous container bootup has failed.
ubuntu@ip-172-31-7-255:~$ docker container run -it --name alpine1 alpine:latest sh
docker: Error response from daemon: Conflict. The container name "/alpine1" is already in use by container "e4abdac616b99ba7f66c9716818eaa6e3f4d730a6895c0d0f8149dd741db321d". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'.
ubuntu@ip-172-31-7-255:~$ docker container run -it --name alpine2 alpine:latest sh
/ # ls
bin    dev    etc    home   lib    media  mnt    opt    proc   root   run    sbin   srv    sys    tmp    usr    var
/ # top
Mem: 2636780K used, 1390468K free, 1900K shrd, 78456K buff, 1813700K cached
CPU:   0% usr   0% sys   0% nic 100% idle   0% io   0% irq   0% sirq
Load average: 0.00 0.02 0.00 2/302 9
  PID  PPID USER     STAT   VSZ %VSZ CPU %CPU COMMAND
    1     0 root     S     1668   0%   0   0% sh
    9     1 root     R     1600   0%   1   0% top
/ # ping
BusyBox v1.33.1 () multi-call binary.

Usage: ping [OPTIONS] HOST

Send ICMP ECHO_REQUESTs to HOST

        -4,-6           Force IP or IPv6 name resolution
        -c CNT          Send only CNT pings
        -s SIZE         Send SIZE data bytes in packets (default 56)
        -i SECS         Interval
        -A              Ping as soon as reply is recevied
        -t TTL          Set TTL
        -I IFACE/IP     Source interface or IP address
        -W SEC          Seconds to wait for the first response (default 10)
                        (after all -c CNT packets are sent)
        -w SEC          Seconds until ping exits (default:infinite)
                        (can exit earlier with -c CNT)
        -q              Quiet, only display output at start/finish
        -p HEXBYTE      Payload pattern
/ # exit

ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE           COMMAND                  CREATED          STATUS                          PORTS                                                  NAMES
d738db8443df   alpine:latest   "sh"                     30 seconds ago   Exited (1) 8 seconds ago                                                               alpine2
e4abdac616b9   alpine:latest   "bash"                   46 seconds ago   Created                                                                                alpine1
dda713de6fb9   ubuntu:latest   "bash"                   7 minutes ago    Exited (0) About a minute ago                                                          ubuntu1
b8b0b47a7d10   nginx           "/docker-entrypoint.…"   11 minutes ago   Exited (100) 10 minutes ago                                                            proxy
d8448f0bc197   mysql:latest    "docker-entrypoint.s…"   34 minutes ago   Up 34 minutes                   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
b06142e3f3a1   nginx:latest    "/docker-entrypoint.…"   35 minutes ago   Up 35 minutes                   0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx
