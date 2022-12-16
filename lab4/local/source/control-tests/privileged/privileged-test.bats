#!/usr/bin/env bats

load "/home/testing/lib/utils"
load "/home/testing/lib/detik"

DETIK_CLIENT_NAME="kubectl"

setup() {
	run verify "there are 1 service named 'kubernetes'"
	[ "$status" -eq 0 ]
}

@test "verify that non-privileged containers can be run in cluster" {
	run kubectl apply -f source/control-tests/privileged/non-privileged.yaml
	run verify "there is 1 pod named 'nginx-allowed'"
	[ "$status" -eq 0 ]
}

@test "verify that privileged containers cannot be run in cluster" {
  run kubectl apply -f source/control-tests/privileged/privileged.yaml
	[ "$status" -gt 0 ]
}

teardown() {
  kubectl delete pods -l bats=test   
}