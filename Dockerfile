FROM ubuntu:18.04
EXPOSE 4000

# Install dependencies
RUN apt-get update
RUN apt-get install -y git curl sudo nano
RUN echo 'export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\u@docker-\h \W]\\$ \[$(tput sgr0)\]"' >> ~/.bashrc

# Install Terraform (latest release)
RUN sudo apt-get -y install gnupg lsb-core software-properties-common
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
RUN sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN sudo apt-get update && sudo apt-get install terraform

# Install AWS CLI
# unzip req'd for install
RUN sudo apt install -y unzip 
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install

# Install nodejs and update
RUN sudo apt-get install -y nodejs 
RUN sudo apt-get install -y npm 
RUN sudo npm cache clean -f; sudo npm install -g n; sudo n stable

# Create cronjob to build and deploy every 1 min
COPY build-and-deploy-pp-cuhacks /
RUN (crontab -l 2>/dev/null; echo "*/1 * * * * /build-and-deploy-pp-cuhacks >> /deploy.log") | crontab -