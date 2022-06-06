# CI/CD

CI/CD scripts and files

## Structure

	├── README.md
	├── build.sh         # Entry point for build
	├── goldimages       # Docker files for golden images
	│   └── centos7 
	└── runner.sh        # Runner build script

## Build golden images

	sudo podman build -t centos7 -f goldimages/centos7

## Run build

	./build.sh centos7 droopp test1 master 0.1.0 rpm

	./build.sh ubuntu20 droopp test1 master 0.1.0 deb

# Private repositories (DEB + RPM)

## DEB

## Create dirs

	mkdir deb-master 
	mkdir deb-develop

	sudo chown -R buildbot:www-data deb-master deb-develop

### Create struct in deb dir

	deb-{master, develop}/create_repo.sh

###  Update repo

	deb-{master, develop}/update_repo.sh

###  Add private repo to target host

	echo "deb [arch=amd64] http://134.122.23.140/deb-{master,develop}/ drop main" | sudo tee /etc/apt/sources.list.d/drop.list

	sudo apt-get update --allow-insecure-repositories

	sudo apt-get -t drop install <Package>


## RPM

###  Add private repo to target host

	echo '[drop]
	name=drop
	baseurl=http://134.122.23.140/rpm-{master, develop}/
	gpgcheck=0
	enabled=1
	metadata_expire=1m
	http_caching=packages
	mirrorlist_expire=1m
	' > /etc/yum.repos.d/drop.repo


# BuildBot 

## Create master 

	./venv/bin/buildbot create-master master

## Create workers 

	create-worker centos7 localhost centos7 pass

	create-worker ubuntu20 localhost ubuntu20 pass

