#!/usr/bin/env bash

set -euo pipefail

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
BOLD="\033[1m"
RESET="\033[0m"

WORKDIR="infra"

if [[ ! -d "$WORKDIR" ]]; then
  echo -e "${RED}Error: directory '${WORKDIR}' not found.${RESET}"
  exit 1
fi

echo -e "${CYAN}${BOLD}=== Terraform Deployment ===${RESET}"

AWS_REGION="eu-west-1"
APP_NAME="myapp"
APP_IMAGE=""
CPU="256"
MEMORY="512"
CONTAINER_PORT="80"
HOST_PORT="80"

read -p "$(echo -e ${YELLOW}"AWS Region [${AWS_REGION}]: "${RESET})" input
AWS_REGION=${input:-$AWS_REGION}

read -p "$(echo -e ${YELLOW}"Application Name [${APP_NAME}]: "${RESET})" input
APP_NAME=${input:-$APP_NAME}

read -p "$(echo -e ${YELLOW}"Application Image (required): "${RESET})" input
APP_IMAGE=${input:-$APP_IMAGE}
if [[ -z "$APP_IMAGE" ]]; then
  echo -e "${RED}Error: Application Image cannot be empty.${RESET}"
  exit 1
fi

read -p "$(echo -e ${YELLOW}"CPU [${CPU}]: "${RESET})" input
CPU=${input:-$CPU}

read -p "$(echo -e ${YELLOW}"Memory [${MEMORY}]: "${RESET})" input
MEMORY=${input:-$MEMORY}

read -p "$(echo -e ${YELLOW}"Container Port [${CONTAINER_PORT}]: "${RESET})" input
CONTAINER_PORT=${input:-$CONTAINER_PORT}

read -p "$(echo -e ${YELLOW}"Host Port [${HOST_PORT}]: "${RESET})" input
HOST_PORT=${input:-$HOST_PORT}

cd "$WORKDIR"

echo -e "${BLUE}→ Initializing Terraform...${RESET}"
terraform init -input=false

echo -e "${BLUE}→ Generating Terraform plan...${RESET}"
terraform plan \
  -var="aws_region=$AWS_REGION" \
  -var="app_name=$APP_NAME" \
  -var="app_image=$APP_IMAGE" \
  -var="cpu=$CPU" \
  -var="memory=$MEMORY" \
  -var="container_port=$CONTAINER_PORT" \
  -var="host_port=$HOST_PORT"

read -p "$(echo -e ${GREEN}"Proceed with apply? [y/N]: "${RESET})" confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo -e "${GREEN}→ Applying Terraform configuration...${RESET}"
  terraform apply \
    -var="aws_region=$AWS_REGION" \
    -var="app_name=$APP_NAME" \
    -var="app_image=$APP_IMAGE" \
    -var="cpu=$CPU" \
    -var="memory=$MEMORY" \
    -var="container_port=$CONTAINER_PORT" \
    -var="host_port=$HOST_PORT"
else
  echo -e "${YELLOW}Apply canceled.${RESET}"
fi
