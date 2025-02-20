/*resource "aws_instance" "vault_instance" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.medium"
  key_name      = "vault-key"
  subnet_id     = module.cloud.private_subnet_ids[0]
  security_groups = [aws_security_group.vault_sg.id]

  tags = {
    Name = "Vault-Instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y vault
              vault server -dev -dev-listen-address="0.0.0.0:8200" &
              EOF
}

resource "aws_security_group" "vault_sg" {
  name        = "vault-sg"
  description = "Allow inbound traffic for Vault"
  
  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "vault_policy" "vault_policy_cloud" {
  name   = "vault_policy_cloud"
  policy = <<EOF
path "secret/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "sys/*" {
  capabilities = ["deny"]
}
EOF
}

# Vault IAM part 

resource "aws_iam_role" "vault_role" {
  name               = "vault-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}

resource "aws_iam_policy" "vault_policy" {
  name        = "vault-policy"
  description = "IAM policy for Vault access"
  policy      = data.aws_iam_policy_document.vault_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_vault_policy" {
  role       = aws_iam_role.vault_role.name
  policy_arn = aws_iam_policy.vault_policy.arn
}
*/