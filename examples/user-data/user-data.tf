data "cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("shell_action_a.sh", { action_a = var.action_a })
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("shell_action_b.sh", { action_b = var.action_b })
  }

}
