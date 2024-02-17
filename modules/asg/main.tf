

# Define the launch configuration
resource "aws_launch_configuration" "asg_launchconfig" {
    name = "${var.project_name}-launchconfig"
    image_id = var.image_id
    instance_type = "t2.micro"
    security_groups = [var.instance_sg_id]

    user_data = "${file("${path.module}/startup.sh")}"

    ebs_block_device {
      device_name = "/dev/xvdf"
      volume_type = "gp2"
      volume_size = 10
      delete_on_termination = true
      encrypted = true
    }

    root_block_device {
      encrypted = true
      volume_size = 8
      volume_type = "gp2"
    }
    lifecycle {
    create_before_destroy = true
  }
}


# Define the autoscaling group
resource "aws_autoscaling_group" "asg" {
  name                    = "${var.project_name}-asg"
  launch_configuration    = aws_launch_configuration.asg_launchconfig.name
  min_size                = 1
  max_size                = 3
  desired_capacity        = 1
  vpc_zone_identifier     = [var.private_subnet_az1_id, var.private_subnet_az2_id]
  target_group_arns = [var.alb_tg_arn]
  health_check_type = "ELB"

  # launch_template {
  #   id      = aws_launch_template.asg_template.id
  #   version = aws_launch_template.asg_template.latest_version
  # }
  tag {
    key = "Name"
    value = "${var.project_name}-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_alb_attachement" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn =  var.alb_tg_arn
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.project_name}-asg-down-policy"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 120
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.project_name}-asg-up-policy"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 120
}

