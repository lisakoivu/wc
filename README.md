# Wirecutter Demo

This project creates a VPC, public and private subnets, and an nginx server. 

## Getting Started

### AWS Credentials

1. Install the AWS CLI. Details are here:
   https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html

2. Configure credentials either with the CLI or the environment variables:
   https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html

### Install Terraform

Ensure terraform is installed. Install packages are available here:
https://www.terraform.io/downloads.html
Terraform v0.12 is required.

## Installation

Clone the repo locally:

`git clone https://github.com/lisakoivu/wc.git
`


## Usage example

Change directory to the root of the repo, where the main.tf file resides. 

Run `terraform init` to install needed packages.

Run `terraform plan` to view changes. 

If you are satisfied with the plan output, run `terraform apply`.
The apply command will display the IP address of the newly created server. 
For example:
```
Apply complete! Resources: 37 added, 0 changed, 0 destroyed.

Outputs:

instance_ip_addr = 3.220.174.188
```
This server is now accessible via SSH by dave. 
Example connect string: 
```
ssh -i dave.pem dave@3.220.174.188
```
## Test pages displayed

home page: displays the default nginx server page
hello: The universal greeting
example: Prompts for basic auth, and displays content from www.orlandosentinel.com.

3.220.174.188/hello will display Hello World. 

## Release History

* 0.1.0
    * The first proper release
* 0.0.1
    * Work in progress




    