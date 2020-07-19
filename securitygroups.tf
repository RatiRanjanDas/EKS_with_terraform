resource "aws_security_group" "demo-cluster" {
  name        = "terraform-eks-demo-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-eks-demo"
  }
}

resource "aws_security_group_rule" "demo-cluster-ingress-node-tcp" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 30000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.demo-cluster.id
  source_security_group_id = aws_security_group.demo-node.id
  to_port                  = 35000
  type                     = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

  resource "aws_security_group_rule" "demo-cluster-ingress-node-https" {
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.demo-cluster.id
  source_security_group_id = aws_security_group.demo-node.id
  to_port           = 443
  type              = "ingress"
}

