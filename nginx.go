package main

import (
	"io/ioutil"
	"os"
)

func main() {
	conf := "worker_processes 1;\n\nevents { worker_connections 1024; }\n\nhttp {\n  server {\n    listen 80 default_server;\n    listen [::]:80 default_server;\n    server_name " + os.Args[1:][0] + ";\n    return 301 http://$server_name$request_uri;\n  }\n  server {\n    listen 443 ssl;\n    listen [::]:443 ssl;\n    root /var/www/html;\n    location / {\n      proxy_set_header X-Real-IP $remote_addr;\n      proxy_set_header X-Forwarded-For $remote_addr;\n      proxy_set_header Host $host;\n      proxy_pass http://127.0.0.1:8080;\n    }\n    location ~ /.well-known {\n      root /var/libreread/.well-known;\n      allow all;\n    }\n  }\n}"
	data := []byte(conf)
	err := ioutil.WriteFile("nginx.conf", data, 0755)
	CheckError(err)
}

func CheckError(err error) {
	if err != nil {
		panic(err)
	}
}
