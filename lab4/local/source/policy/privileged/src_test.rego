package privileged_check

denied_input := {
	"review": {
		"object": {
			"spec": {
				"containers": [{"name": "nginx", "securityContext": {"privileged": true}}]
			}
		}
	}
}

allowed_input := {
	"review": {
		"object": {
			"spec": {
				"containers": [{"name": "nginx", "securityContext": {"privileged": false}}]
			}
		}
	}
}

test_deny_privileged_container {
	results := violation with input as denied_input
	count(results) == 1
}

test_allow_non_privileged_container {
	results := violation with input as allowed_input
	count(results) == 0
}