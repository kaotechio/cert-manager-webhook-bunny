<p align="center">
  <img src="https://raw.githubusercontent.com/cert-manager/cert-manager/d53c0b9270f8cd90d908460d69502694e1838f5f/logo/logo-small.png" height="256" width="256" alt="cert-manager project logo" />
</p>

### cert-manager ACME DNS01 webhook for Bunny.net DNS

This repository implements a cert-manager ACME webhook solver that manages DNS-01 TXT records using Bunny.net DNS.

### Prerequisites

- Kubernetes cluster with cert-manager installed
- A Bunny.net account with DNS enabled and an API Access Key
- A Kubernetes `Secret` containing the API key
### Helm deployment

```bash
helm upgrade \
  --install bunny-webhook oci://ghcr.io/kaotechio/charts/bunny-webhook \
  --version 0.1.0 \
  --namespace cert-manager
```

### Issuer configuration

Create a `Secret` with your Bunny API Access Key and reference it in the webhook config.

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-bunny
spec:
  acme:
    email: <you@example.com>
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-bunny
    solvers:
      - dns01:
          webhook:
            groupName: acme.kaotech.io
            solverName: "bunny.net"
            config:
              apiKeySecretRef:
                name: bunny-api-key
                key: apiKey
```

Example `Secret`:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: bunny-api-key
  namespace: cert-manager
type: Opaque
stringData:
  apiKey: "YOUR_BUNNY_ACCESS_KEY"
```
