sudo apt update

sudo apt install tmux -y

tmux -V

sudo apt update
sudo apt install nodejs npm -y

sudo npm install -g yarn

yarn --version

yarn install

tmux new-session -d -s ai3-api 'yarn start' \; setw -g mouse on