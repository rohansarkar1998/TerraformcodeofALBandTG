resource aws_lb_target_group "target_group" {
    count       = length(var.target_group["name"])
    name        = var.target_group["name"][count.index]
    port       = var.target_group["ports"][count.index]
    protocol    = var.target_group["protocol"]
    target_type = var.target_group["target_type"]
    vpc_id      = var.target_group["vpc_id"]


    health_check {
        protocol = var.target_group.health_check["protocol"]
        path=var.target_group.health_check["path"]
        port       = var.target_group["ports"][count.index]

  }
}

resource "aws_lb_target_group_attachment" "attachments1" {
 
  count       = length(var.target_group["name"]) 
  target_group_arn = aws_lb_target_group.target_group[count.index].arn
  target_id = var.target_group_attachment1.instnaces
  port= aws_lb_target_group.target_group[count.index].port
  
  
}

resource "aws_lb_target_group_attachment" "attachments2" {
 
  count       = length(var.target_group["name"]) 
  target_group_arn = aws_lb_target_group.target_group[count.index].arn
  target_id = var.target_group_attachment2.instnaces
  port= aws_lb_target_group.target_group[count.index].port
  
  
}

resource "aws_security_group" "loadbalancerSG"{
     
     name        = var.security_groups["name"]
     description = var.security_groups["description"]
     vpc_id      = var.security_groups["vpc_id"]

    ingress {
      
      description      = var.security_groups.securitygroupport1["description"]
      to_port           = var.security_groups.securitygroupport1["to_port"]     
      from_port          = var.security_groups.securitygroupport1["from_port"]
      protocol         = var.security_groups.securitygroupport1["protocol"]
      cidr_blocks      = var.security_groups.securitygroupport1["cidr_blocks"]    
  }

  ingress {
      
      description      = var.security_groups.securitygroupport2["description"]
      to_port           = var.security_groups.securitygroupport2["to_port"]     
      from_port          = var.security_groups.securitygroupport2["from_port"]
      protocol         = var.security_groups.securitygroupport2["protocol"]
      cidr_blocks      = var.security_groups.securitygroupport2["cidr_blocks"]   
  }

  ingress {
      
      description      = var.security_groups.securitygroupport3["description"]
      to_port           = var.security_groups.securitygroupport3["to_port"]     
      from_port          = var.security_groups.securitygroupport3["from_port"]
      protocol         = var.security_groups.securitygroupport3["protocol"]
      cidr_blocks      = var.security_groups.securitygroupport3["cidr_blocks"]   
  }

  ingress {
      
      description      = var.security_groups.securitygroupport4["description"]
      to_port           = var.security_groups.securitygroupport4["to_port"]     
      from_port          = var.security_groups.securitygroupport4["from_port"]
      protocol         = var.security_groups.securitygroupport4["protocol"]
      cidr_blocks      = var.security_groups.securitygroupport4["cidr_blocks"]   
  }


  egress {
      
      to_port          = var.security_groups.outbound["to_port"]
      from_port          = var.security_groups.outbound["from_port"]
      protocol         = var.security_groups.outbound["protocol"]
      cidr_blocks      = var.security_groups.outbound["cidr_blocks"]
 
  }
}


resource "aws_lb" "application-lb" {
  name               =  var.application_loadbalancer["name"]
  internal           = false
  load_balancer_type = var.application_loadbalancer["load_balancer_type"]
  subnets            = var.application_loadbalancer["subnets"]
  security_groups    = [aws_security_group.loadbalancerSG.id]
  ip_address_type    = "ipv4"

}

resource "aws_lb_listener" "alb-listener" {
  count       = length(var.target_group["name"])
  load_balancer_arn = aws_lb.application-lb.arn
  port              = aws_lb_target_group.target_group[count.index].port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn =  aws_lb_target_group.target_group[count.index].arn
  }
}

