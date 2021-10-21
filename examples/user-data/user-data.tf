data "template_file" "action_a" {
  template = file("shell_action_a.sh")
  vars = {
	action_a = var.action_a
  }
}

data "template_file" "action_b" {
  template = file("shell_action_b.sh")
  vars = {
	action_b = var.action_b
	}
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.action_a.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.action_b.rendered
  }

}
