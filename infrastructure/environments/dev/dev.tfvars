project_name        = "devsecops"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
availability_zone   = "ap-south-1a"
enable_nat          = true
mongodb_connection_uri = "mongodb+srv://<username>:<password>@cluster0.xxxxx.mongodb.net/devsecops?retryWrites=true&w=majority"
aws_region         = "ap-south-1"