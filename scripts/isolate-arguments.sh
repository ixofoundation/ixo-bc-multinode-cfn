#!/bin/sh

# Supported Enviroments, Mainnet & Testnet
SUPPORTED_ENVIRONMENTS=("main" "test")

# Supported Locations
SUPPORTED_LOCATIONS=("brazil" "california" "ohio" "paris" "mumbai" "singapore" "sydney" "ireland")

# Supported Docker image Tags
SUPPORTED_IMAGE_TAGS=("master" "dev")

isUnsupportedValue(){
   local value=$1
   shift
   local supportedValues=$@

   for supportedValue in $supportedValues;
   do
      if [ "$value" == "$supportedValue" ];
      then
        echo false
        return
      fi
   done
   echo true
   return
}

while (( "$#" )); do
  case "$1" in
    -h|--help)
      HELP=true
      shift 1
      ;;
    -e|--environment)
      TARGET_ENVIRONMENT=$2
      shift 1
      ;;
    -l|--location)
      TARGET_LOCATION=$2
      shift 1
      ;;
    -i|--image-tag)
      IMAGE_TAG=$2
      shift 1
      ;;
    -n|--network-stack)
      NETWORK_STACK=$2
      shift 1
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

INVALID_TARGET_ENVIRONMENT=$(isUnsupportedValue $TARGET_ENVIRONMENT ${SUPPORTED_ENVIRONMENTS[@]})
INVALID_TARGET_LOCATION=$(isUnsupportedValue $TARGET_LOCATION ${SUPPORTED_LOCATIONS[@]})
INVALID_IMAGE_TAG=$(isUnsupportedValue $IMAGE_TAG ${SUPPORTED_IMAGE_TAGS[@]})

if [ "$HELP" = true ] || [ "$INVALID_TARGET_ENVIRONMENT" = true ] || [ "$INVALID_TARGET_LOCATION" = true ] || [ "$INVALID_IMAGE_TAG" = true ] || [ -z "$NETWORK_STACK" ];
then
    echo "\nUsage: $0 [Options]"
    echo "\nOptions:"
    echo "\t-e, --environment\n\t\t(valid values: ${SUPPORTED_ENVIRONMENTS[@]})."
    echo "\t-l, --location\n\t\t(valid values: ${SUPPORTED_LOCATIONS[@]})."
    echo "\t-i, --image-tag\n\t\t(valid values: ${SUPPORTED_IMAGE_TAGS[@]})."
    echo "\t-n, --network-stack\n\t\t(Must be the name an existing networking stack previously created in this region.)"
    exit
fi

case "$TARGET_LOCATION" in
  brazil)
    TARGET_REGION="sa-east-1"
    ;;
  california)
    TARGET_REGION="us-west-1"
    ;;
  ohio)
    TARGET_REGION="us-east-2"
    ;;
  paris)
    TARGET_REGION="eu-west-3"
    ;;
  mumbai)
    TARGET_REGION="ap-south-1"
    ;;
  singapore)
    TARGET_REGION="ap-southeast-1"
    ;;
  sydney)
    TARGET_REGION="ap-southeast-2"
    ;;
  ireland)
    TARGET_REGION="eu-west-1"
    ;;
esac

case "$TARGET_ENVIRONMENT" in
  main)
    KEY_NAME="ixo-bc-mainnet"
    ;;
  test)
    KEY_NAME="ixo-bc-testnet"
    ;;
esac
