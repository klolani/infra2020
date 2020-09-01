module "Eugene" {
   source     = "./modules/users"
   name       = "Eugene"
   pgp_key    = ""

   groups     = [
     aws_iam_group.developer_self_managing.name,
     module.developer_group_staging.group_name,
     module.developer_group_production.group_name
   ]

   providers  = {
     aws      = aws.users
   }
 }


 module "Santiago" {
    source    = "./modules/users"
    name      = "Santiago"
    pgp_key   = ""

    groups    = [
      aws_iam_group.ops_self_managing.name,
      module.ops_group_staging.group_name,
      module.ops_group_production.group_name
    ]

    providers = {
      aws     = aws.users
    }
  }
