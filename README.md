# LEARNNING OCI Foundations 2021 Associate [1Z0-1085-21]

![50_Oracle_Cloud_Infrastructure](https://user-images.githubusercontent.com/62715900/135468618-d814c2ee-62d0-4be0-8240-578945d4b62c.png)

>This project is about learning for OCI Foundations 2021 Associate [1Z0-1085-21]\
>All images were taken from the official course, with all rights reserved to the official source

## Authors

- Marcos Silvestrini
- marcos.silvestrini@gmail.com

## License

- This project is licensed under the MIT License - see the LICENSE.md file for details

## References

- [Oracle Cloud](https://www.oracle.com/cloud/)
- [Course](https://learn.oracle.com/ols/learning-path/become-an-oci-foundation-associate/35644/98057)
- [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/)
- [CLI Guide](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#configfile)
- [Powershell OCI Module](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/powershellgettingstarted.htm)
- [Powershell OCI Module Git](https://github.com/oracle/oci-powershell-modules)
- [Setup OCI CLI](https://borysneselovskyi.wordpress.com/2019/06/25/install-and-configure-oracle-cloud-cli-on-the-oracle-linux-7-4/)

## OCI Introduction

### OCI Overview

![image](https://user-images.githubusercontent.com/62715900/135547108-fed99620-564c-449f-8177-018440dfd22e.png)

### OCI Architecture

#### OCI AD

![image](https://user-images.githubusercontent.com/62715900/135547240-f7e6e4a6-a712-4a66-80f5-8d3958bca889.png)

#### OCI FD

![image](https://user-images.githubusercontent.com/62715900/135547358-699894ca-1493-44db-9983-da057c376375.png)

## Oracle Cloud Free Tier Account

- Oracle Cloud Free Tier Account
- OCI console walk-throught
- Setting up your tenancy
- MFA and Budget setup

## Identity and Access Managment

### OCI IAM

![image](https://user-images.githubusercontent.com/62715900/135934982-91a01b36-c61b-40fc-98b3-e4ec52082cbd.png)

### OCI Identity Conecpts

![image](https://user-images.githubusercontent.com/62715900/135935744-825e61c3-2add-4176-8014-08f36dee3b7c.png)

### OCI Resources

![image](https://user-images.githubusercontent.com/62715900/135936266-54fb8a6b-47e5-40f7-b379-c10c2d99da23.png)

### OCI AuthN (Authentication)

- User name / password
- API signing Keys
- Authentication tokens

### OCI AuthZ (Authorization - Policies)

![image](https://user-images.githubusercontent.com/62715900/135936887-4abc9014-e8e1-4fcb-8b29-4cd3bd1766fa.png)

### Compartments

#### Compartment Access

![image](https://user-images.githubusercontent.com/62715900/135937784-3184914f-7e93-4c68-8ae4-29da71dd4aa7.png)

#### Compartment Example

![image](https://user-images.githubusercontent.com/62715900/135938009-78b5345d-affc-44fd-97be-6099363c3042.png)

### Demo IAM

- Create OCI Compartment sandbox
- Create OCI Group OCI-admins-group
- Create OCI IAM User ociadmin
- Add user ociadmin to group OCI-admins-group
- Create Policy oci-admins-group-policy

>Policy statement: Allow group OCI-admins-group to manage all-resources in compartment sandbox

- Add compartment sandbox in this policy

## Networking

### VCN Overview

![image](https://user-images.githubusercontent.com/62715900/137231938-ddd82c4d-6fa1-47de-8fd5-0ef02818afaa.png)

![image](https://user-images.githubusercontent.com/62715900/137231369-32ded426-83d7-486d-a0ce-d929bfb8c117.png)

![image](https://user-images.githubusercontent.com/62715900/137231484-c7bd80b7-8566-4053-83b1-3a4404fdde30.png)

### Route Table

![image](https://user-images.githubusercontent.com/62715900/137232961-ccd519c1-fc90-4dd8-a8d5-2de13ed08c22.png)

![image](https://user-images.githubusercontent.com/62715900/137233021-aa079410-7688-4b68-a061-cf44c80dcdf0.png)

### Peering

![image](https://user-images.githubusercontent.com/62715900/137233188-53523d26-10cb-4a36-bca2-5b353ccce5cb.png)

### DRG v2

![image](https://user-images.githubusercontent.com/62715900/137233276-76995f43-2534-4dd1-a324-d6b97abef750.png)

### Network Security Lists

![image](https://user-images.githubusercontent.com/62715900/137407285-e850ffd2-f370-4331-8ab0-9c71cf94d948.png)

### Network Security Groups

![image](https://user-images.githubusercontent.com/62715900/137407534-518bc12d-f0ab-4628-80e7-ff4d098f7a79.png)

### Demo VCN

- Create a VCN with VCN Wizard

>Profile: ociadmin\
VCN type: internet connectivity\
VCN Name: sa-saopaulo-1\
Compartment: sandbox\
VCN CIDR Block: 10.0.0/16\
Public CIDR: 10.0.0.0/24\
Public CIDR: 10.0.0.2/24

- Create a instance for test VCN

>Type: Web Server\
set ssh public key in instance\
open ssh session in instance\
install httpd

- Setup HTTPD in Instance

>sudo firewall-cmd --permanent --add-port=80/tcp\
sudo firewall-cmd --reload\
sudo systemctl start httpd\
sudo su\
echo "My Web Server in OCI" >>/var/www/html/index.html

- Setup VCN Public Network Security List

>Ressource: Ingress Rule\
Source CIDR: 0.0.0./0\
IP Protocol: TCP\
Source Port Range: All\
Destination Port Range: 80

- Extras

>Configure Policy for access cloud-shell

### Load Balance

Load Balance HTTP
![image](https://user-images.githubusercontent.com/62715900/139356422-40832f91-1d52-483f-b173-7c089d9bc0e5.png)

Network Load Balance\
![image](https://user-images.githubusercontent.com/62715900/139356550-39606bb8-366a-4ac6-8dd2-57c30d41f935.png)

#### Demo Load Balance

>Type: Load Balance HTTP\
Backend Type: Round Robin\
Protocol: HTTP\
Port: 80

## Compute

### Types of Instances

![image](https://user-images.githubusercontent.com/62715900/142080291-a1b2152e-1989-487e-8d5a-38436026db44.png)

### Instance Base

![image](https://user-images.githubusercontent.com/62715900/142080970-c6702b19-79a0-4c68-94a1-ab5213f537ad.png)

### Scaling

#### Vertical Scaling

![image](https://user-images.githubusercontent.com/62715900/142081741-2df4248a-ce59-4523-9421-29f45b7eed30.png)

#### AutoScaling(Horizontal)

![image](https://user-images.githubusercontent.com/62715900/142082301-3733d2b6-ba1b-4291-a7a2-576edc9ae1ec.png)

### OS Managment Service

![image](https://user-images.githubusercontent.com/62715900/142083139-f54a2d8e-83fc-470d-830a-02da31305a58.png)

## Storage

### Storage Services

![image](https://user-images.githubusercontent.com/62715900/146287479-cdb7394b-9800-4b87-ab65-b0d412c32639.png)

![image](https://user-images.githubusercontent.com/62715900/146287582-3a55ffee-d4d5-45fc-a2fc-e3484e7fd729.png)


### Object Storage

![image](https://user-images.githubusercontent.com/62715900/146288622-46b3d0b3-687a-40a1-b0af-8498a94bc592.png)

![image](https://user-images.githubusercontent.com/62715900/146288870-68a9dde9-ba31-4061-a8b4-ca9d74155280.png)

## Database

## Security

## App Dev

## Observability and Management

## Analytics and AI

## Hybrid

## Governance and Administration

## SLA and Support

## Course Summary
