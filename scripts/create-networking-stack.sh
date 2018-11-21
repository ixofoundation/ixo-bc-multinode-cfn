#!/bin/sh

SCRIPTS_DIR=`dirname $0`
source "$SCRIPTS_DIR/isolate-arguments.sh"

echo "SCRIPTS_DIR: $SCRIPTS_DIR"
echo "STACK_SUFFIX: $STACK_SUFFIX"
echo "TARGET_REGION: $TARGET_REGION"
echo "IMAGE_TAG: $IMAGE_TAG"

# aws cloudformation create-stack --stack-name Ixo-Networking-Stack$STACK_SUFFIX --template-body file://templates/IxoNetworkingStack.yaml  --profile trustlab.cli --region $TARGET_REGION
