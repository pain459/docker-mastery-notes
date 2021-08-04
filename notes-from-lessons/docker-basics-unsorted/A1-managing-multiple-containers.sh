# Run multiple containers on the system via random ports. Commands below.

# Starting 3 containers from different ports.

ubuntu@ip-172-31-7-255:~$ docker container ls -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
ubuntu@ip-172-31-7-255:~$ docker image ls -a
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
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
ba0d464ce54e6cbdd40e3910d4484b026801a01efe2b3e046dc7ab36e2146c7e
ubuntu@ip-172-31-7-255:~$ docker container run --publish 8080:80 --detach --name httpd httpd:latest
Unable to find image 'httpd:latest' locally
latest: Pulling from library/httpd
b4d181a07f80: Already exists
4b72f5187e6e: Pull complete
12b2c44d04b2: Pull complete
35c238b46d30: Pull complete
1adcec05f52b: Pull complete
Digest: sha256:1fd07d599a519b594b756d2e4e43a72edf7e30542ce646f5eb3328cf3b12341a
Status: Downloaded newer image for httpd:latest
52d4648a835ec355c9f597fd98026022068a5ea18a1d3c26d75b7c301b78c156
ubuntu@ip-172-31-7-255:~$
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
e4eca4467868ab76c32dfd32de69cea678bc88eed4ebbbc03f276fdc7222d704

# Test the access from below links.
nginx = http://ec2-35-154-145-35.ap-south-1.compute.amazonaws.com/ -> URL based on the current IP.
httpd = http://ec2-35-154-145-35.ap-south-1.compute.amazonaws.com:8080 -> URL based on the current IP.

# verifying the random password created during mysql startup.

ubuntu@ip-172-31-7-255:~$ docker container ls -a
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                                                  NAMES
e4eca4467868   mysql:latest   "docker-entrypoint.s…"   2 minutes ago   Up 2 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
52d4648a835e   httpd:latest   "httpd-foreground"       7 minutes ago   Up 7 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp                  httpd
ba0d464ce54e   nginx:latest   "/docker-entrypoint.…"   7 minutes ago   Up 7 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx
ubuntu@ip-172-31-7-255:~$ docker container logs e4e
2021-07-12 06:32:07+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.25-1debian10 started.
2021-07-12 06:32:07+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2021-07-12 06:32:07+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.25-1debian10 started.
2021-07-12 06:32:07+00:00 [Note] [Entrypoint]: Initializing database files
2021-07-12T06:32:07.974386Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.25) initializing of server in progress as process 41
2021-07-12T06:32:07.981372Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2021-07-12T06:32:09.725373Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2021-07-12T06:32:11.880791Z 6 [Warning] [MY-010453] [Server] root@localhost is created with an empty password ! Please consider switching off the --initialize-insecure option.
2021-07-12 06:32:16+00:00 [Note] [Entrypoint]: Database files initialized
2021-07-12 06:32:16+00:00 [Note] [Entrypoint]: Starting temporary server
2021-07-12T06:32:16.378052Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.25) starting as process 86
2021-07-12T06:32:16.399102Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2021-07-12T06:32:16.786656Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2021-07-12T06:32:16.918143Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Socket: /var/run/mysqld/mysqlx.sock
2021-07-12T06:32:17.067731Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2021-07-12T06:32:17.067922Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
2021-07-12T06:32:17.072002Z 0 [Warning] [MY-011810] [Server] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
2021-07-12T06:32:17.097442Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.25'  socket: '/var/run/mysqld/mysqld.sock'  port: 0  MySQL Community Server - GPL.
2021-07-12 06:32:17+00:00 [Note] [Entrypoint]: Temporary server started.
Warning: Unable to load '/usr/share/zoneinfo/iso3166.tab' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo/leap-seconds.list' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo/zone.tab' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo/zone1970.tab' as time zone. Skipping it.
2021-07-12 06:32:20+00:00 [Note] [Entrypoint]: GENERATED ROOT PASSWORD: AhG3thoh4aeYihahl4yie3ieL9deihei

2021-07-12 06:32:20+00:00 [Note] [Entrypoint]: Stopping temporary server
2021-07-12T06:32:20.537751Z 10 [System] [MY-013172] [Server] Received SHUTDOWN from user root. Shutting down mysqld (Version: 8.0.25).
2021-07-12T06:32:22.282510Z 0 [System] [MY-010910] [Server] /usr/sbin/mysqld: Shutdown complete (mysqld 8.0.25)  MySQL Community Server - GPL.
2021-07-12 06:32:22+00:00 [Note] [Entrypoint]: Temporary server stopped

2021-07-12 06:32:22+00:00 [Note] [Entrypoint]: MySQL init process done. Ready for start up.

2021-07-12T06:32:22.853192Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.25) starting as process 1
2021-07-12T06:32:22.864335Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2021-07-12T06:32:23.244702Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2021-07-12T06:32:23.373785Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Bind-address: '::' port: 33060, socket: /var/run/mysqld/mysqlx.sock
2021-07-12T06:32:23.468101Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2021-07-12T06:32:23.468297Z 0 [System] [MY-013602] [Server] Channel mysql_main configured to support TLS. Encrypted connections are now supported for this channel.
2021-07-12T06:32:23.473182Z 0 [Warning] [MY-011810] [Server] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
2021-07-12T06:32:23.498064Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.25'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.

