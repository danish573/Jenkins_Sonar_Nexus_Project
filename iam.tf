resource "aws_iam_role" "proj-iam-role" {
  name               = "Terrafrom-admin"
  assume_role_policy = <<EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "ec2-policy" {
  role       = aws_iam_role.proj-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "proj-instance-profile" {
  name = "jenkins-instance-profile"
  role = aws_iam_role.proj-iam-role.name
}