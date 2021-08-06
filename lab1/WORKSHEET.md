# Lab 1 - Work Sheet

- [Back to Lab 1](README.md)

## Connectivity Matrix

| [Data](#data)                     | [Highest Impact Level (C/I/A)](#highest-impact-level-cia) | [Source](#source)             | [Destination](#destination)                | [Protocol](#protocol)                      | [Encryption](#encryption)                           | [Authentication](#authentication)                              | [Network route](#network-route)    |
| --------------------------------- | --------------------------------------------------------- | ----------------------------- | ------------------------------------------ | ------------------------------------------ | --------------------------------------------------- | -------------------------------------------------------------- | ---------------------------------- |
| Example: customer details         | Confidentiality                                           | customer                      | Ingress controller                         | BCTL responsibility                        | Not by default - BCTL responsibility                | Not by default - BCTL responsibility                           | public                             |
| Developer K8s API calls           | [Answer 01](#answer-01)                                   | kubectl                       | API server                                 | HTTPS                                      | yes                                                 | [Answer 02](#answer-02)                                        | public                             |
| Customer details                  | Confidentiality                                           | Ingress controller            | Booking pod                                | BCTL responsibility                        | Not by default - BCTL responsibility                | [Answer 03](#answer-03)                                        | cluster-internal                   |
| Customer details                  | Confidentiality                                           | Booking pod                   | PostgreSQL Pod                             | [Answer 04](#answer-04)                    | [Answer 05](#answer-05)                             | Not by default - BCTL responsibility                           | cluster-internal                   |
| Customer details                  | Confidentiality                                           | PostgreSQL Pod                | Persistent storage                         | AWS responsibility                         | AWS responsibility                                  | AWS responsibility                                             | [Answer 06](#answer-06)            |
| Compliance info                   | [Answer 07](#answer-07)                                   | Booking pod                   | Compliance pod                             | BCTL responsibility                        | Not by default - BCTL responsibility                | Not by default - BCTL responsibility                           | [Answer 08](#answer-08)            |
| Compliance info                   | [Answer 09](#answer-09)                                   | Compliance pod                | Government-owned S3 bucket                 | HTTPS, AWS issued public cert              | yes                                                 | [Answer 10](#answer-10)                                        | [Answer 11](#answer-11)            |
| Invoicing info                    | Confidentiality                                           | Invoicing pod                 | customer                                   | [Answer 12](#answer-12)                    | [Answer 13](#answer-13)                             | [Answer 14](#answer-14)                                        | [Answer 15](#answer-15)            |
| Poll for new pods                 | [Answer 16](#answer-16)                                   | Kubelet                       | API server                                 | HTTPS                                      | yes                                                 | Certificate authentication - self-signed CA                    | cluster-internal                   |
| Poll for services / endpoints     | [Answer 17](#answer-17)                                   | [Answer 18](#answer-18)       | API server                                 | HTTPS                                      | yes                                                 | Certificate authentication - self-signed CA                    | cluster-internal                   |
| Get container image               | [Answer 19](#answer-19)                                   | Container runtime             | [Answer 20](#answer-20)                    | HTTPS                                      | yes                                                 | Certificate authentication - self-signed CA                    | cluster-internal                   |
| Read/write state info             | [Answer 21](#answer-21)                                   | API server                    | [Answer 22](#answer-22)                    | [Answer 23](#answer-23)                    | yes                                                 | Certificate authentication - self-signed CA                    | cluster-internal                   |
| Poll for current / desired state  | [Answer 24](#answer-24)                                   | Controllers                   | [Answer 25](#answer-25)                    | HTTPS                                      | yes                                                 | Certificate authentication - self-signed CA                    | cluster-internal                   |
| Poll for new pods / schedule pods | [Answer 26](#answer-26)                                   | [Answer 27](#answer-27)       | API server                                 | HTTPS                                      | yes                                                 | Certificate authentication - self-signed CA                    | cluster-internal                   |

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

## Answers

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

### Answer 03

- AWS responsibility
- Certificate authentication - AWS issued public cert
- Certificate authentication - self-signed CA
- Not by default - BCTL responsibility
- Shared responsibility

[Back to connectivity matrix](#connectivity-matrix)

### Answer 04

- BCTL responsibility
- gRPC over TLS
- HTTPS
- HTTPS, AWS issued public cert
- HTTPS, publicly issued cert
- HTTPS, self-signed cert
- iSCSI
- TCP

[Back to connectivity matrix](#connectivity-matrix)

### Answer 05

- AWS responsibility
- Not by default - BCTL responsibility
- Shared responsibility
- yes

[Back to connectivity matrix](#connectivity-matrix)

### Answer 06

- AWS-backbone network
- cluster-internal
- Open egress
- public

[Back to connectivity matrix](#connectivity-matrix)

### Answer 07

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Answer 08

- AWS-backbone network
- cluster-internal
- Open egress
- public

[Back to connectivity matrix](#connectivity-matrix)

### Answer 09

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Answer 10

- AWS responsibility
- Certificate authentication - AWS issued public cert
- Certificate authentication - self-signed CA
- Not by default - BCTL responsibility
- Shared responsibility

[Back to connectivity matrix](#connectivity-matrix)

### Answer 11

- AWS-backbone network
- cluster-internal
- Open egress
- public

[Back to connectivity matrix](#connectivity-matrix)

### Answer 12

- BCTL responsibility
- gRPC over TLS
- HTTPS
- HTTPS, AWS issued public cert
- HTTPS, publicly issued cert
- HTTPS, self-signed cert
- iSCSI
- TCP

[Back to connectivity matrix](#connectivity-matrix)

### Answer 13

- AWS responsibility
- Not by default - BCTL responsibility
- Shared responsibility
- yes

[Back to connectivity matrix](#connectivity-matrix)

### Answer 14

- AWS responsibility
- Certificate authentication - AWS issued public cert
- Certificate authentication - self-signed CA
- Not by default - BCTL responsibility
- Shared responsibility

[Back to connectivity matrix](#connectivity-matrix)

### Answer 15

- AWS-backbone network
- cluster-internal
- Open egress
- public

[Back to connectivity matrix](#connectivity-matrix)

### Answer 16

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Answer 17

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Answer 18

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

### Answer 19

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Answer 20

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

### Answer 21

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Answer 22

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

### Answer 23

- BCTL responsibility
- gRPC over TLS
- HTTPS
- HTTPS, AWS issued public cert
- HTTPS, publicly issued cert
- HTTPS, self-signed cert
- iSCSI
- TCP

[Back to connectivity matrix](#connectivity-matrix)

### Answer 24

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Answer 25

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

### Answer 26

- Confidentiality
- Availability
- Integrity
- Integrity & Availability

[Back to connectivity matrix](#connectivity-matrix)

### Answer 27

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
