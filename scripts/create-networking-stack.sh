#!/bin/sh

SCRIPTS_DIR=`dirname $0`
source "$SCRIPTS_DIR/isolate-arguments.sh"

echo "SCRIPTS_DIR: $SCRIPTS_DIR"
echo "STACK_SUFFIX: $TARGET_LOCATION-$TARGET_ENVIRONMENT"
echo "TARGET_LOCATION: $TARGET_LOCATION"
echo "TARGET_REGION: $TARGET_REGION"
echo "TARGET_ENVIRONMENT: $TARGET_ENVIRONMENT"

aws cloudformation create-stack --stack-name Networking-Stack-$TARGET_LOCATION-$TARGET_ENVIRONMENT --template-body file://templates/NetworkingStack.yaml  --profile default --region $TARGET_REGION
