#!/bin/sh

SCRIPTS_DIR=`dirname $0`
source "$SCRIPTS_DIR/isolate-arguments.sh"

echo "SCRIPTS_DIR: $SCRIPTS_DIR"
echo "STACK_SUFFIX: $STACK_SUFFIX"
echo "TARGET_REGION: $TARGET_REGION"
echo "TARGET_ENVIRONMENT: $TARGET_ENVIRONMENT"
echo "IMAGE_TAG: $IMAGE_TAG"

aws cloudformation create-stack --stack-name Networking-Stack$STACK_SUFFIX-$TARGET_ENVIRONMENT --template-body file://templates/NetworkingStack.yaml  --profile default --region $TARGET_REGION
