#!/usr/bin/env bats

load "../../lib/utils.bash"
load "../../lib/detik.bash"

DETIK_CLIENT_NAME="kubectl"

setup() {
	run verify "there are 1 service named 'kubernetes'"
	[ "$status" -eq 0 ]
}

@test "verify that non-privileged containers can be run in cluster" {
  run kubectl apply -f source/control-tests/privileged-pods/non-privileged.yaml
	sleep 10

	run verify "there is 1 pod named 'nginx-allowed'"
	[ "$status" -eq 0 ]
}

@test "verify that images from approved repos can be run" {
  run kubectl apply -f source/control-tests/privileged-pods/allowed-repo.yaml
	sleep 10

	run verify "there is 1 pod named 'hello-go-allowed'"
	[ "$status" -eq 0 ]
}

@test "verify that privileged containers cannot be run in cluster" {
  run kubectl apply -f source/control-tests/privileged-pods/privileged.yaml
	[ "$status" -gt 0 ]
}

@test "verify that images from non-approved repos cannot be run" {
  run kubectl apply -f source/control-tests/privileged-pods/non-allowed-repo.yaml
	[ "$status" -gt 0 ]
}

teardown() {
  kubectl delete pods -l bats=test   
  [ "$status" -eq 0 ]
}