provider "aws" {
    profile = "default"
    region = "us-east-2"
}

resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "public-subnet"
  }
}

# To provide internet access to the public subnets, 
# you need to create an internet gateway. 
# Add the following configuration to create an internet gateway called 
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-vpc-IGW"
    }
}

resource "aws_s3_bucket" "tf_bucket" {
  bucket = "kc-tf-demo-bucket"

  tags = {
    Terraform   = "true"
    Name        = "My TF bucket"
    Environment = "Production"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# resource "aws_s3_bucket_acl" "btf_bucket_acl" {
#   bucket = aws_s3_bucket.tf_bucket.id
#   acl    = "public-read"
# }

