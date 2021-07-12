# We will attempt to check the running containers in the process trees.

ubuntu@ip-172-31-7-255:~$ docker container run --name mongo -d mongo
Unable to find image 'mongo:latest' locally
latest: Pulling from library/mongo
25fa05cd42bd: Pull complete
3380d70bde1c: Pull complete
9c5e30e9886d: Pull complete
c6583381983d: Pull complete
7873a2834540: Pull complete
5550b05263ab: Pull complete
f8c53eb02c3e: Pull complete
36d83d0aa258: Pull complete
b6790a091c8a: Pull complete
8cc2814c4956: Pull complete
Digest: sha256:fe44eb6a2ea2bb1548718ec05eb9cb165f1bded37595ebea507bddc413ab99ae
Status: Downloaded newer image for mongo:latest
89ccefec098fc7bea4822b159e9fb5c224ea9a59f90a9b955e6de06494fdb32e
ubuntu@ip-172-31-7-255:~$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS       NAMES
89ccefec098f   mongo     "docker-entrypoint.s…"   6 seconds ago   Up 2 seconds   27017/tcp   mongo
ubuntu@ip-172-31-7-255:~$ docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS         PORTS       NAMES
89ccefec098f   mongo     "docker-entrypoint.s…"   10 seconds ago   Up 6 seconds   27017/tcp   mongo
ubuntu@ip-172-31-7-255:~$ docker top mongo
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
systemd+            1786                1766                5                   06:13               ?                   00:00:00            mongod --bind_ip_all
ubuntu@ip-172-31-7-255:~$ ps auxf | grep mongo | grep -v grep
systemd+    1786  2.9  2.4 1578708 97284 ?       Ssl  06:13   0:00  \_ mongod --bind_ip_all

ubuntu@ip-172-31-7-255:~$ docker container stop mongo
mongo
ubuntu@ip-172-31-7-255:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
ubuntu@ip-172-31-7-255:~$ docker top mongo
Error response from daemon: Container 89ccefec098fc7bea4822b159e9fb5c224ea9a59f90a9b955e6de06494fdb32e is not running
ubuntu@ip-172-31-7-255:~$ ps auxf | grep mongo | grep -v grep

# Using this simple demo, we can see the container as running process on the system.

# performing house keeping.

ubuntu@ip-172-31-7-255:~$ docker image ls
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
mongo        latest    0e120e3fce9a   2 weeks ago   449MB
nginx        latest    4f380adfc10f   2 weeks ago   133MB
ubuntu@ip-172-31-7-255:~$ docker image rmi 0e1 4f3
Untagged: nginx:latest
Untagged: nginx@sha256:47ae43cdfc7064d28800bc42e79a429540c7c80168e8c8952778c0d5af1c09db
Deleted: sha256:4f380adfc10f4cd34f775ae57a17d2835385efd5251d6dfe0f246b0018fb0399
Deleted: sha256:2855bbcefcf95050e64049447e99e77efa2bff32374e586982d69be4612467ce
Deleted: sha256:bad169ad8b30eab551acbb8cd8fbdcd824528189e3dd0cc52dd88a37bbf121cd
Deleted: sha256:36d83ebf5fec7ae1be4c431f0945f2dbe6828ecdc936c604daa48f17c0b50ed7
Deleted: sha256:b4c9a251dc81d52dd1cca9b4c69ca9e4db602a9a7974019f212846577f739699
Deleted: sha256:038ca5b801cea48e9f40f6ffb4cda61a2fe0b6b0f378a7434a0d39d2575a4082
Deleted: sha256:764055ebc9a7a290b64d17cf9ea550f1099c202d83795aa967428ebdf335c9f7
Error response from daemon: conflict: unable to delete 0e120e3fce9a (must be forced) - image is being used by stopped container 89ccefec098f
ubuntu@ip-172-31-7-255:~$ docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS                     PORTS     NAMES
89ccefec098f   mongo     "docker-entrypoint.s…"   4 minutes ago   Exited (0) 3 minutes ago             mongo
ubuntu@ip-172-31-7-255:~$ docker container rm 89c
89c
ubuntu@ip-172-31-7-255:~$ docker image rmi 0e1 4f3
Untagged: mongo:latest
Untagged: mongo@sha256:fe44eb6a2ea2bb1548718ec05eb9cb165f1bded37595ebea507bddc413ab99ae
Deleted: sha256:0e120e3fce9ae7e798cdf515db8124b20691ab8805487ddbb2c6bff217a9a109
Deleted: sha256:38cb6925c06b5eac8de0785d7ba11a2f788c476f3c5e5da60b47aad2511ebd37
Deleted: sha256:f1000fe179e43146631e8783aaed7f5f1e8f1d8b2836f030c69d2238e2238a75
Deleted: sha256:7170e61d77f1a9e2f8bde6d44345a34b6ab628ef53b9091d2e8400b1b8a6b488
Deleted: sha256:5598e9b3175e2de8bd815582970e683a4f55dc0a771aabd918411997a737f7a6
Deleted: sha256:01fbec63fd24ed96ff900ed83b4423190522561f134f575972a87d203650f21e
Deleted: sha256:53ab5315aee83a46babc50dca5a3da3cbe75f9d392f3d47b1b60d23666e505dd
Deleted: sha256:c4f89fd4dfe5a19d796f9c409093fa4503188b61955763243e601a5cd9f6d989
Deleted: sha256:2b6fb1cc5fcde94c4fdd04f05392cad36b3144b2b196f35b7ff5441963296d5a
Deleted: sha256:0a46fab7aeddc1fe128ee1798336d87d755ce71b3d3042a2bc54d8ed0cdfc99f
Deleted: sha256:8f8f0266f8349dd17fdca5a1c827a7c8b11d84903b1226b05c6fbdc7edd30652
Error: No such image: 4f3
