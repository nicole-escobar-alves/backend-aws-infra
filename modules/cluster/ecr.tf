resource "aws_ecr_repository" "tech_challenge_repository" {
  name                 = "tech_challenge_repository"
  image_tag_mutability = "MUTABLE"
}