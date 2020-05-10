echo $TRAVIS_BUILD_DIR

docker build -t ivanb1/multi-client:latest -t ivanb1/multi-client:$SHA -f /home/travis/build/ivbilev/multi-k8s/client/Dockerfile /home/travis/build/ivbilev/multi-k8s/client
docker build -t ivanb1/multi-server:latest -t ivanb1/multi-server:$SHA -f /home/travis/build/ivbilev/multi-k8s/server/Dockerfile /home/travis/build/ivbilev/multi-k8s/server
docker build -t ivanb1/multi-worker:latest -t ivanb1/multi-worker:$SHA -f /home/travis/build/ivbilev/multi-k8s/worker/Dockerfile /home/travis/build/ivbilev/multi-k8s/worker
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
