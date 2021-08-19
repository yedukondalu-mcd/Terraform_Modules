provider "aws" {
	region = "us-east-1"
#	profile = "kondalu"
}

module "ec2_module" {
	source = "./ec2_module"
}