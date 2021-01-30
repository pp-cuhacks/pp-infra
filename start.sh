if [[ -z $(which docker) ]]; then
    echo Docker not installed.
    echo Installing Docker... 
    echo "
    "
    sudo amazon-linux-extras install docker
    echo "
    "
    echo Docker installed.
fi

echo Starting docker...
sudo service docker start

IMAGE_NAME="${1:-workspace}"    # Use input variable or default to 'workspace'
echo Building docker image \"${IMAGE_NAME}\"
sudo docker build -t ${IMAGE_NAME} .

echo

echo Starting image ${IMAGE_NAME}...
echo .....To quit, type exit.....
echo .....To re-connect later, type ./connect.sh $IMAGE_NAME.....
echo .....To stop or terminate, type ./stop.sh  $IMAGE_NAME or ./terminate $IMAGE_NAME.....

echo
echo

# Run docker image if the image isn't already running
if [[ -z $(sudo docker container ls | grep ${IMAGE_NAME}) ]]
then
    echo Image ID:
    sudo docker run --name ${IMAGE_NAME} -p 80:3000 -dt ${IMAGE_NAME} 
fi
echo
echo

echo "sudo docker exec -it \${1} /bin/bash" > connect.sh
echo "sudo docker stop \${1}" > stop.sh
echo "./stop.sh \${1}; sudo docker rm \${1}" > terminate.sh
chmod +x connect.sh stop.sh terminate.sh

sudo docker exec -it ${IMAGE_NAME} /bin/bash
