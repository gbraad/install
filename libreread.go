package main

import (
	"io/ioutil"
	"os"
)

func main() {
	conf := "[unit]\n" +
		"Description=LibreRead systemd service\n\n" +
		"[Service]\n" +
		"User=root\n" +
		"Group=root\n" +
		"Environment='LIBREREAD_DOMAIN_ADDRESS=https://" + os.Args[1:][0] + "'\n" +
		"Environment='LIBREREAD_SMTP_SERVER=" + os.Args[1:][1] + "'\n" +
		"Environment='LIBREREAD_SMTP_PORT=" + os.Args[1:][2] + "'\n" +
		"Environment='LIBREREAD_SMTP_ADDRESS=" + os.Args[1:][3] + "'\n" +
		"Environment='LIBREREAD_SMTP_PASSWORD=" + os.Args[1:][4] + "'\n" +
		"Environment='ES_PATH=http://localhost:9200'\n" +
		"WorkingDirectory=/var/libreread\n" +
		"ExecStart=/bin/bash -c './server'\n\n" +
		"[Install]\n" +
		"WantedBy=multi-user.target"

	data := []byte(conf)
	err := ioutil.WriteFile("libreread.service", data, 0755)
	CheckError(err)
}

func CheckError(err error) {
	if err != nil {
		panic(err)
	}
}
