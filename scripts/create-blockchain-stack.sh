#!/bin/sh

SCRIPTS_DIR=`dirname $0`
source "$SCRIPTS_DIR/isolate-arguments.sh"

echo "SCRIPTS_DIR: $SCRIPTS_DIR"
echo "STACK_SUFFIX: $TARGET_LOCATION-$TARGET_ENVIRONMENT"
echo "TARGET_LOCATION: $TARGET_LOCATION"
echo "TARGET_REGION: $TARGET_REGION"
echo "TARGET_ENVIRONMENT: $TARGET_ENVIRONMENT"
echo "IMAGE_TAG: $IMAGE_TAG"
echo "NETWORK_STACK: $NETWORK_STACK"
echo "KEY_NAME: $KEY_NAME"

sed -i '' "s|%%TargetEnvironment%%|$TARGET_ENVIRONMENT|" "$SCRIPTS_DIR/../parameters/BlockchainStack.parameters.json"
sed -i '' "s|%%ImageTag%%|$IMAGE_TAG|" "$SCRIPTS_DIR/../parameters/BlockchainStack.parameters.json"
sed -i '' "s|%%NetworkStackName%%|$NETWORK_STACK|" "$SCRIPTS_DIR/../parameters/BlockchainStack.parameters.json"
sed -i '' "s|%%KeyName%%|$KEY_NAME|" "$SCRIPTS_DIR/../parameters/BlockchainStack.parameters.json"

aws cloudformation create-stack --stack-name Blockchain-Stack-$TARGET_LOCATION-$TARGET_ENVIRONMENT --template-body file://templates/BlockchainStack.yaml  --parameters file://parameters/BlockchainStack.parameters.json --profile default --region $TARGET_REGION

git checkout "$SCRIPTS_DIR/../parameters/BlockchainStack.parameters.json"
