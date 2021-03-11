# terraform-aws-mcaf-privatelink
Terraform module to create and manage a [Interface VPC endpoint](https://docs.aws.amazon.com/vpc/latest/userguide/endpoint-service-overview.html) using Network Load Balancer in AWS PrivateLink.

- Exposes a service running in VPC A to VPC B using PrivateLink. Creates a private DNS name that can used do to access the
service. NOTE: To use a private hosted zone, you must set the following VPC attributes to true: `enableDnsHostnames` and `enableDnsSupport`.

```terraform
module "privatelink" {
  source                   = "github.com/schubergphilis/terraform-aws-mcaf-privatelink"
  name                     = "test"
  allowed_principals       = ["arn:aws:iam::xxyyzz:root"]
  domain_name              = "test.com"
  private_subnet_ids       = ["subnet-XXYYZZ"]
  target_ips                = ["192.168.0.1", "192.168.0.2"]
  target_port              = 80
  target_protocol          = "TCP"
  vpc_id                   = "vpc-xxyyzz"
  zone_id                  = "AAABBBCCC1234"

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
| allowed\_principals | List of allowed AWS principals to access the endpoint service | `list(string)` | n/a | yes |
| domain\_name | Domain name to use for the private DNS name | `string` | n/a | yes |
| name | Name to use for the PrivateLink resources | `string` | n/a | yes |
| private\_subnet\_ids | List of subnet IDs assigned to the network load balancer | `list(string)` | n/a | yes |
| tags | A mapping of tags to assign to the resources | `map(string)` | n/a | yes |
| target\_ip | The target IP address of the endpoint service | `string` | n/a | yes |
| target\_port | The target port of the endpoint service | `number` | n/a | yes |
| vpc\_id | The ID of the VPC | `string` | n/a | yes |
| zone\_id | The ID of the DNS Zone | `string` | n/a | yes |
| target\_protocol | The target protocol of the endpoint service | `string` | `"TCP"` | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_dns\_name | Name of the private DNS to access the service |

<!--- END_TF_DOCS --->
