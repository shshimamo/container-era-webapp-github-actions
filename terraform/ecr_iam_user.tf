resource "aws_iam_user" "github-actions-user" {
  name = "github-actions-user"

  tags = {
    description: "for shshimamo/container-era-webapp-github-actions"
  }
}

#resource "aws_iam_access_key" "github-actions-user" {
#  user = "${aws_iam_user.github-actions-user.name}"
#}

data "aws_iam_policy" "ecr_access_role_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_user_policy" "github-actions-user" {
  name = "github-actions-user"
  user = "${aws_iam_user.github-actions-user.name}"

  policy = data.aws_iam_policy.ecr_access_role_policy.policy
}
