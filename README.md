# DevOps Case Assignment
[My design document would go here](https://docs.google.com/document/dummy_design_doc)

Let's say we have two groups of users. The first group - "Developers", with users: Eugene,
Milo, Abigail, Aidan. The second group - "Ops", with users: Santiago, Felix, Morgan.

Your cloud provider is AWS, but this is only a hint of which resources you should use. For the
purpose of the task, it does not have to run against a real AWS environment.

### Tasks
**Which resources will you use, and how will they interact?**
  * The resources used are;
  * AWS Organizations
    - Consolidates and centrally manages multiple AWS accounts.
    - We will create four accounts within the organization.
         - users account only for user management
         - dev, staging and production for  application infrastructure
  * IAM
    - Create IAM groups, roles, and policies for controlling access to the AWS accounts and their respective resources
  * S3 Bucket
    - Serve as a terraform backend to store our terraform state files

**Write Terraform code which will:**
    - Create users and groups
    - Assign users to the groups
    - Create roles for each group (users should be able to assume them); you do not have to
    assign any policies to the roles.

**Terraform code Layout**
    ├── Data
    │   └── self_manage_vmfa.json
    ├── Makefile
    ├── README.md
    ├── backends.tf
    ├── dev
    ├── developers.tf
    ├── locals.tf
    ├── main.tf
    ├── modules
    │   ├── backend
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── groups
    │   │   ├── assume_role.tpl
    │   │   ├── main.tf
    │   │   ├── outputs.tf
    │   │   └── variables.tf
    │   ├── roles
    │   │   ├── developer
    │   │   │   ├── main.tf
    │   │   │   ├── outputs.tf
    │   │   │   ├── trust_relationship.tpl
    │   │   │   └── variables.tf
    │   │   └── ops
    │   │       ├── main.tf
    │   │       ├── outputs.tf
    │   │       ├── trust_relationship.tpl
    │   │       └── variables.tf
    │   └── users
    │       ├── main.tf
    │       ├── outputs.tf
    │       └── variables.tf
    ├── ops.tf
    ├── outputs.tf
    ├── production
    ├── staging
    ├── users.tf
    └── versions.tf

### Deliverables
This repository creates the following:

* AWS organization with four accounts:
    - Users - All users are created in this account
    - Dev   - Contains dev application resources
    - Staging - Contains staging application resources
    - Production - Contains production application resources
* IAM groups and roles for developers and Ops teams
* S3 bucket as a Terraform backend.

### Pre-requisite for setting up the project locally

- In order to run this project successfully ensure you have terraform v0.12.0
- AWS Account
- AWS credentials properly configured and have full permissions


### Running and testing
* Update locals.tf file accordingly
* Edit users.tf file with the list of users to be created
* Initialize the Terraform and apply plan:
    $ terraform init
    $ terraform plan
    $ terraform apply


Notes:
* This project can be extended to include other AWS resources by defining them in the modules folder

#### Assumptions
- The AWS applications is separated into 3 environments; dev, staging and production
- Developers and Ops permissions are different across the different AWS accounts
- The master account has already been created when setting up the AWS account
- Users will be allowed to login and have programatically access AWS resources

### Future improvements
_Recommendations:_
- Integrate Single Sign On and eliminate the need to create individual users
- Enable AWS CLI integrations via SSO
- Add Terraform tests via Terratest

**The approach and reasons behind my choices**
* AWS multi-account architecture in a highly automated and enables the infrastructure to operate at scale.
* Since we are creating users; we should allow users to self board themselves with limited Ops involvement


## Service Maintainers
If you have any questions regarding this project, please reach out to
- Kennedy Wanyangu [GitHub](https://github.com/klolani)
