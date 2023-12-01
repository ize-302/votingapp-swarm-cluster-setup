# Networks creation
#### Backend network
docker network create --driver overlay backend
#### Frontend network
docker network create --driver overlay frontend

## Services creation
#### vote service
docker service create -p 80:80 --replicas 3 --network frontend --name vote bretfisher/examplevotingapp_vote
#### redis service
docker service create --network frontend --name redis redis:3.2
#### worker service
docker service create --network frontend --network backend --name worker bretfisher/examplevotingapp_worker
#### db service
docker service create --network backend --mount type=volume,source=db-data,target=/var/lib/postgresql/data -e POSTGRES_HOST_AUTH_METHOD=trust --name psql postgres:9.4
#### result service
docker service create --network frontend --name result -p 5001:80 bretfisher/examplevotingapp_result
