data "template_cloudinit_config" "sshd_config" {
  count         = var.ssh_port != null ? 1 : 0
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/cloud-init-sshd_config.tpl", { ssh_port = var.ssh_port })
  }
}
