teamcity
========

# Run new installation:
`docker run -t -i -p 8111:8111 smalllark/teamcity-server`

# Run existing installation:
`docker run -t -i -p 8111:8111 -v /var/lib/teamcity:/var/lib/teamcity smalllark/teamcity-server`

# Run as service:
`docker run -p 8111:8111 -v /var/lib/teamcity:/var/lib/teamcity --name teamcity-server --restart=always smalllark/teamcity-server`

# Nginx config:

```
upstream docker-teamcity-server {
  server localhost:8111;
}

server {
  listen 80;
  server_name           your-domain.com;

  access_log            /var/log/nginx/your-domain/access.log;
  error_log             /var/log/nginx/your-domain/error.log;

  proxy_set_header Host       $http_host;   # required for docker client's sake
  proxy_set_header X-Real-IP  $remote_addr; # pass on real client's IP

  client_max_body_size 0; # disable any limits to avoid HTTP 413 for large image uploads

  # required to avoid HTTP 411: see Issue #1486 (https://github.com/dotcloud/docker/issues/1486)
  chunked_transfer_encoding on;

  location / {
    proxy_pass http://docker-teamcity-server;
  }

}
```
