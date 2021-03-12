docker build -t simonlambrix/multi-client:latest -t simonlambrix/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t simonlambrix/multi-server:latest -t simonlambrix/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t simonlambrix/multi-worker:latest -t simonlambrix/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push simonlambrix/multi-client:latest
docker push simonlambrix/multi-server:latest
docker push simonlambrix/multi-worker:latest
docker push simonlambrix/multi-client:$SHA
docker push simonlambrix/multi-server:$SHA
docker push simonlambrix/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=simonlambrix/multi-server:$SHA
kubectl set image deployments/client-deployment client=simonlambrix/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=simonlambrix/multi-worker:$SHA
