docker build -t ivanb1/multi-client:latest -t ivanb1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ivanb1/multi-server:latest -t ivanb1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ivanb1/multi-worker:latest -t ivanb1/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ivanb1/multi-client:latest
docker push ivanb1/multi-client:$SHA
docker push ivanb1/multi-server:latest
docker push ivanb1/multi-server:$SHA
docker push ivanb1/multi-worker:latest
docker push ivanb1/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ivanb1/multi-server:$SHA
kubectl set image deployments/client-deployment client=ivanb1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ivanb1/multi-worker:$SHA
