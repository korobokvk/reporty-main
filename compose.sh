#!/usr/bin/env bash
set -e

REPOSNAME=("data-generator" "reporty-auth-service" "reporty-client-front-end" "reporty-db-provider" "reporty-client-service-api" "reporty-client-service")
IMAGES_FOR_DEV=("data-generator" "reporty-auth-service" "reporty-db-provider" "reporty-client-service-api" "reporty-client-service")

function clone() {
  for i in "${REPOSNAME[@]}"; 
  do
    DIR="main/$i"
    if [ -d "$DIR" ]; then
      echo "$i is exist in ${DIR}"
    else
      echo "====== Cloning git@github.com:korobokvk/$i.git in ${DIR} ======"
      git clone "git@github.com:korobokvk/$i.git" "main/$i"
  fi
  done
}

function run_image_if_not_exist() {
  for i in "${IMAGES_FOR_DEV[@]}";
    do
       if [[ "$(docker images -q $i 2> /dev/null)" == "" ]]; then
          echo "====== Build image for $i ======"
          cd main/"$i" && docker build -t "$i" . && cd ../..
        else
          echo "====== "$i" image is available starting comtainers ======"
    fi
    done
}

function run() {
  case $1 in
  "start")
    run_image_if_not_exist
    echo "====== Compose UP ======"
    docker-compose up
    ;;
  "stop")
    echo "====== Compose Stop ======"
    docker-compose down
    ;;
  "stop_and_rm_images")
    echo "====== Compose AND remove images ======"
    docker-compose down --rmi all
    ;;
  "clone")
    clone
    ;;
  "rebuild")
    echo "====== REBUILDING ======"
    rdocker_compose build
  esac
}

run "$@"