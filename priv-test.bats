#!/usr/bin/env bats

load "../lib/utils.bash"
load "../lib/detik.bash"

DETIK_CLIENT_NAME="kubectl"

setup() {
  # deploy nginx
  echo $PWD
  kubectl apply -f sources/nginx-priv.yaml
echo "wait for nginx to be ready..."
  sleep 20
}
teardown() {
  # tear down nginx
  kubectl delete pod nginx
}


@test "verify the deployment" {
	run verify "there is a pod called 'nginx'"
	[ "$status" -eq 0 ]
}