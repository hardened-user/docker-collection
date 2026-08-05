# Tinyproxy Docker Image

Build
```
$ ./build.sh
```

Docker Compose Example
```yaml
---
services:
  tinyproxy:
    image: "hardeneduser/tinyproxy:latest"
    container_name: "tinyproxy"
    restart: unless-stopped
    environment:
      TINYPROXY_ALLOW: "0.0.0.0/0, ::/0"
      TINYPROXY_BASICAUTH_USER: "user"
      TINYPROXY_BASICAUTH_PASS: "pass"
    network_mode: host
```

```bash
$ docker compose up -d
```
