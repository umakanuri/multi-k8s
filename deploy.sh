docker build -t ukanuri/multi-cient:latest -t ukanuri/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ukanuri/multi-server:latest -t ukanuri/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ukanuri/multi-worker:latest -t ukanuri/multi-woker:$SHA -f ./worker/Dockerfile ./worker
docker push ukanuri/multi-client:latest
docker push ukanuri/multi-server:latest
docker push ukanuri/multi-worker:latest

docker push ukanuri/multi-client:$SHA
docker push ukanuri/multi-server:$SHA
docker push ukanuri/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ukanuri/multi-server:$SHA
kubectl set image deployments/client-deployment client=ukanuri/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ukanuri/multi-worker:$SHA