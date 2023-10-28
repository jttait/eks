module "ecr" {
  source                            = "terraform-aws-modules/ecr/aws"
  repository_name                   = "private-example"
  repository_read_write_access_arns = var.read_write_access_arns
  repository_force_delete           = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
