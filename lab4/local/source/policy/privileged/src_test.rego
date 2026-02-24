package privileged_check

import rego.v1

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

test_deny_privileged_container if {
	results := violation with input as denied_input
	count(results) == 1
}

test_allow_non_privileged_container if {
	results := violation with input as allowed_input
	count(results) == 0
}