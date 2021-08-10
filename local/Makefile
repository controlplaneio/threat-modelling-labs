.PHONY: delete
delete:
	kind delete cluster --name threat-modelling
	rm -f config

.PHONY: create
create: delete
	kind create cluster --config kind/threat-modelling.yaml
	kind get kubeconfig --name threat-modelling > ./config

# TODO: grep to ensure that PSP isn't enabled
.PHONY: psp-enable
psp-enable:
	docker exec -it threat-modelling-control-plane \
	sed -i "s#enable-admission-plugins=NodeRestriction#enable-admission-plugins=NodeRestriction,PodSecurityPolicy#g" /etc/kubernetes/manifests/kube-apiserver.yaml

# TODO: grep to ensure that PSP is already enabled
.PHONY: psp-disable
psp-disable: 
	docker exec -it threat-modelling-control-plane \
	sed -i "s#enable-admission-plugins=NodeRestriction,PodSecurityPolicy#enable-admission-plugins=NodeRestriction#g" /etc/kubernetes/manifests/kube-apiserver.yaml

.PHONY: bats-detik-build
bats-detik-build:
	rm -rf /tmp/bats-detik
	git clone https://github.com/bats-core/bats-detik.git /tmp/bats-detik
	(cd /tmp/bats-detik && git checkout e3ea96e14bfd8d2637fc827c1d801f4c576d2cfc)
	(cd /tmp/bats-detik && docker build -t bats-detik .)
	rm -rf /tmp/bats-detik

.PHONY: bats-detik
bats-detik: bats-detik-build
	docker run -it \
		-v ${PWD}/source:/home/testing/source \
		-v ${PWD}/config:/home/testing/.kube/config \
		--network="host" \
		bats-detik \
		bats /home/testing/source/psp-privileged-test.bats
