# terraform-aws-mcaf-privatelink
Terraform module to create and manage a [Interface VPC endpoint](https://docs.aws.amazon.com/vpc/latest/userguide/endpoint-service-overview.html) using Network Load Balancer in AWS PrivateLink.

```terraform
module "privatelink" {
  source                   = "github.com/schubergphilis/terraform-aws-mcaf-privatelink"
  name                     = "test"
  allowed_principals       = ["arn:aws:iam::xxyyzz:root"] # AWS accounts allowed to access the service
  domain_name              = "test.com"
  zone_id                  = "AAABBBCCC1234"
  private_subnet_ids       = ["subnet-XXYYZZ"]
  target_ip                = "192.168.0.1" # When IP address is known, otherwise supply target_security_group_id
  target_port              = 80
  target_protocol          = "TCP"
  target_security_group_id = "sg-xxyyzz"  # Supply when target_ip not known to find target ENI IP address
  vpc_id                   = "vpc-xxyyzz"

  tags = {
    environment = "test"
  }
}
```

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.23 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_principals | List of allowed AWS principals to access the PrivateLink endpoint service | `list(string)` | n/a | yes |
| domain\_name | Domain name of the DNS Zone to use for the private DNS name | `string` | n/a | yes |
| name | Name to use for the PrivateLink resources | `string` | n/a | yes |
| private\_subnet\_ids | List of subnet IDs assigned to the Network Load Balancer | `list(string)` | n/a | yes |
| tags | A mapping of tags to assign to the resources | `map(string)` | n/a | yes |
| target\_port | The target port of the service shared using PrivateLink | `number` | n/a | yes |
| target\_security\_group\_id | The target security group ID used to find the ENI of the service shared using PrivateLink | `string` | n/a | yes |
| vpc\_id | The ID of the VPC | `string` | n/a | yes |
| zone\_id | ID of the DNS Zone | `string` | n/a | yes |
| target\_ip | The target IP address of the service shared using PrivateLink | `string` | `null` | no |
| target\_protocol | The target protocol of the service shared using PrivateLink | `string` | `"TCP"` | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_dns\_name | Name of the private DNS to access the service |

<!--- END_TF_DOCS --->
