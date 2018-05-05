```
#Docker volume - Prometheus config
sudo docker volume create prometheus-config

#Docker volume - Prometheus metrics and adata
sudo docker volume create prometheus-data

sudo docker run -d -p 9090:9090 -v prometheus-config:/prometheus-config -v prometheus-data:/prometheus prom/prometheus --config.file=/prometheus-config/prometheus.yml
```
