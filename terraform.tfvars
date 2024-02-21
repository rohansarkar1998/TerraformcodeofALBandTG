target_group={
    name=["target-group1","target-group2","target-group3","target-group4"]
    ports=[80,81,83,84]
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id      = "vpc-076c3c0fe6d0dc6e7"

    health_check={
        protocol="HTTP"
        path="/34095"
        ports=[80,81,83,84]
    }


}

target_group_attachment1={

    instnaces="172.31.14.213"
   
}

target_group_attachment2={
    instnaces="172.31.37.36"
    
}

security_groups ={
    name="loadbalancerSG1"
    description="Load Balancer Security Group"
    vpc_id= "vpc-076c3c0fe6d0dc6e7"
    

    securitygroupport1={
        description="http inbound rule"
        to_port=80
        from_port=80
        protocol="tcp"
        cidr_blocks=["54.0.0.0/8","10.0.0.0/8"]
    }
    
    securitygroupport2={
        description="http inbound rule"
        to_port=81
        from_port=81
        protocol="tcp"
        cidr_blocks=["54.0.0.0/8","10.0.0.0/8"]
    }

    securitygroupport3={
        description="http inbound rule"
        to_port=83
        from_port=83
        protocol="tcp"
        cidr_blocks=["54.0.0.0/8","10.0.0.0/8"]
    }

    securitygroupport4={
        description="http inbound rule"
        to_port=84
        from_port=84
        protocol="tcp"
        cidr_blocks=["54.0.0.0/8","10.0.0.0/8"]
    }

    outbound={

           from_port        = 0
           to_port          = 0
           protocol         = "-1"
           cidr_blocks      = ["0.0.0.0/0"]

    }


}


application_loadbalancer={

  name               = "applicationLB"
  internal           = false
  load_balancer_type = "application"
  vpc_id      = "vpc-076c3c0fe6d0dc6e7"
  subnets            = ["subnet-0b6e21369e598302f","subnet-062a2579d231bd737","subnet-0c864e4615fbfa4fb"]
  ip_address_type    = "ipv4"


}