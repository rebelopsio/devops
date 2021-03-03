resource "aws_instance" "ec2-t2-micro-fe-01" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}

resource "aws_instance" "ec2-t2-micro-fe-02" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-2.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}

resource "aws_instance" "ec2-t2-micro-fe-03" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-3.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}

resource "aws_instance" "ec2-t2-micro-fe-04" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-4.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.allow-http.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}