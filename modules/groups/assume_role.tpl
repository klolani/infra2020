{
  "Version"   : "2012-10-17",
  "Statement" : {
    "Effect"  : "Allow",
    "Action"  : "sts:AssumeRole",
    "Resource": ${roles_arns_json}
  }
}
