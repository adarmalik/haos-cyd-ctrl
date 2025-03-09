#!/bin/bash

if ! command -v esphome 2>&1 >/dev/null
then
    echo "esphome could not be found, did you forget to source your venv?"
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

# Initialize variables
CMD="config"
YAML="haos-cyd-controller-int.yaml"
PROD=false

# Parse arguments in any order
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -i|--integration)
            YAML=haos-cyd-controller-int.yaml
            shift
            ;;
        -7|--7inch)
            YAML=haos-cyd-controller-7z.yaml
            shift
            ;;
        -p|--prod)
            YAML=haos-cyd-controller-prod.yaml
            PROD=true
            shift
            ;;
        -s|--sdl)
            YAML=haos-cyd-controller-sdl.yaml
            shift
            ;;
        *)  # Any other argument is assumed to be the command
            CMD="$1"
            shift
            ;;
    esac
done

if $PROD; then
    if [[ "$CMD" == "upload" || "$CMD" == "run" ]]; then
        read -p "Are you sure you want to proceed to upload to production? (y/n): " confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            echo "Proceeding ..."
        else
            echo "Operation canceled."
            exit 1
        fi
    fi
fi

esphome $CMD $YAML