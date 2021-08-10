#!/usr/bin/env bats

load "../lib/utils.bash"
load "../lib/detik.bash"

DETIK_CLIENT_NAME="kubectl"

setup() {
	run verify "there are 1 service named 'kubernetes'"
	[ "$status" -eq 0 ]
}

@test "verify that privileged containers cannot be run in cluster" {
  run kubectl apply -f source/nginx.yaml
	[ "$status" -gt 0 ]
}

teardown() {
  kubectl delete pods -l bats=privileged-test   
  [ "$status" -eq 0 ]
}