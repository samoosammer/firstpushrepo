resource "aws_instance" "first_server" {
  ami                    = "ami-08d70e59c07c61a3a"
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.main.id]


  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/sammer/tf/first/aws_key")
    timeout     = "4m"
  }
}
resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]

  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDX3/zvlB9+42aGb1nPnCHO0r+Amu6AoVDjT4TCVWl0F/ce2skpi4utGF751HnBI545ADHttye5wSlsh62XNsQ3sWcThDLwCvsYY7XX+NDqLDTkSqYVSxJsB/uIAvqqRtypg6h7khSMHD7sj9sc0XuekrZU9nTr6EsQFYBuaF8UjyflRSNXlv8A7bhq4r8AFiAdfHr1vc9DFAdmyBVhV7zm1FMLMbXEJ5YD+yrB4eEecKJvDlI78PSlh+rNPANUzo7UFZuvOUhNEfSsjrg1Vmf2dly69q/o8P6Jv5BLDszGOObgnCrm0NbvkdHolvhda3vX98EpMSpcaoifiWbyrqof root@boss"
}
