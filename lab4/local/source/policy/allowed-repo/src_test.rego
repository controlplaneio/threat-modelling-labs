package allowed_image

denied_input := {
	"review": {
		"object": {
			"spec": {
				"containers": [{"name": "nginx", "image": "nginx:latest"}]
			}
		}
	}, 
	"parameters": {
		"repos": ["ttl.sh/"]
	}
}

allowed_input := {
	"review": {
		"object": {
			"spec": {
				"containers": [{"name": "nginx", "image": "ttl.sh/12345678:latest"}]
			}
		}
	}, 
	"parameters": {
		"repos": ["ttl.sh/"]
	}
}

test_deny_non_allowed_repo {
	results := violation with input as denied_input
	count(results) == 1
}

test_allow_allowed_repo {
	results := violation with input as allowed_input
	count(results) == 0
}