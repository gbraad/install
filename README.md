# LibreRead Manual Setup
In order to setup LibreRead, you must have SSH access to a 64-bit Linux server.

## Hardware Requirements
* Modern single core CPU, dual core recommended
* 1 GB RAM minimum
* 64 bit Linux compatible with Docker

## Software Requirements
* Debian 9
* ElasticSearch 5.0
* Redis 3.2

## Create New Cloud Server
Sign up for [Linode](https://www.linode.com/?r=2c9c375722ccc8de20545189f54af1457e34a0e7), update billing info, then create your new cloud server.

* Add Linode 2048
* Select a Location of your choice. Probably the one that is nearer to you.
* Now that the linode has been added. Go to Dashboard and click "Deploy an Image".
* Choose Debian 9, then select 512MB swap image and enter the root password (This password will be used when you login via SSH)
* Once the "Host Job Queue" is done. You can click "Boot" to boot your linode.
* Once the server is running, go to "Remote Access" and copy the SSH Access. Eg: ssh root@XXX.XXX.XXX.XXX
* Paste it in your local terminal and enter "yes" to add it to the known hosts. Then you need to enter the password.

Now you have logged in to your linode. Please follow the below installation instructions for installing LibreRead.

## Install
* `apt-get update`
* `apt-get install -y git-core`
* `git clone https://github.com/LibreRead/install.git /var/libreread`
* `cd /var/libreread`
* `source install.sh`

You will be prompted for Domain and SMTP settings. Once you have entered those prompts, the script will install and start the server at **http://ip_address:8080**

## Domain setup with NGINX and Let's Encrypt
Now that the server is ready, we are going to setup the domain. Point to [Linode Docs](https://www.linode.com/docs/networking/dns/dns-manager-overview/) or your hosting providers documentation for dns settings. **This might take up to 24 hours for the change to take effect.**

Once the dns settings is ready, run the below command from the project root directory for setting up your NGINX reverse proxy with Let's Encrypt SSL certificates.

`source domain.sh`

Once this command is finished, you could point to your domain address, eg: https://example.com

## Enable full-text search with ElasticSearch
By default, LibreRead will provide a simple metadata search. But if you need full-text search feature to search across all the book content. You will need to setup Docker and ElasticSearch. Run the command shown below from the project root directory to do that.

`source docker_es.sh`
