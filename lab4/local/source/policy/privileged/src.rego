# METADATA
# title: Privileged pods
# description: Do not allow privileged pods in non-exempt namespaces
# custom:
#   matchers:
#     excludedNamespaces:
#     - kube-system
#     - gatekeeper-system
#     kinds:
#     - apiGroups:
#       - ""
#       kinds:
#       - Pod

package privileged_check

import rego.v1

violation contains {"msg": msg, "details": {}} if {
		c := input_containers[_]
		c.securityContext.privileged == true
		msg := sprintf("Privileged container is not allowed: %v, securityContext: %v", [c.name, c.securityContext])
}
input_containers contains c if {
		c := input.review.object.spec.containers[_]
}
input_containers contains c if {
		c := input.review.object.spec.initContainers[_]
}
input_containers contains c if {
		c := input.review.object.spec.ephemeralContainers[_]
}