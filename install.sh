#!/bin/bash
PATH="$HOME/.local/bin:$PATH"

GREEN='\033[0;32m'
NC='\033[0m' # No Color


function exec_apt_update_install () {
        echo -e "${GREEN}Updating apt...${NC}"
        sudo apt update -y
        echo -e "${GREEN}Upgrading your stuff...${NC}"
        sudo apt upgrade -y
        echo -e "${GREEN}Installing packages and dependencies...${NC}"
        sudo apt install  -y
        echo -e "${GREEN}Packages and dependencies installed.${NC}"
        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
        echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
        sudo apt-get -y update
        sudo apt-get -y install sublime-text xclip software-properties-common apt-transport-https libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
        sudo apt-get -y install build-essential procps curl file git 
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        #fonts
        git clone https://github.com/powerline/fonts.git --depth=1
        ./fonts/install.sh
        rm -rf fonts

}

function install_awscli () {
       curl -L "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
       unzip awscliv2.zip
       sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli
       rm -rf aws
       rm awscliv2.zip
}

function install_kubectl(){
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x kubectl
	sudo mv kubectl /usr/local/bin/
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
	sudo mv /tmp/eksctl /usr/local/bin	
	curl -L https://istio.io/downloadIstio | sh -
	sudo mv istio*/bin/istioctl /usr/local/bin/
    rm -rf istio*
}

function install_docker () {
	#add deps
	sudo apt-get install ca-certificates gnupg lsb-release
	sudo mkdir -p /etc/apt/keyrings
 	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	  	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
 	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose docker-compose-plugin -y 
  sudo chmod 666 /var/run/docker.sock
}

function install_qt_vdk () {
        install_python
        echo -e "${GREEN}Installing aqt and Qt...${NC}"
        #install qt via aqt
        pip install aqtinstall
        mkdir -p qt
        cd qt
        aqt install-qt linux desktop 5.12.3 gcc_64 -m all
        cd ~
        echo -e "${GREEN}Aqt abd Qt installation complete"
        #get vtk
        echo -e "${GREEN}Setting up VTK...${NC}"
        curl -L https://www.vtk.org/files/release/8.2/VTK-8.2.0.tar.gz -o VTK-8.2.0.tar.gz
        curl -L https://www.vtk.org/files/release/8.2/VTKData-8.2.0.tar.gz -o VTKData-8.2.0.tar.gz
        tar -xvf VTK-8.2.0.tar.gz
        tar -xvf VTKData-8.2.0.tar.gz
        rm VTKData-8.2.0.tar.gz VTK-8.2.0.tar.gz
        #Set the C & C++ compiler to v9
        echo -e "${GREEN}Changing the default g++ and gcc compilers to version 9...${NC}"
        sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 1
        sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 1
        mkdir -p VTK-8.2.0/build
	cd VTK-8.2.0/build
        cmake .. -G Ninja -DVTK_Group_Qt=ON -DQt5_DIR=$HOME/qt/5.12.3/gcc_64/lib/cmake/Qt5 -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release
        echo -e "${GREEN}Compiling VTK...${NC}"
	ninja -j4
        echo -e "${GREEN}Installing VTK...${NC}"
        sudo ninja install
        echo -e "${GREEN}VTK installation complete.${NC}"
}

function install_home_manager(){
  mkdir -p ~/.config/nix
  echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
  curl -L https://nixos.org/nix/install | sh
  . /home/mwdavisii/.nix-profile/etc/profile.d/nix.sh
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels
  #remove the freshly installed files so home-manager can replace them.
  rm ~/.bashrc ~/.nix-channels
  nix run . switch -- --flake . --impure
}

exec_apt_update_install
install_awscli
install_docker
install_kubectl
install_home_manager
