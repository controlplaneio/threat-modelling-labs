# Course Materials

- [Back to Threat Modelling Labs](/README.md)

## Module 1

### BCTL Data Flow Diagram (DFD)

- An OWASP Threat Dragon json file is provided for the BCTL Level 0 Data Flow Diagram (DFD) presented in module 1: [DFD](BCTL_L0_DFD.json)

- The following link provides instructions which may be used by students to run local, containerised instances of OWASP Threat Dragon and GitLab (for storage of models) using Docker Compose: https://hub.docker.com/r/appsecco/owasp-threat-dragon-gitlab

## Module 2

### Building an example Graphviz attack tree

- The source file for the example Graphviz attack tree used in Module 1 can be found at: [Example attack tree](example_tree.dot)

- We have provided a Dockerfile that can be used to generate `.png` files from Graphviz `.dot` files: [Dockerfile](Dockerfile)

- In order to use this Dockerfile:

```bash
git clone https://github.com/controlplaneio/threat-modelling-labs
cd threat-modelling-labs/course-materials
docker build -t graphviz-render .
cat example_tree.dot | docker run --rm -i graphviz-render > example_tree.png
```

- This will output the attack tree in the `example_tree.png` file

  > You can also use online tools such as [Edotor](https://edotor.net/?engine=dot#digraph%20%7B%0A%09%2F%2F%20Base%20Styling%0A%09rankdir%3D%22TB%22%3B%0A%09splines%3Dtrue%3B%0A%09overlap%3Dfalse%3B%0A%09nodesep%3D%220.2%22%3B%0A%09ranksep%3D%220.4%22%3B%0A%09%2F%2F%20label%3D%22Some%20Title%22%3B%0A%09labelloc%3D%22t%22%3B%0A%09fontname%3D%22Montserrat%22%3B%0A%09node%20%5B%20fontname%3D%22Montserrat%22%20margin%3D0.28%20shape%3D%22plaintext%22%20style%3D%22filled%2C%20rounded%22%20%5D%0A%09edge%20%5B%20fontname%3D%22Montserrat%22%20color%3D%22%232B303A%22%20%5D%0A%09d%20%5Bshape%3Dnone%2C%20label%3D%22%22%2C%20image%3D%22hashjack.png%22%5D%3B%0A%0A%09%2F%2F%20List%20of%20Nodes%0A%0A%09%2F%2F%20base%20nodes%0A%09%2F%2F%20reality%20%5B%20label%3D%22Reality%22%20fillcolor%3D%22%232B303A%22%20fontcolor%3D%22%23ffffff%22%20%5D%0A%09%2F%2F%20attack_win%20%5B%20label%3D%22Access%20video%5Cnrecordings%20in%5CnS3%20bucket%5Cn(attackers%20win)%22%20fillcolor%3D%22%23DB2955%22%20fontcolor%3D%22%23ffffff%22%20%5D%0A%0A%09%2F%2F%20green%20nodes%0A%09node%20%5B%20color%3D%22%23D6E9D5%22%20%5D%0A%09access_sensitive_data%20%5B%20label%3D%22Access%20sensitive%20%5Cndata%22%20%5D%0A%09access_container%20%5B%20label%3D%22Gain%20access%20to%20%5Cncontainer%22%20%5D%0A%09vuln_code_in_container%20%5B%20label%3D%22Malicious%2Fvulnerable%20code%20%5Cnin%20deployed%20container%22%20%5D%0A%09external_route%20%5B%20label%3D%22External%20route%20available%20%5Cnto%20attacker-controlled%20service%22%20%5D%0A%09exec_call%20%5B%20label%3D%22Make%20exec%20call%20%5Cnto%20container%22%20%5D%0A%09vuln_image%20%5B%20label%3D%22Vulnerable%20container%20%5Cnimage%22%20%5D%0A%09tamper_with_image%20%5B%20label%3D%22Tamper%20with%20image%20%5Cnin%20Artifact%20repo%22%20%5D%0A%09vuln_app_code%20%5B%20label%3D%22Vulnerable%20application%20%5Cncode%22%20%5D%0A%09aws_api_call%20%5B%20label%3D%22Data%20returned%20from%20%5CnAWS%20API%20call%22%20%5D%0A%09%0A%09%0A%0A%09%2F%2F%20blue%20nodes%0A%09node%20%5B%20color%3D%22%2384BCE6%22%20%5D%0A%09mount_host_disk%20%5B%20label%3D%22Mount%20host%20%5Cndisk%22%20%5D%0A%09eavesdrop_on_host%20%5B%20label%3D%22Eavesdrop%20on%20host%20%5Cnnetwork%22%20%5D%0A%09eavesdrop_in_pod%20%5B%20label%3D%22Eavesdrop%20on%20traffic%20%5Cnwithin%20a%20pod%22%20%5D%0A%09exfiltrate_data%20%5B%20label%3D%22Malicious%20workload%20%5Cnexfiltrates%20data%22%20%5D%0A%09rce_in_container%20%5B%20label%3D%22RCE%20within%20%5Cncontainer%22%20%5D%0A%09shell_access%20%5B%20label%3D%22Gain%20shell%20in%20%5Cnrunning%20container%22%20%5D%0A%0A%0A%09%2F%2F%20white%20nodes%0A%09node%20%5B%20color%3D%22%23DDDDDD%22%20%5D%0A%09legit_container%20%5B%20label%3D%22Use%20container%20with%20%5Cnlegitimate%20access%22%20%5D%0A%09hostnetwork%20%5B%20label%3D%22Pod%20launched%20with%20%5CnHostnetwork%22%20%5D%0A%09cap_net_admin%20%5Blabel%3D%22Pod%20launched%20with%20%5CnCAP_NET_ADMIN%22%20%5D%0A%09priv_container%20%5Blabel%3D%22Find%20privileged%20%5Cncontainer%22%20%5D%0A%09poor_code%20%5B%20label%3D%22Poor%20coding%20%5Cnpractices%22%20%5D%0A%09vuln_dependency%20%5B%20label%3D%22Referenced%20dependency%20%5Cnhas%20vulnerability%22%20%5D%0A%09dns_tunnel%20%5B%20label%3D%22Exfiltrate%20via%20%5CnDNS%20tunneling%22%20%5D%0A%09internet_gateway_exfiltrate%20%5B%20label%3D%22Exfiltrate%20via%20%5Cninternet%20gateway%22%20%5D%0A%09priv_endpoint_exfiltrate%20%5B%20label%3D%22Exfiltrate%20via%20AWS%20Private%20Endpoint%20%5Cnto%20attacker-controlled%20AWS%20service%22%20%5D%0A%09IAM_misconfig%20%5B%20label%3D%22IAM%20misconfiguration%20%5Cnallows%20unauthorised%20access%22%20%5D%0A%09plain_text_creds%20%5B%20label%3D%22Plain%20text%20credentials%20%5Cnin%20source%20control%22%20%5D%0A%09ec2_instance_metadata%20%5B%20label%3D%22Compromised%20pod%20%5Cnretrieves%20creds%20from%20%5CnEC2%20metadata%20API%22%20%5D%0A%09k8s_api_network_access%20%5B%20label%3D%22K8s%20API%20%5Cnnetwork%20access%22%20%5D%0A%09workload_with_shell%20%5B%20label%3D%22Workload%20with%20%5Cnshell%22%20%5D%0A%09typosquat%20%5B%20label%3D%22Dependency%20confusion%20or%20%5Cntyposquatting%20attack%22%20%5D%0A%09exploitable_vuln%20%5B%20label%3D%22Exploitable%20vulnerability%20%5Cnin%20container%22%20%5D%0A%09exposed_container%20%5B%20label%3D%22Container%20exposed%20%5Cnto%20network%22%20%5D%0A%09obtain_kubeconfig%20%5B%20label%3D%22Obtain%20kubeconfig%20%5Cnfile%22%20%5D%0A%09long_lived_SA_token%20%5B%20label%3D%22Long-lived%20service%20%5Cnaccount%20token%20is%20%5Cncompromised%22%20%5D%0A%09targetted_supply_chain%20%5Blabel%3D%22Targetted%20attack%20%5Cnvia%20public%20image%22%20%5D%0A%09dev_creds%20%5B%20label%3D%22Obtain%20developer%20%5Cncredentials%22%20%5D%0A%09artifact_repo_storage%20%5B%20label%3D%22Access%20to%20artifact%20%5Cnrepo%20storage%20disk%22%20%5D%0A%09commit_malicious_code%20%5B%20label%3D%22Commit%20malicious%20%5Cncode%22%20%5D%0A%0A%0A%0A%09%2F%2F%20List%20of%20Edges%0A%09%0A%09access_sensitive_data%20-%3E%20legit_container%20-%3E%20access_container%0A%0A%09access_container%20-%3E%20rce_in_container%0A%09rce_in_container%20-%3E%20exploitable_vuln%0A%09rce_in_container%20-%3E%20exposed_container%20-%3E%20d%0A%09access_container%20-%3E%20shell_access%0A%09shell_access%20-%3E%20exec_call%0A%09exec_call%20-%3E%20long_lived_SA_token%20-%3E%20d%0A%09exec_call%20-%3E%20obtain_kubeconfig%20-%3E%20d%0A%09shell_access%20-%3E%20k8s_api_network_access%0A%09shell_access%20-%3E%20workload_with_shell%0A%20%20%0A%09access_sensitive_data%20-%3E%20mount_host_disk%20-%3E%20priv_container%0A%09mount_host_disk%20-%3E%20access_container%0A%20%20%0A%09access_sensitive_data%20-%3E%20eavesdrop_on_host%20-%3E%20hostnetwork%0A%09eavesdrop_on_host%20-%3E%20access_container%0A%20%20%0A%09access_sensitive_data%20-%3E%20eavesdrop_in_pod%20-%3E%20cap_net_admin%0A%09eavesdrop_in_pod%20-%3E%20access_container%0A%0A%09access_sensitive_data%20-%3E%20exfiltrate_data%0A%09exfiltrate_data%20-%3E%20vuln_code_in_container%0A%09vuln_code_in_container%20-%3E%20vuln_image%0A%09vuln_image%20-%3E%20targetted_supply_chain%20-%3E%20d%0A%09vuln_image%20-%3E%20typosquat%20-%3E%20d%0A%09vuln_image%20-%3E%20tamper_with_image%20-%3E%20artifact_repo_storage%0A%09tamper_with_image%20-%3E%20dev_creds%0A%09vuln_code_in_container%20-%3E%20vuln_app_code%20-%3E%20commit_malicious_code%20-%3E%20dev_creds%0A%09vuln_app_code%20-%3E%20poor_code%0A%09vuln_app_code%20-%3E%20vuln_dependency%0A%0A%09dev_creds%20-%3E%20d%0A%0A%09exfiltrate_data%20-%3E%20external_route%20-%3E%20internet_gateway_exfiltrate%0A%09external_route%20-%3E%20dns_tunnel%0A%09external_route%20-%3E%20priv_endpoint_exfiltrate%0A%20%20%0A%09aws_api_call%20-%3E%20ec2_instance_metadata%0A%09access_sensitive_data%20-%3E%20aws_api_call%20-%3E%20IAM_misconfig%20-%3E%20d%0A%09aws_api_call%20-%3E%20plain_text_creds%20-%3E%20dev_creds%0A%0A%0A%0A%0A%09%2F%2F%20Subgraphs%20%2F%20Clusters%0A%0A%09%2F%2F%20these%20clusters%20enforce%20the%20correct%20hierarchies%0A%20%20%0A%09subgraph%20same_level_a%20%7B%0A%09%09rank%3Dsame%3B%0A%09%09legit_container%0A%09%09mount_host_disk%0A%09%09eavesdrop_on_host%0A%09%09eavesdrop_in_pod%0A%09%09aws_api_call%0A%09%09exfiltrate_data%0A%09%7D%0A%0A%09subgraph%20same_level_b%20%7B%0A%09%09rank%3Dsame%3B%0A%09%09access_container%0A%09%09priv_container%0A%09%09hostnetwork%0A%09%09cap_net_admin%0A%09%7D%0A%0A%09subgraph%20same_level_c%20%7B%0A%09%09rank%3Dsame%3B%0A%09%09exposed_container%0A%09%09exploitable_vuln%0A%09%7D%0A%09%0A%0A%0A%20%20%2F%2F%20Enforcing%20ordering%20in%20levels%0A%20%20%0A%09legit_container%20-%3E%20mount_host_disk%20-%3E%20eavesdrop_on_host%20-%3E%20eavesdrop_in_pod%20-%3E%20exfiltrate_data%20-%3E%20aws_api_call%20%5B%20style%3D%22invis%22%20%5D%0A%09access_container%20-%3E%20priv_container%20-%3E%20hostnetwork%20-%3E%20cap_net_admin%20%5B%20style%3D%22invis%22%20%5D%0A%7D) 

### BCTL Attack Tree

- The example attack tree for BCTL containing our sample Kubernetes and Cloud Native Threats can be found here: [BCTL Attack Tree](BCTL_tree.dot)

### BCTL Threat model spreadsheet

- The sample BCTL threat model and controls spreadsheet can be found here: [BCTL Threat Model](https://docs.google.com/spreadsheets/d/1xLeh2VMTuypsZIitLukePQU9Z21u9GqZy5VFNc61CM0/edit?usp=sharing)

## Module 3

### BCTL Security Controls

- The candidate security controls for our BCTL example threat model can be found in the 'Controls' tab of the threat model spreadsheet: [BCTL Threat Model](https://docs.google.com/spreadsheets/d/1xLeh2VMTuypsZIitLukePQU9Z21u9GqZy5VFNc61CM0/edit?usp=sharing)

## Module 4

### BCTL controls mapping

- The mapping of security controls to the BCTL attack tree can be found in the following Graphviz file: [BCTL Controls Mapping](BCTL_tree_controls.dot)
