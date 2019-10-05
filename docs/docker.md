### Docker install bash script.

```
#Install docker
#!/bin/bash

sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update && apt-get install docker-ce
```


### IDRAC Docker VNC image

https://github.com/DomiStyle/docker-idrac6

```
docker run -d -p 5800:5800 -p 5900:5900 -e IDRAC_HOST=IP_HERE -e IDRAC_USER=root -e IDRAC_PASSWORD=calvin domistyle/idrac6
```

### Radarr Docker

```
docker volume create radarr-config

sudo docker run \
  -d \
  --name=radarr \
  -e PUID=109 \
  -e PGID=113 \
  -e TZ=America/Toronto \
  -p 7878:7878 \
  -v radarr-config:/config \
  -v /storage/media-gluster/movies/:/movies \
  -v /storage/media-gluster/downloads:/downloads \
  --restart unless-stopped \
  linuxserver/radarr
```

### Grafana Docker

```
sudo docker volume create grafana-storage
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  -v grafana-storage:/var/lib/grafana \
  grafana/grafana
```

### Couchpotato Docker.

```
docker volume create couchpotato-config

docker run \
    --name=couchpotato \
    -v couchpotato-config:/config \
    -v /storage/torrents_download:/downloads \
    -v /storage/media/movies:/movies \
    -e TZ=America/Toronto \
    -e PGID=113 -e PUID=109  \
    -p 5050:5050 \
    -d \
    linuxserver/couchpotato
```

### Watch docker stats
```
watch 'docker stats --no-stream --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"'
```
