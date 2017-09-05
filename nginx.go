package main

import (
	"io/ioutil"
	"os"
)

func main() {
	conf := "server {\n    listen 80 default_server;\n    listen [::]:80 default_server;\n    server_name " + os.Args[1:][0] + ";\n    return 301 https://$server_name$request_uri;\n}\n\nserver {\n    listen 443 ssl;\n    listen [::]:443 ssl;\n    server_name " + os.Args[1:][0] + ";\n\n    include snippets/ssl-libreread.org.conf;\n    include snippets/ssl-params.conf;\n\n    location / {\n        proxy_set_header X-Real-IP $remote_addr;\n        proxy_set_header X-Forwarded-For $remote_addr;\n        proxy_set_header Host $host;\n        proxy_pass http://127.0.0.1:8080;\n    }\n}"
	data := []byte(conf)
	err := ioutil.WriteFile("nginx.conf", data, 0755)
	CheckError(err)

	sslConf := "ssl_certificate /etc/letsencrypt/live/" + os.Args[1:][0] + "/fullchain.pem;\nssl_certificate_key /etc/letsencrypt/live/" + os.Args[1:][0] + "/privkey.pem;"
	data = []byte(sslConf)
	err = ioutil.WriteFile("ssl-libreread.org.conf", data, 0755)
}

func CheckError(err error) {
	if err != nil {
		panic(err)
	}
}
