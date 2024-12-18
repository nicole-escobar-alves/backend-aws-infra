
# resource "aws_iam_role" "lambda_exec_role" {
#   name = "lambda_exec_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action    = "sts:AssumeRole",
#         Effect    = "Allow",
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   })
# }


# resource "aws_iam_policy" "lambda_cognito_policy" {
#   name   = "lambda-cognito-policy"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ]
#         Effect   = "Allow"
#         Resource = "arn:aws:logs:*:*:*"
#       },
#       {
#         Action = [
#           "cognito-idp:AdminInitiateAuth",
#           "cognito-idp:InitiateAuth"
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# resource "aws_iam_policy_attachment" "lambda_full_access" {
#   name       = "lambda_full_access"
#   roles      = [aws_iam_role.lambda_exec_role.name]
#   policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
# }

# resource "aws_iam_policy_attachment" "iam_fiap_policy" {
#   name       = "iam-fiap-policy"
#   roles      = [aws_iam_role.lambda_exec_role.name]
#   policy_arn = "arn:aws:iam::180294201352:policy/iam-fiap-policy"
# }

# resource "aws_iam_policy_attachment" "lambda_cognito_policy_attachment" {
#   name       = aws_iam_policy.lambda_cognito_policy.name
#   roles      = [aws_iam_role.lambda_exec_role.name]
#   policy_arn = aws_iam_policy.lambda_cognito_policy.arn
# }