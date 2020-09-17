data "sops_file" "default" {
  	source_file = "${path.module}/${var.file_path}"
}
