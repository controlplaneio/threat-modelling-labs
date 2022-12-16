#!/usr/bin/env bats

load "/home/testing/lib/utils"
load "/home/testing/lib/detik"

DETIK_CLIENT_NAME="kubectl"

setup() {
	run verify "there are 1 service named 'kubernetes'"
	[ "$status" -eq 0 ]
}

@test "verify that images from approved repos can be run" {
  run kubectl apply -f source/control-tests/allowed-repo/allowed-repo.yaml
	run verify "there is 1 pod named 'hello-go-allowed'"
	[ "$status" -eq 0 ]
}

@test "verify that images from non-approved repos cannot be run" {
  run kubectl apply -f source/control-tests/allowed-repo/non-allowed-repo.yaml
	[ "$status" -gt 0 ]
}

teardown() {
  kubectl delete pods -l bats=test   
}