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
<!--- END_TF_DOCS --->
