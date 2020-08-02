docker build -t justin89721/multi-client:latest -t justin89721/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t justin89721/multi-server:latest -t justin89721/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t justin89721/multi-worker:latest -t justin89721/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push justin89721/multi-client:latest
docker push justin89721/multi-server:latest
docker push justin89721/multi-worker:latest

docker push justin89721/multi-client:$SHA
docker push justin89721/multi-server:$SHA
docker push justin89721/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=justin89721/multi-server:$SHA
kubectl set image deployments/client-deployment client=justin89721/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=justin89721/multi-worker:$SHA