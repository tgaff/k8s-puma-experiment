# build docker image locally

```
docker build . -t puma-local
```

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

> edit: looks like you need an account to do this more than 25 times

# adjusting the system

## via kubernetes config

Use `k edit deployment puma` to adjust cluster setup.

You can change processes and threads, replicas.


## via signals

If run locally you can use signals.

```
pkill -USR1 puma
```

##### Puma signals
  - Puma cluster responds to these signals:
  - TTIN increment the worker count by 1
  - TTOU decrement the worker count by 1
  - TERM send TERM to worker. The worker will attempt to finish then exit.
  - USR2 restart workers. This also reloads the Puma configuration file, if there is one.
  - USR1 restart workers in phases, a rolling restart. This will not reload the configuration file.
  - HUP reopen log files defined in stdout_redirect configuration parameter. If there is no stdout_redirect option provided, it will behave like INT
  - INT equivalent of sending Ctrl-C to cluster. Puma will attempt to finish then exit.
  - CHLD
  - URG refork workers in phases from worker 0 if fork_workers option is enabled.
  - INFO print backtraces of all puma threads


  # results / thoughts

  - 5 process, 1 thread each - receives OOM, but no pod restart
  - 1 process, 5 threads - receives OOM, but no pod restart
  - **single mode** 1 process, 5 threads - receives OOM and gets pod restarts

  This issue may explain why the linux VM reports OOMs but the pods aren't restarted
  https://github.com/kubernetes/kubernetes/issues/50632