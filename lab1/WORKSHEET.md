# Lab 1 - Cheat Sheet

- [Back to Lab 1](README.md)

## Connectivity Matrix

| [Data](#data)                              | [Highest Impact Level (C/I/A)](#highest-impact-level-cia) | [Source](#source)             | [Destination](#destination)                | [Protocol](#protocol)                      | [Encryption](#encryption)                           | [Authentication](#authentication)                              | [Network route](#network-route)    |
| --------------------------------- | ---------------------------- | ------------------ | -------------------------- | ----------------------------- | ------------------------------------ | ------------------------------------------- | ---------------- |
| Example: customer details         | Confidentiality              | customer           | Ingress controller         | BCTL responsibility           | Not by default - BCTL responsibility | Not by default - BCTL responsibility        | public           |
| Developer K8s API calls           | [Answer 01](#answer-01)                           | kubectl            | API server                 | HTTPS                         | yes                                  | [Answer 02](#answer-02)                                          | public           |
| Customer details                  | Confidentiality              | Ingress controller | Booking pod                | BCTL responsibility           | Not by default - BCTL responsibility |                                             | cluster-internal |
| Customer details                  | Confidentiality              | Booking pod        | PostgreSQL Pod             |                               |                                      | Not by default - BCTL responsibility        | cluster-internal |
| Customer details                  | Confidentiality              | PostgreSQL Pod     | Persistent storage         | AWS responsibility            | AWS responsibility                   | AWS responsibility                          |                  |
| Compliance info                   |                              | Booking pod        | Compliance pod             | BCTL responsibility           | Not by default - BCTL responsibility | Not by default - BCTL responsibility        |                  |
| Compliance info                   |                              | Compliance pod     | Government-owned S3 bucket | HTTPS, AWS issued public cert | yes                                  |                                             |                  |
| Invoicing info                    | Confidentiality              | Invoicing pod      | customer                   |                               |                                      |                                             |                  |
| Poll for new pods                 |                              | Kubelet            | API server                 | HTTPS                         | yes                                  | Certificate authentication - self-signed CA | cluster-internal |
| Poll for services / endpoints     |                              |                    | API server                 | HTTPS                         | yes                                  | Certificate authentication - self-signed CA | cluster-internal |
| Get container image               |                              | Container runtime  |                            | HTTPS                         | yes                                  | Certificate authentication - self-signed CA | cluster-internal |
| Read/write state info             |                              | API server         |                            |                               | yes                                  | Certificate authentication - self-signed CA | cluster-internal |
| Poll for current / desired state  |                              | Controllers        |                            | HTTPS                         | yes                                  | Certificate authentication - self-signed CA | cluster-internal |
| Poll for new pods / schedule pods |                              |                    | API server                 | HTTPS                         | yes                                  | Certificate authentication - self-signed CA | cluster-internal |

## Selections

These are the selections available to complete for each of the columns:

### Data

- Customer details
- Compliance info
- Invoicing info
- Developer K8s API calls
- Example: customer details
- Poll for new pods
- Poll for services / endpoints
- Get container image
- Read/write state info
- Poll for current / desired state
- Poll for new pods / schedule pods

[Back to connectivity matrix](#connectivity-matrix)

### Highest Impact Level (C/I/A)

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Source

- API Server
- Booking Pod
- Compliance Pod
- Container runtime
- Controllers
- Customer
- etcd
- Government-owned S3 bucket
- Image repository
- Ingress Controller
- Invoicing Pod
- Kube proxy
- kubectl
- Kubelet
- Persistent Storage (EBS)
- PostgreSQL Pod
- Scheduler

[Back to connectivity matrix](#connectivity-matrix)

### Destination

- API Server
- Booking Pod
- Compliance Pod
- Container runtime
- Controllers
- Customer
- etcd
- Government-owned S3 bucket
- Image repository
- Ingress Controller
- Invoicing Pod
- Kube proxy
- Kubelet
- Persistent storage
- Persistent Storage (EBS)
- PostgreSQL Pod
- S3 bucket
- Scheduler

[Back to connectivity matrix](#connectivity-matrix)

### Protocol

- BCTL responsibility
- gRPC over TLS
- HTTPS
- HTTPS, AWS issued public cert
- HTTPS, publicly issued cert
- HTTPS, self-signed cert
- iSCSI
- TCP

[Back to connectivity matrix](#connectivity-matrix)

### Encryption

- AWS responsibility
- Not by default - BCTL responsibility
- Shared responsibility
- yes

[Back to connectivity matrix](#connectivity-matrix)

### Authentication

- AWS responsibility
- Certificate authentication - AWS issued public cert
- Certificate authentication - self-signed CA
- Not by default - BCTL responsibility
- Shared responsibility

[Back to connectivity matrix](#connectivity-matrix)

### Network route

- AWS-backbone network
- cluster-internal
- Open egress
- public

[Back to connectivity matrix](#connectivity-matrix)

### Answer 01

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Answer 02

- AWS responsibility
- Certificate authentication - AWS issued public cert
- Certificate authentication - self-signed CA
- Not by default - BCTL responsibility
- Shared responsibility

[Back to connectivity matrix](#connectivity-matrix)
