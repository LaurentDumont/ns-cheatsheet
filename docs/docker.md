### IDRAC Docker VNC image
https://github.com/DomiStyle/docker-idrac6

```
docker run -d -p 5800:5800 -p 5900:5900 -e IDRAC_HOST=IP_HERE -e IDRAC_USER=root -e IDRAC_PASSWORD=calvin domistyle/idrac6
```