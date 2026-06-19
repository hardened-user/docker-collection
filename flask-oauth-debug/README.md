# Flask OAuth Debug

```yaml
$ cat docker-compose.yml
---
services:
  flask:
    image: "hardeneduser/flask-oauth-debug"
    container_name: "flask-oauth-debug"
    restart: unless-stopped
    environment:
      TZ: "Europe/Moscow"
      # direct environment
      KEYCLOAK_REALM_URL: https://example.com/auth/realms/master
      KEYCLOAK_CLIENT_SCOPE: openid profile email
      OAUTH_CLIENT_ID: flask
      OAUTH_CLIENT_SECRET: '****'
      # via .env file
      #KEYCLOAK_REALM_URL: ${KEYCLOAK_REALM_URL}
      #OAUTH_CLIENT_ID: ${OAUTH_CLIENT_ID}
      #OAUTH_CLIENT_SECRET: ${OAUTH_CLIENT_SECRET}
      #
    ports:
      - "0.0.0.0:8080:8080"
```

```bash
$ docker compose up
```
