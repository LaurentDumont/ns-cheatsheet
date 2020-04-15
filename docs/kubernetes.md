## Pod configuration

### Get pods running on specific node
```
#Get the node names
kubectl get nodes                                                                                                                                                                                                                                                                         Tue 14 Apr 2020
NAME          STATUS   ROLES                      AGE    VERSION
10.10.99.58   Ready    controlplane,etcd,worker   138d   v1.16.3
10.10.99.59   Ready    controlplane,etcd,worker   138d   v1.16.3
10.10.99.60   Ready    controlplane,etcd,worker   138d   v1.16.3
10.10.99.61   Ready    controlplane,etcd,worker   138d   v1.16.3

#Get all the pods on that node
kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=10.10.99.58

kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=10.10.99.58                                                                                                                                                                                              353ms  Tue 14 Apr 2020
NAMESPACE              NAME                                                       READY   STATUS      RESTARTS   AGE    IP            NODE          NOMINATED NODE   READINESS GATES
cattle-prometheus      exporter-node-cluster-monitoring-8zzvj                     1/1     Running     2          36d    10.10.99.58   10.10.99.58   <none>           <none>
cattle-prometheus      prometheus-operator-monitoring-operator-7985c7f758-9rgf6   1/1     Running     3          36d    10.42.2.112   10.10.99.58   <none>           <none>
cattle-system          cattle-node-agent-6fprv                                    1/1     Running     5          137d   10.10.99.58   10.10.99.58   <none>           <none>
cattle-system          rancher-c88c6458c-ggnww                                    1/1     Running     22         138d   10.42.2.103   10.10.99.58   <none>           <none>
cert-manager           cert-manager-584cbff946-mcds8                              1/1     Running     13         138d   10.42.2.107   10.10.99.58   <none>           <none>
cert-manager           cert-manager-cainjector-7c556d76f-s48js                    1/1     Running     37         115d   10.42.2.111   10.10.99.58   <none>           <none>
cmaker-lab-namespace   gitlab-migrations.1-gwfl9                                  0/1     Completed   0          36d    10.42.2.82    10.10.99.58   <none>           <none>
cmaker-lab-namespace   gitlab-minio-67df89d968-lpg9b                              1/1     Running     2          36d    10.42.2.116   10.10.99.58   <none>           <none>
cmaker-lab-namespace   gitlab-nginx-ingress-controller-5655b8bf66-mtvdl           1/1     Running     2          36d    10.42.2.109   10.10.99.58   <none>           <none>
cmaker-lab-namespace   gitlab-nginx-ingress-default-backend-677f7b7778-7dj7q      1/1     Running     2          36d    10.42.2.110   10.10.99.58   <none>           <none>
cmaker-lab-namespace   gitlab-registry-647ddd89c-qrdhj                            1/1     Running     2          36d    10.42.2.115   10.10.99.58   <none>           <none>
foldingathome          fah-workers-3                                              1/1     Running     0          9d     10.42.2.125   10.10.99.58   <none>           <none>
ingress-nginx          default-http-backend-67cf578fc4-6ffns                      1/1     Running     4          138d   10.42.2.104   10.10.99.58   <none>           <none>
ingress-nginx          nginx-ingress-controller-tdfv8                             1/1     Running     4          138d   10.10.99.58   10.10.99.58   <none>           <none>
istio-system           istio-pilot-56866b7c5f-5pfj4                               2/2     Running     6          73d    10.42.2.106   10.10.99.58   <none>           <none>
istio-system           istio-sidecar-injector-8565bfc879-85p4n                    1/1     Running     4          73d    10.42.2.102   10.10.99.58   <none>           <none>
istio-system           istio-tracing-79fbf487df-g6xml                             2/2     Running     7          73d    10.42.2.108   10.10.99.58   <none>           <none>
kube-system            canal-85lqk                                                2/2     Running     8          138d   10.10.99.58   10.10.99.58   <none>           <none>
kube-system            coredns-5c59fd465f-k6ks7                                   1/1     Running     4          138d   10.42.2.105   10.10.99.58   <none>           <none>
kube-system            rke-coredns-addon-deploy-job-p97pl                         0/1     Completed   0          138d   10.10.99.58   10.10.99.58   <none>           <none>
kube-system            rke-ingress-controller-deploy-job-r2bcz                    0/1     Completed   0          138d   10.10.99.58   10.10.99.58   <none>           <none>
kube-system            rke-metrics-addon-deploy-job-r2dmg                         0/1     Completed   0          138d   10.10.99.58   10.10.99.58   <none>           <none>
kube-system            rke-network-plugin-deploy-job-ghlhz                        0/1     Completed   0          138d   10.10.99.58   10.10.99.58   <none>           <none>
metallb-system         controller-65895b47d4-stk74                                1/1     Running     2          35d    10.42.2.113   10.10.99.58   <none>           <none>
metallb-system         speaker-pnc7d                                              1/1     Running     2          35d    10.10.99.58   10.10.99.58   <none>           <none>
```

### Config-map
```
kubectl create configmap ara-config --namespace cmaker-lab-namespace --from-file=config-maps/settings.yaml   
kubectl get configmap --namespace cmaker-lab-namespace
```

### Create helm charts
```
helm install ara-postgres --namespace cmaker-lab-namespace  ./postgresql/ --values postgresql/values.yaml
helm install ara-ansible --namespace cmaker-lab-namespace  ./helm-ansible-ara/ --values helm-ansible-ara/values.yaml
```

### Delete helm charts
```
helm delete ara-ansible --namespace cmaker-lab-namespace
helm delete ara-postgres --namespace cmaker-lab-namespace
```

## Debugging

### Delete PV
```
ldumont@docker01:~$ kubectl delete pv test --grace-period=0 --force^C
ldumont@docker01:~$ kubectl patch pv test -p '{"metadata": {"finalizers": null}}'
```

## Storage

### Create Gluster Endpoint.

gluster-endpoints.yaml
```
---
kind: Endpoints
apiVersion: v1
metadata:
 name: glusterfs-cluster
subsets:
- addresses:
 - ip: 9.111.249.161
 ports:
 - port: 666
```

gluster-service.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: glusterfs-cluster
spec:
  ports:
  - port: 666
```

