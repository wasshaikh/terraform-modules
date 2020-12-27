variable "environment" {
	default = [{ key = "TERRAFORM_PLACEHOLDER", value = "1" }]
	type = list(object({
		key = string
		value = string
	}))
}
variable "excluded_files" {
	default = []
	type = list(string)
}
variable "handler" {
	type = string
}
variable "name" {
	type = string
}
variable "runtime" {
	type = string
}
variable "source_directory" {
	type = string
}
