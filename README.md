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

#### Demo

- Create OCI Compartment
- Create OCI Group OCI-admin-group
- Create Policy \
Policy statement: Allow group OCI-admins-group to manage all-resources in compartment sandbox
- Create OCI IAM User ociadmin
- Add user to group
