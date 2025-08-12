aws_instance_type = "t2.nano"
ec2_config = {
    v_size = 8
    v_type = "gp2"
}

additional_tags = {
  "DEPT" = "QA"
  "PROJECT" = "MYPROJECT_QA"
}

