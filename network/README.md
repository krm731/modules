# CAP Networking
This module comprises of Terraform code for provisioning multiple networking components such as VPCs, Subnets, VPN, Firewall rules, DNS and NAT. The modules related to these components are invoked from the management and value stream repos.

## Network Design Considerations

The CAP network architecture is based on the value stream approach. The network architecture is based on the below mentioned considerations

Consideration | Description
------------- | -----------
Centralised Network for common / shared services | Certain services such as NAT, DNS routing to on premise, IDS / IPS, On premise connectivity, etc will need to be managed centrally across value streams
Network Connectivity | - No connectivity by default between environments <br> - Value streams may need to access services running on premise <br> - Services running on premise may need to access value stream services on cloud <br> - Value streams may need to access 3rd party services over the internet <br> - 3rd party services may need to access services hosted by value streams <br> - Egress to the internet should be centrally managed



## Overall Network Layout for CAP

![cap arch image](images/cap_net_arch.jpeg)

### Hub and Spoke Pattern
The network architecture is based on the hub and spoke pattern. A management VPC is created which acts as the hub network and is responsible for hosting services and capabilities that will be commonly needed across all value streams

Each value stream has it's own VPC which is used to provide networking capabilities to the GCP services and applications within the value stream. The hub and spoke are connected using VPN tunnels

The above pattern is repeated for production and non-production environment with a separate management VPC for all non-production environments.

### Ingress
Ingress from the internet is managed by individual value streams. For more details refer to the [ingress design document](./README_Ingress.md)

### Egress
Egress to the internet is centrally managed from within the management VPC. For more details refer to the [egress design document](./README_Egress.md)
