sudo docker run --rm -it -v $(pwd):/code --privileged --entrypoint make alphamj/os-contest:v7.6 -C /code sdcard
sudo chown $(whoami) sdcard.img