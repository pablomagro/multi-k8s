
docker build -t pmagas/multi-client:latest -t pmagas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pmagas/multi-server:latest -t pmagas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pmagas/multi-worker:latest -t pmagas/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pmagas/multi-client:latest
docker push pmagas/multi-server:latest
docker push pmagas/multi-worker:latest

docker push pmagas/multi-client:$SHA
docker push pmagas/multi-server:$SHA
docker push pmagas/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pmagas/multi-server:$SHA
kubectl set image deployments/client-deployment client=pmagas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pmagas/multi-worker:$SHA