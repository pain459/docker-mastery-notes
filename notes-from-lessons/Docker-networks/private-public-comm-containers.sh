#We will observe the below in this demo.
1. Review of command 'docker container run -p'
2. Quick port check with 'docker container port <container>'
3. Few docker networking concepts.

# Starting container and inspectig the IP address.

ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
ubuntu@ip-172-31-7-255:~$ docker image ls
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
nginx        latest    4cdc5dd7eaad   6 days ago    133MB
mysql        latest    5c62e459e087   2 weeks ago   556MB
ubuntu       latest    9873176a8ff5   3 weeks ago   72.7MB
alpine       latest    d4ff818577bc   3 weeks ago   5.6MB
ubuntu@ip-172-31-7-255:~$ docker container run -p 80:80 --name nginx1 -d nginx:latest
b1f8f1f2c9568b8085e5015688a00f2ccd7cf8e2c27fa334d447b4b4ccbbdc02

# publishing ports is always HOST:CONTAINER format

ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                               NAMES
b1f8f1f2c956   nginx:latest   "/docker-entrypoint.…"   58 seconds ago   Up 56 seconds   0.0.0.0:80->80/tcp, :::80->80/tcp   nginx1
ubuntu@ip-172-31-7-255:~$ docker container port nginx1
80/tcp -> 0.0.0.0:80
80/tcp -> :::80
ubuntu@ip-172-31-7-255:~$ docker container inspect --format '{{ .NetworkSettings.IPAddress }}' nginx1
172.17.0.2

# points to remember
1. -p 8080:80 for example actually means... the port of the local host 8080 is listening to route the traffic into port 80 of the container.
2. If any traffic hits the physical host at 8080, it will be routed to the port 80 of the container.
3. We cannot declare -p 8080:80 for one container and -p 8080:90 on another container. As one port cannot listen for 2 containers. Its not possible and there will be errors during command execution.

# Example.
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                               NAMES
b1f8f1f2c956   nginx:latest   "/docker-entrypoint.…"   15 minutes ago   Up 15 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp   nginx1
ubuntu@ip-172-31-7-255:~$ docker container run -p 80:90 --name nginx2 -d nginx:latest
ae2ff14185409f14a205112cf0073f5d52d96ffcbd7659f32f2c02d7757d50fe
docker: Error response from daemon: driver failed programming external connectivity on endpoint nginx2 (bfb037fc5d08aa5b1b2e42a4919c3c3bf35acb3b524d8299d9e118cc83123722): Bind for 0.0.0.0:80 failed: port is already allocated.
