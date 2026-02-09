
umount /var/lib/nvidia || true



## GH
sudo mkdir -p -m 755 /etc/apt/keyrings
out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg
cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Cuda

curl -o /tmp/cuda-keyring_1.1-1_all.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i /tmp/cuda-keyring_1.1-1_all.deb

# Vulkan

wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo tee /etc/apt/trusted.gpg.d/lunarg.asc
wget -qO /etc/apt/sources.list.d/lunarg-vulkan-noble.list http://packages.lunarg.com/vulkan/lunarg-vulkan-noble.list

# Tailscale

curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/noble.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

### Install
apt-get update

apt-get install -y gh tailscale htop vim file git-lfs fdisk kmod pciutils gdb strace \
  vulkan-sdk \
  cuda-toolkit-12 \
  clang build-essential pkg-config libssl-dev cmake \
  libx11-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev \
  libxmlsec1-dev uuid-dev libeigen3-dev libfreetype6-dev libgtk-4-dev \
  libavutil-dev libavformat-dev libswscale-dev  \
  ninja-build \
  llvm


curl -o /tmp/nvidia.sh https://us.download.nvidia.com/XFree86/Linux-x86_64/535.274.02/NVIDIA-Linux-x86_64-535.274.02.run
bash /tmp/nvidia.sh --no-kernel-module --accept-license --no-systemd --no-check-for-alternate-installs --no-recursion --ui=none --no-questions

#nohup tailscaled

rm -rf /var/lib/apt/lists/*

apt clean
