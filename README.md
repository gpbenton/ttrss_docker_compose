# ttrss_docker_compose
A docker compose configuration to run ttrss as a php-fpm service

## Background
The simple way of running ttrss in a docker container is to use a prebuilt container such as https://hub.docker.com/r/clue/ttrss/.  However this includes an nginx web server, and rather precludes running another web service on your machine, unless you run another web server.

This docker-compose file runs a php-fpm official image modified with components necessary for ttrss, combined with a postgres official image, that can be run from a separate  web server such as caddy or nginx.

## Execution
Clone the tt-rss repository into ${HOME}/public_html/ttrss.  If you choose another location, you will have to modify the files.

Clone this repository into another directory named ttrss.   The exact location doesn't really matter, but the directory name is used to generate the docker internal network name.  You can use environmental variables to specify this, see the docker-compose documentation.

In this directory do

```
docker-compose build
docker-compose up -d
```

Which should create the two containers, and a database volume for storing your ttrss data.  Check with `docker ps` and `docker-compose logs`


## Integration with Web Server

I use caddy with this configuration.  NGINX configurations to do the equivalent are welcome.

```
http://localhost/ttrss {
  root /srv/ttrss

  # ttrss is on the ttrss_default network created by docker-compose
  fastcgi / ttrss:9000 php {
    root /var/www/html/ttrss
  }

}
```
## tt-rss procedures
You can follow all the standard tt-rss configuration and update procedures.

## Feed updating
To update feeds, run the following in a crontab in the host machine

```
# refresh ttrss feeds
*/15 * * * * /usr/bin/docker exec --user www-data ttrss php ttrss/update.php --feeds 
```
