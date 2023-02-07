#!/bin/bash
PATH="$HOME/.local/bin:$PATH"

GREEN='\033[0;32m'
NC='\033[0m' # No Color

function install_awscli () {
       curl -L "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
       unzip awscliv2.zip
       sudo ./aws/install
       rm awscliv2.zip
}

function install_brew(){
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

}

function install_nvim(){
  brew install neovim

}

function install_home-manager(){
  curl -L https://nixos.org/nix/install | sh
  . /home/mwdavisii/.nix-profile/etc/profile.d/nix.sh
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels
  nix-shell '<home-manager>' -A install
}


function install_kubectl(){
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x kubectl
	sudo mv kubectl /usr/local/bin/
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
	sudo mv /tmp/eksctl /usr/local/bin	
	curl -L https://istio.io/downloadIstio | sh -
	sudo mv istio*/bin/istioctl /usr/local/bin/
	brew install k9s
	brew install minikube
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
}

function install_terraform (){
	LATEST_URL=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|beta' | egrep 'linux.*amd64' |tail -1)
  	curl -L ${LATEST_URL} -o terraform.zip
	unzip terraform
	sudo mv terraform /usr/local/bin
	rm terraform.zip
}

function install_exa () {
        echo -e "${GREEN}Installing exa...${NC}"
        curl -L https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip -o exa.zip
        unzip exa.zip -d exa
        sudo mv exa/bin/exa /usr/local/bin/exa
        rm -rf exa
        rm exa.zip
        echo -e "${GREEN}Exa is installed.${NC}"
}

function install_python () { 
        echo -e "${GREEN}installing Pip and Env...${NC}"
        sudo add-apt-repository ppa:deadsnakes/ppa -y
        sudo apt update
        sudo apt install python3 python3-pip python3-venv libmysqlclient-dev -y
        echo -e "${GREEN}Pip and Env are installed.${NC}"
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

function install_go () {
        #install go
        VERSION=`curl -L https://golang.org/VERSION?m=text`
        curl -L https://go.dev/dl/$VERSION.linux-amd64.tar.gz -o go.tar.gz
        tar -xvf go.tar.gz
        sudo mv go /usr/local/
        rm go.tar.gz
}

function install_rust () {
        sh -c "$(curl -fsSL https://sh.rustup.rs)" "" -y
}


function install_dotnet_core () {
        #install .netcore
        curl --proto "https" --tlsv1.2 -sSf https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh | bash
}


function install_configure_oh () {
        #install and configure oh-my-zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

        #install plugins
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

        #change default shell
        chsh -s $(which zsh)
	git clone https://github.com/powerline/fonts.git --depth=1
	./fonts/install.sh
	rm -rf fonts
	
        # get my favorite .zshrc
        mv ~/.zshrc ~/.zshrc.default
        curl -L https://gist.githubusercontent.com/mwdavisii/ebfb669b55a6bfa2ded387c88548c297/raw/afda221afa092c32cc53245cf22fdd22d6f5262b/.zshrc -o ~/.zshrc
        source ~/.zshrc
	
        #launch zsh
        zsh
}

function install_all () {
	install_qt_vdk
        install_dotnet_core
        install_exa
        install_go
        install_rust
        install_configure_oh
	install_awscli
	install_terraform
	install_docker
	install_kubectl
}

while true; do
        echo -e "${GREEN} "
        echo -e "${GREEN}This script will install recommended software dev tools and configure your zsh shell like Mike's.${NC}"
        read -p "Do you wish to continue? [y/n]" yn
        case $yn in
        [Yy]* ) 
                exec_apt_update_install; break;;
        [Nn]* ) break;;
        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
    esac
done

while true; do
        echo -e "${GREEN} "
        read -p "Install all tools? If you choose no, you will be able to select what gets installed. [y/n]" mf
        case $mf in
        [Yy]* ) 
                install_all; break;;
        [Nn]* ) 
                while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install EXA? [y/n]" yn
                case $yn in
                        [Yy]* ) 
                                install_exa; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done

                while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install Python? [y/n]" yn
                case $yn in
                        [Yy]* ) 
                        install_python; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done
		
		while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install the AWS CLI? [y/n]" yn
                case $yn in
                        [Yy]* ) 
                        install_awscli; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done
		
		while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install the terraform cli? [y/n]" yn
                case $yn in
                        [Yy]* ) 
                        install_terraform; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done

                while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install QT and Compile VDK? [y/n]" yn
                case $yn in
                        [Yy]* ) 
                        install_qt_vdk; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done

                while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install the latest version of GO? [y/n]" yn
                case $yn in
                        [Yy]* )
                                install_go; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done
		
		while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install the docker engine? [y/n]" yn
                case $yn in
                        [Yy]* )
                                install_docker; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done
		
                while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install the latest version of Rust? [y/n]" yn
                case $yn in
                        [Yy]* )
                        install_rust; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done

                while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install the latest version of Dotnet Core? [y/n]" yn
                case $yn in
                        [Yy]* )
                        install_dotnet_core; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done;
		
		while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install oh-my-zsh and the zsh shell? [y/n]" yn
                case $yn in
                        [Yy]* )
                        install_configure_oh; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done;

		while true; do
                echo -e "${GREEN} "
                read -p "Do you wish to install minikube, k8s, and istio [y/n]" yn
                case $yn in
                        [Yy]* )
                        install_kubectl; break;;
                        [Nn]* ) break;;
                        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
                esac
                done;

        break;;
        * ) echo -e "${GREEN}Please answer yes or no.${NC}";;
    esac
done

