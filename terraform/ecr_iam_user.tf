resource "aws_iam_user" "github-actions-user" {
  name = "github-actions-user"

  tags = {
    description: "for shshimamo/container-era-webapp-github-actions"
  }
}

# アクセスキーは一旦手動で作成する(Vault使うのがよさそう?)
# (アクセスキーを手動で作成するとterraform destroyの前に削除しなければいけないみたい)
#resource "aws_iam_access_key" "github-actions-user" {
#  user = "${aws_iam_user.github-actions-user.name}"
#}

# AWS管理のポリシーを使う場合
#data "aws_iam_policy" "ecr_access_role_policy" {
#  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
#}
#resource "aws_iam_user_policy" "github-actions-user" {
#  name = "github-actions-user"
#  user = aws_iam_user.github-actions-user.name
#
#  policy = data.aws_iam_policy.ecr_access_role_policy.policy
#}

resource "aws_iam_policy" "deploy" {
  name = "github-actions-deploy"
  path = "/"
  description = "deploy by github-actions"
  policy = file("aws_iam_policies/ecr_policy.json")
}

resource "aws_iam_user_policy_attachment" "deploy-attach" {
  user = aws_iam_user.github-actions-user.name
  policy_arn = "${aws_iam_policy.deploy.arn}"
}
