# terraform-aws-mcaf-privatelink
Terraform module to create and manage a [Interface VPC endpoint](https://docs.aws.amazon.com/vpc/latest/userguide/endpoint-service-overview.html) using Network Load Balancer in AWS PrivateLink.

- Exposes a service running in VPC A to VPC B using PrivateLink. Creates a private DNS name that can used do to access the 
service. NOTE: To use a private hosted zone, you must set the following VPC attributes to true: `enableDnsHostnames` and `enableDnsSupport`.
  
- If the IP address of the service is known, supply the `target_ip`. If it is unknown, supply the `target_security_group_id`
associated with the service and the IP will be found and targeted.

```terraform
module "privatelink" {
  source                   = "github.com/schubergphilis/terraform-aws-mcaf-privatelink"
  name                     = "test"
  allowed_principals       = ["arn:aws:iam::xxyyzz:root"]
  domain_name              = "test.com"
  zone_id                  = "AAABBBCCC1234"
  private_subnet_ids       = ["subnet-XXYYZZ"]
  target_ip                = "192.168.0.1"
  target_port              = 80
  target_protocol          = "TCP"
  target_security_group_id = "sg-xxyyzz" 
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
