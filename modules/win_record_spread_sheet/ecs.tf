# ECS クラスターの作成
resource "aws_ecs_cluster" "win_record_spread_sheet_cluster" {
  name = "win_record_spread_sheet_cluster"
}

# IAM ロールの作成 (タスク実行用)
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# IAM ポリシーのアタッチ
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS タスク定義の作成
resource "aws_ecs_task_definition" "fargate_task" {
  family                   = "win_record_spread_sheet_task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256" # 0.25 vCPU
  memory                   = "512" # 512 MiB
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "app-container"
      image     = "nginx:latest" # 必要に応じてアプリケーションのイメージを指定
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# ECS サービスの作成
resource "aws_ecs_service" "fargate_service" {
  name            = "win_record_spread_sheet_service"
  cluster         = aws_ecs_cluster.win_record_spread_sheet_cluster.id
  task_definition = aws_ecs_task_definition.fargate_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.public_subnets
    security_groups = [var.ecs_security_group_id]
    assign_public_ip = true
  }

  desired_count = 1
}