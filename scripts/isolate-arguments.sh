#!/bin/sh

# Supported Enviroments, Mainnet & Testnet
SUPPORTED_ENVIRONMENTS=("main" "test")

# Supported Regions
SUPPORTED_REGIONS=("sa-east-1" "us-west-1" "ap-southeast-1")

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
    -r|--region)
      TARGET_REGION=$2
      shift 1
      ;;
    -i|--image-tag)
      IMAGE_TAG=$2
      shift 1
      ;;
    -s|--stack-suffix)
      if [[ "$2" =~ ^-.* ]]; then STACK_SUFFIX=""; else STACK_SUFFIX="-$2"; fi
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
INVALID_TARGET_REGION=$(isUnsupportedValue $TARGET_REGION ${SUPPORTED_REGIONS[@]})
INVALID_IMAGE_TAG=$(isUnsupportedValue $IMAGE_TAG ${SUPPORTED_IMAGE_TAGS[@]})

if [ "$HELP" = true ] || [ "$INVALID_TARGET_REGION" = true ] || [ "$INVALID_IMAGE_TAG" = true ] || [ "$INVALID_TARGET_ENVIRONMENT" = true ] || [ -z "$NETWORK_STACK" ];
then
    echo "\nUsage: $0 [Options]"
    echo "\nOptions:"
    echo "\t-e, --environment\n\t\t(valid values: ${SUPPORTED_ENVIRONMENTS[@]})."
    echo "\t-r, --region\n\t\t(valid values: ${SUPPORTED_REGIONS[@]})."
    echo "\t-i, --image-tag\n\t\t(valid values: ${SUPPORTED_IMAGE_TAGS[@]})."
    echo "\t-s, --stack-suffix\n\t\t(Must contain only letters, numbers, dashes and start with an alpha character.)"
    echo "\t-n, --network-stack\n\t\t(Must be the name an existing networking stack previously created in this region.)"
    exit
fi

case "$TARGET_ENVIRONMENT" in
  main)
    KEY_NAME="todo-supply-when-available"
    ;;
  test)
    KEY_NAME="ixo-bc-testnet"
    ;;
esac
