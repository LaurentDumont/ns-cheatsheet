```
#Docker volume - Prometheus config
sudo docker volume create prometheus-config

#Docker volume - Prometheus metrics and adata
sudo docker volume create prometheus-data

sudo docker run -d -p 9090:9090 -v prometheus-config:/prometheus-config -v prometheus-data:/prometheus prom/prometheus --config.file=/prometheus-config/prometheus.yml
```

Grafana container
```
sudo docker volume create grafana-config
sudo docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  -v grafana-storage:/var/lib/grafana \
  -e "GF_SECURITY_ADMIN_PASSWORD=PASSWORD_HERE" \
  grafana/grafana

```
