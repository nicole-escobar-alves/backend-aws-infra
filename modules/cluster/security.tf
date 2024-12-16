resource "aws_security_group" "eks_cluster_sg" {

  name   = "EKS_Cluster-${var.environment}"
  vpc_id = var.vpc_id

  # Regras de entrada (Inbound)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite tráfego HTTP de qualquer IP
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite tráfego HTTPS de qualquer IP
  }

  # Regras de saída (Outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Permite todos os protocolos
    cidr_blocks = ["0.0.0.0/0"] # Permite tráfego de saída para qualquer IP
  }

  tags = {
    Name = "EKS_Cluster_Security_Group-${var.environment}"
  }

}
