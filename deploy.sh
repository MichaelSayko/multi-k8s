docker build -t michaelsayko/multi-client:latest -t michaelsayko/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t michaelsayko/multi-server:latest -t michaelsayko/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t michaelsayko/multi-worker:latest -t michaelsayko/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push michaelsayko/multi-client:latest
docker push michaelsayko/multi-server:latest
docker push michaelsayko/multi-worker:latest

docker push michaelsayko/multi-client:$SHA
docker push michaelsayko/multi-server:$SHA
docker push michaelsayko/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=michaelsayko/multi-server:$SHA
kubectl set image deployments/client-deployment client=michaelsayko/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=michaelsayko/multi-worker:$SHA