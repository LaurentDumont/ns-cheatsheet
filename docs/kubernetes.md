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