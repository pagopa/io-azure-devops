#!/bin/bash

#
# bash .utils/terraform_run_all.sh init local
# bash .utils/terraform_run_all.sh init docker
#

# 'set -e' tells the shell to exit if any of the foreground command fails,
# i.e. exits with a non-zero status.
set -eu

ACTION="$1"
MODE="$2"
pids=()

array=(
    'azure-devops::iac'
    'azure-devops::messages'
    'azure-devops::payments'
    'azure-devops::profile'
)

function rm_terraform {
    find . \( -iname ".terraform*" ! -iname ".terraform-docs*" ! -iname ".terraform-version" \) -print0 | xargs -0 rm -rf 
}

echo "[INFO] 🪚 Delete all .terraform folders"
rm_terraform

echo "[INFO] 🏁 Init all terraform repos"
for index in "${array[@]}" ; do
    FOLDER="${index%%::*}"
    COMMAND="${index##*::}"
    pushd "$(pwd)/${FOLDER}"
        echo "$FOLDER - $COMMAND"
        echo "🔬 folder: $(pwd) in under terraform: $ACTION action $MODE mode"
        sh terraform.sh "$ACTION" "$COMMAND" &

        pids+=($!)
    popd
done

# Wait for each specific process to terminate.
# Instead of this loop, a single call to 'wait' would wait for all the jobs
# to terminate, but it would not give us their exit status.
#
for pid in "${pids[@]}"; do
  #
  # Waiting on a specific PID makes the wait command return with the exit
  # status of that process. Because of the 'set -e' setting, any exit status
  # other than zero causes the current shell to terminate with that exit
  # status as well.
  #
  wait "$pid"
done
