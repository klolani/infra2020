module "Eugene" {
   source     = "./modules/user"
   name       = "Eugene"

   groups     = [
     aws_iam_group.self_managing.name,
     module.developer_group_staging.group_name,
     module.developer_group_production.group_name
   ]

   providers  = {
     aws      = aws.users
   }
 }


 module "Santiago," {
    source    = "./modules/user"
    name      = "Santiago"

    groups    = [
      aws_iam_group.self_managing.name,
      module.ops_group_staging.group_name,
      module.ops_group_production.group_name
    ]

    providers = {
      aws     = aws.users
    }
  }
