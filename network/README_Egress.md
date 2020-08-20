# CAP Egress

The egress design for CAP is based on the below mentioned considerations

Consideration | Description
------------- | -----------
Centralised Management of Egress to internet | Egress to the internet needs to be managed centrally to ensure granular level of control over traffic exiting to the internet
Specific public endpoints for services | All applications that require access to the internet must only be exposed via a specific set of IP addresses
IP / URL Filtering | The design must provide the ability to restrict outbound connectivity to a specific set of IP addresses / URLs on the internet

## Egress Design

![CAP Egress design](Images/cap_egress.jpg)

### Egress Design Explained

* Egress is managed centrally by setting up a GCP NAT gateway in a public subnet on the management VPC
* A Squid proxy installation is in place which is specified as the next destination for internet based traffic from the value stream VPC