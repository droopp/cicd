# CI/CD

CI/CD scripts and files

## Structure

	├── README.md
	├── RPMS             # RPM packages
	├── build.sh         # Entry point for build
	├── goldimages       # Docker files for golden images
	│   └── centos7 
	└── runner.sh        # Runner build script

## Build golden images

	sudo podman build -t centos7 -f goldimages/centos7

## Run build

	./build.sh centos7 droopp test1 master 0.1.0 rpm