#Stopping all the containers at once and removing them.
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
e4eca4467868   mysql:latest   "docker-entrypoint.s…"   21 minutes ago   Up 21 minutes   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql
52d4648a835e   httpd:latest   "httpd-foreground"       25 minutes ago   Up 25 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp                  httpd
ba0d464ce54e   nginx:latest   "/docker-entrypoint.…"   26 minutes ago   Up 26 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp                      nginx
ubuntu@ip-172-31-7-255:~$ docker container stop e4e 52d ba0
e4e
52d
ba0
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                     PORTS     NAMES
e4eca4467868   mysql:latest   "docker-entrypoint.s…"   21 minutes ago   Exited (0) 4 seconds ago             mysql
52d4648a835e   httpd:latest   "httpd-foreground"       26 minutes ago   Exited (0) 3 seconds ago             httpd
ba0d464ce54e   nginx:latest   "/docker-entrypoint.…"   27 minutes ago   Exited (0) 4 seconds ago             nginx
ubuntu@ip-172-31-7-255:~$ docker container rm e4e 52d ba0
e4e
52d
ba0
ubuntu@ip-172-31-7-255:~$ docker container ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
ubuntu@ip-172-31-7-255:~$ docker container ls -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

# removing the images now.
ubuntu@ip-172-31-7-255:~$ docker image ls
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
httpd        latest    bd29370f84ea   3 days ago    138MB
nginx        latest    4cdc5dd7eaad   5 days ago    133MB
mysql        latest    5c62e459e087   2 weeks ago   556MB
ubuntu@ip-172-31-7-255:~$ docker image rmi httpd nginx mysql
Untagged: httpd:latest
Untagged: httpd@sha256:1fd07d599a519b594b756d2e4e43a72edf7e30542ce646f5eb3328cf3b12341a
Deleted: sha256:bd29370f84eac6a9fa5373f8ed702f66820e784e5f680b62670af9f851017c96
Deleted: sha256:91fe878e1dedb23768919989d6123dc6cf22bda8f052b891876f71b92bf38803
Deleted: sha256:764b68edcbc2938e3d53f4977145d094fcc321aed11d2a254740966b826dd30c
Deleted: sha256:356e3acf71a1a4ccc94a250fa7e6351f7b1691b7dc0ee48be96c97709cd1b7b8
Deleted: sha256:43c41c92588e603f75963bab3a334a02109a6381002f784223bdeec5f46ba7a3
Untagged: nginx:latest
Untagged: nginx@sha256:353c20f74d9b6aee359f30e8e4f69c3d7eaea2f610681c4a95849a2fd7c497f9
Deleted: sha256:4cdc5dd7eaadff5080649e8d0014f2f8d36d4ddf2eff2fdf577dd13da85c5d2f
Deleted: sha256:63d268dd303e176ba45c810247966ff8d1cb9a5bce4a404584087ec01c63de15
Deleted: sha256:b27eb5bbca70862681631b492735bac31d3c1c558c774aca9c0e36f1b50ba915
Deleted: sha256:435c6dad68b58885ad437e5f35f53e071213134eb9e4932b445eac7b39170700
Deleted: sha256:bdf28aff423adfe7c6cb938eced2f19a32efa9fa3922a3c5ddce584b139dc864
Deleted: sha256:2c78bcd3187437a7a5d9d8dbf555b3574ba7d143c1852860f9df0a46d5df056a
Untagged: mysql:latest
Untagged: mysql@sha256:52b8406e4c32b8cf0557f1b74517e14c5393aff5cf0384eff62d9e81f4985d4b
Deleted: sha256:5c62e459e087e3bd3d963092b58e50ae2af881076b43c29e38e2b5db253e0287
Deleted: sha256:b92a81bddd621ceee73e48583ed5c4f0d34392a5c60adf37c0d7acc98177e414
Deleted: sha256:265829a9fa8318ae1224f46ab7bc0a10d12ebb90d5f65d71701567f014685a9e
Deleted: sha256:2b9144b43d615572cb4a8fb486dfad0f78d1748241e49adab91f6072183644e9
Deleted: sha256:944ffc10a452573e587652116c3217cf571a32c45a031b79fed518524c21fd4f
Deleted: sha256:b9108f19e3abf550470778a9d91959ce812731d3268d7224e328b0f7d8a73d26
Deleted: sha256:9aecb80117a5517daf84c1743af298351a08e48fa04b8e99dcb63c817326a748
Deleted: sha256:d8773288899b1230986eba7486009df11d5dd6c628b1d4fd0443e873c6b00f70
Deleted: sha256:45a0a6bb39a4d7b37a6c598ae6af47f8a36ef63eaa9ef92d565137156aa36f54
Deleted: sha256:341f6b75346e72e9fa503aeb5362d1fe4f00449e02d3320e5c68f3052b7c2c13
Deleted: sha256:023f47f19f876ffa0225502a85b30954a44e54dc8223329fec32b336315c75c3
Deleted: sha256:058c443dffe18a5d2aad04cd5451a8540c7272ce9f8515d27e815303b1c25b59
Deleted: sha256:764055ebc9a7a290b64d17cf9ea550f1099c202d83795aa967428ebdf335c9f7
ubuntu@ip-172-31-7-255:~$ docker image ls
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
