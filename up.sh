kubectl apply -f puma-deployment.yaml
kubectl expose deployment puma --port 8000 --target-port=9292 --name puma --type=LoadBalancer
sleep 2
curl http://localhost:8000/

