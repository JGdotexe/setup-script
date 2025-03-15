#File for docker installations on fedora
PINK='\033[38;5;206m'

function highlight_pink {
    echo -e "${PINK}$1"
}

sudo dnf install dnf-plugins-core && sudo dnf config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo" && 
    sudo systemctl enable --now docker && sudo docker run hello-world || highlight_pink "Pobably something went wrong"

