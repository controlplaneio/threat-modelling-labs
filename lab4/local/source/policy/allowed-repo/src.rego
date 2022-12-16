# METADATA
# title: Approved image repos
# description: Only allow images from approved repo
# custom:
#   parameters:
#     repos:
#       type: array
#       description: Array of acceptable repos
#       items:
#         type: string
#   matchers:
#     excludedNamespaces:
#     - kube-system
#     - gatekeeper-system
#     kinds:
#     - apiGroups:
#       - ""
#       kinds:
#       - Pod

package allowed_image

satisfied(c_image) {
	repo := input.parameters.repos[_]
	startswith(c_image, repo)
}

violation[{"msg": msg}] {
	container := input.review.object.spec.containers[_]
	not satisfied(container.image)
	msg := sprintf("container <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, input.parameters.repos])
}
violation[{"msg": msg}] {
	container := input.review.object.spec.initContainers[_]
	not satisfied(container.image)
	msg := sprintf("initContainer <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, input.parameters.repos])
}
violation[{"msg": msg}] {
	container := input.review.object.spec.ephemeralContainers[_]
	not satisfied(container.image)
	msg := sprintf("ephemeralContainer <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, input.parameters.repos])
}