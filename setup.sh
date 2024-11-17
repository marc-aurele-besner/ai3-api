sudo apt update

sudo apt install tmux -y

tmux -V

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo systemctl enable docker

sudo systemctl start docker

sudo usermod -aG docker $USER

docker --version

sudo apt update

sudo apt install nodejs npm -y

sudo npm install -g yarn

yarn --version

yarn install

tmux new-session -d -s ai3-api 'yarn start' \; setw -g mouse on

tmux ls

tmux attach -t ai3-api \; setw -g mouse on