CERT_MANAGER_URL = https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml

install:
	bash ./install.sh

uninstall:
	# kubectl delete -f $(CERT_MANAGER_URL)
	/usr/local/bin/k3s-uninstall.sh
	
run:
	./run.sh

	
mount:
	mount /dev/sda1 /mnt/flesh

remove:
		kubectl delete -f $(CERT_MANAGER_URL)
		kubectl delete -k .

token:
	sudo cat /var/lib/rancher/k3s/server/node-token

install_agent:
	curl -sfL https://get.k3s.io | K3S_URL=https://192.168.1.35:6443 K3S_TOKEN={} sh -

uninstall_agent:
	/usr/local/bin/k3s-agent-uninstall.sh
worker:
	kubectl label node tinkerboard-2 node-role.kubernetes.io/worker=worker

helm:
	export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm repo update
	helm install quickstart ingress-nginx/ingress-nginx