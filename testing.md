# setup with kubernetes

```
kubectl apply -f puma-deployment.yaml
kubectl expose deployment puma --port 8000 --target-port 9292 --name puma --type=LoadBalancer
```

verify pods happy:

```
kubectl get pods
```

## setup terminals

##### first one - track pods

```sh
while true; do k get pods; sleep 5 ; done
```

##### second - get internal status of docker

```sh
docker run -it --privileged --pid=host justincormack/nsenter1
```

In this one you can use `dmesg` or `ps -o pid,vsz,rss,comm | grep ruby`

Also `watch 'dmesg | tail -10'` can be useful for watching for Out of memory oom.

##### third - a single requester to see the puma server output

```sh
while true; do curl http://localhost:8000; done
```

## postman

Use the `performance` section of the `run` menu to run 20+ virtual users against the
system.

# adjusting the system

Use `k edit deployment puma` to adjust cluster setup.

You can change processes and threads, replicas.