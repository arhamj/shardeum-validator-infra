# Shardeum validator infra

Contains a list of terraform scripts to provision the resources required to run a shardeum validator.
Namely,

1. VPC
2. Internet Gateway - For the validator to connect to the internet
3. Security Group - For the EC2 running the validator
4. EC2 - With docker and docker compose pre-installed

The scripts support only AWS at the moment.

### Prerequisites

- Install AWS CLI and configure credentials

### Usage

- Generate a key-pair to authenticate remote login to the EC2 instance. Note that this key-pair must be in the same
  directory as the scripts and must have the name `shardeum_key_pair`. Both the location and the name of the file can be
  edited in the `vars.tf`

```
ssh-keygen -t rsa
```

- Init terraform project

```
terraform init
```

- Plan the resource provisioning

```
terraform plan -out terraform.out
```

- Apply the changes

```
terraform apply terraform.out
```

Note: Keep `terraform.tfstate` secure

### Next steps

Follow [validator-dashboard](https://gitlab.com/shardeum/validator/dashboard) from Step 3