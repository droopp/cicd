# CI/CD

CI/CD scripts and files

## Structure

	├── README.md
	├── rpm              # RPM packages
 	├── deb              # DEB packages
	├── build.sh         # Entry point for build
	├── goldimages       # Docker files for golden images
	│   └── centos7 
	└── runner.sh        # Runner build script

## Build golden images

	sudo podman build -t centos7 -f goldimages/centos7

## Run build

	./build.sh centos7 droopp test1 master 0.1.0 rpm


# Private repositories (DEB + RPM)

## DEB

### Create struct in deb dir

	deb/create_repo.sh

###  Update repo

	deb/update_repo.sh

###  Add private repo to target host

	echo "deb [arch=amd64] http://134.122.23.140/deb/ drop main" | sudo tee /etc/apt/sources.list.d/drop.list

	sudo apt-get update --allow-insecure-repositories

	sudo apt-get -t drop install <Package>


## RPM

###  Add private repo to target host

	echo '[drop-master]
	name=drop
	baseurl=http://134.122.23.140/deb/
	gpgcheck=0
	enabled=1
	metadata_expire=1m
	http_caching=packages
	mirrorlist_expire=1m
	' > /etc/yum.repos.d/drop.repo

