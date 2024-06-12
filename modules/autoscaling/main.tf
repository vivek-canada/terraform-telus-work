resource "aws_launch_configuration" "example" {
  name          = "example-launch-configuration"
  image_id      = "ami-00b1ba8aad69e699d"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "<html><body><h1>Hostname: $(hostname)</h1></body></html>" > /var/www/html/index.html
              yum -y install httpd
              systemctl start httpd
              systemctl enable httpd
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1

  vpc_zone_identifier = var.vpc_private_subnets

  tag {
    key                 = "telus-asg"
    value               = "example-instance"
    propagate_at_launch = true
  }

  target_group_arns = [var.target_group_arn]

  metrics_granularity = "1Minute"
  force_delete        = true

  health_check_type         = "EC2"
  health_check_grace_period = 300
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.example.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.example.name
}

