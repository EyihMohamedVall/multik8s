docker build -t mohamedvall/multi-client:latest -t mohamedvall/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mohamedvall/multi-server:latest -t mohamedvall/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mohamedvall/multi-worker:latest -t mohamedvall/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mohamedvall/multi-client:latest
docker push mohamedvall/multi-server:latest
docker push mohamedvall/multi-worker:latest

docker push mohamedvall/multi-client:$SHA
docker push mohamedvall/multi-server:$SHA
docker push mohamedvall/multi-worker:$SHA

kubectl apply -f k8s

kubectl image deployments/client-deployment client=mohamedvall/multi-client:$SHA
kubectl image deployments/server-deployment server=mohamedvall/multi-server:$SHA
kubectl image deployments/worker-deployment worker=mohamedvall/multi-worker:$SHA