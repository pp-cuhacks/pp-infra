# pp-infra
Infrastructure stack containing Dockerfile to host pp-cuhacks

## Getting started
SSH into EC2 instance and run:
```
sudo yum install git -y
git clone https://github.com/pp-cuhacks/pp-infra.git
cd pp-infra
./start.sh your-container-name
```

If you see the following, you are inside the container.
```
[root@docker-############ /]$
```

To exit the container, type:
```
[root@docker-############ /]$ exit
```

To reconnect to the container, type:
```
ec2 $ ./connect.sh your-container-name
```

To stop/terminate container, type:
```
ec2 $ ./stop.sh your-container-name
ec2 $ ./terminate.sh your-container-name
```