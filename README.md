## Creating the sample nextjs app with the following command

`npx create-next-js wexa-ai-project`

choose the default options and then the sample next js app is created.

Later I pushed the file on the Github

I created a Dockerfile and upload the project in the github 

we need to create a classic token with the write  permission in the we will use GHCR to upload the images which will be build by the dockerfile.

we will use workflows the yaml file to control the automation task.

then we will launch and ec2 instance and install docker, minikube.

we will run following commands :)
 `sudo apt update`
 ```
 sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu
newgrp docker


curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
kubectl version --client
```
Login in the ghrc with the following format

`echo <GHRC_TOKEN> | docker login ghcr.io -u <PASSWORD> --password-stdin
`

Then we will pull the image from the package created in public GHRC

`docker pull ghcr.io/kavitha351/nextjs-dummy:latest`

then we can make a folder called k8s and create deployment.yaml and service.yaml. Copy the files of `/k8s`

Then we can run `kubectl apply -f k8s/`

to know whether the container are running successfully run the below command.

`kubectl get pods`

You will see the status as "Running"

To identity the IP address type the command `minikube ip`. You will see a IP address. copy the ip addresss <minikubeIP>:32000 in the `minikube ssh`, You will see the default page which was created!.

to make this app visible from your ec2 instance public ip you need to forward the port with the following command.

`kubectl port-forward svc/nextjs-service 8080:3000 --address=0.0.0.0
`
Then the page will be visible on http://<ec2-pub-ip>:8080

we will create secrets with the kuberetes command and use it while deploying the app with the deployment.yaml file and the service.yaml.

## Please note that I will still writing the readme file to explain my project I would require somemore time till 24 to 48 hours. thank you.
