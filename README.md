To start project use `compose.sh`

1. `./compose.sh clone` - clone project repo and create working folders
2. `./compose.sh start` - build images and run docker container
3. `./compose.sh stop` - stop docker container
4. `./compose.sh stop_and_rm_images` - remove images and stop docker container
5. `./compose.sh rebuild` - rebuild images

After cloned all project repo run `npm install` in each project folder and only after that use `./compose.sh start`

| Notice: to clone repo I use access by ssh, you may need to using the same github access method
