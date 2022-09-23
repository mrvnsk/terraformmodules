# Generates an iam policy document in json for the ecs task execution role
data "aws_iam_policy_document" "ecs-task-exe-role-policy" {
    statement {
      actions       = ["sts.AssumeRole"]

      principals {
        type        = "Service"
        identifiers = ["ecs-task.amazonaws.com"]
      }
    }
}

# Create a IAM Role
resource "aws_iam_role" "ecs-task-exe-role" {
    name                = "${var.project-name}-ecs-task-exe-role"
    assume_role_policy  =  data.aws_iam_policy_document.ecs-task-exe-role-policy.json

}

# attach ecs task execution role to iam role
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role" {
    role                = aws_iam_role.ecs-task-exe-role.name
    policy_arn          = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
      
}