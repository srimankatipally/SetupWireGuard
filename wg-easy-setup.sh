#!/usr/bin/env bash
set -euo pipefail

# 1. Update & upgrade
apt update && apt -y upgrade

# 2. Install prerequisites
apt install -y git curl

# 3. Install Docker (engine + CLI + Compose plugin)
curl -sSL https://get.docker.com | sh

# 4. Clone the repo (skip if already present)
if [ ! -d wg-easy ]; then
  git clone https://github.com/wg-easy/wg-easy.git
fi

# 5. Enter the directory
cd wg-easy

# 6. Write docker-compose.yml
cat > docker-compose.yml <<'EOF'
version: "3.8"

volumes:
  etc_wireguard:

services:
  wg-easy:
    image: ghcr.io/wg-easy/wg-easy:15
    container_name: wg-easy
    environment:
      INSECURE: "true"
      # PORT: "51821"
      # HOST: "0.0.0.0"
    volumes:
      - etc_wireguard:/etc/wireguard
      - /lib/modules:/lib/modules:ro
    ports:
      - "51820:51820/udp"
      - "51821:51821/tcp"
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
      # - NET_RAW # Uncomment if using Podman
    sysctls:
      - net.ipv4.ip_forward=1
      - net.ipv4.conf.all.src_valid_mark=1
      - net.ipv6.conf.all.disable_ipv6=0
      - net.ipv6.conf.all.forwarding=1
      - net.ipv6.conf.default.forwarding=1
    networks:
      wg:
        ipv4_address: 10.42.42.42
        ipv6_address: "fdcc:a94d:bcaf:61a3::2a"

networks:
  wg:
    driver: bridge
    enable_ipv6: true
    ipam:
      driver: default
      config:
        - subnet: 10.42.42.0/24
        - subnet: fdcc:a94d:bcaf:61a3::/64
EOF

# 7. Start the stack
docker compose up -d

echo "✅ wg-easy is up and running."
