#!/bin/bash



#
# bash .utils/terraform_run_all.sh <Action>
# bash .utils/terraform_run_all.sh init
#

# 'set -e' tells the shell to exit if any of the foreground command fails,
# i.e. exits with a non-zero status.
set -eu

pids=()
ACTION="$1"

array=(
    'messages'
    'payments'
    'profile'
    'app-projects'
    'iac-projects'
)

function rm_terraform {
    find . \( -iname ".terraform*" ! -iname ".terraform-docs*" ! -iname ".terraform-version" \) -print0 | xargs -0 rm -rf
}

echo "[INFO] 🪚 Delete all .terraform folders"
rm_terraform

echo "[INFO] 🏁 Init all terraform repos"
pushd "$(pwd)/azure-devops"
  for index in "${array[@]}" ; do
    echo "🔬 project: $index"
    sh terraform.sh "$ACTION" "$index" &

    pids+=($!)
  done
popd

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
