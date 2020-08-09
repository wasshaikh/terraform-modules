variable "environment" {
	default = []
	type = list(
		object({
			key = string
			value = string
		})
	)
}
variable "image" {
	type = string
}
variable "max" {
	default = 10
	description = "Maximum auto-scale limit."
	type = number
}
variable "min" {
	default = 1
	description = "Minimum auto-scale limit."
	type = number
}
variable "name" {
	type = string

	validation {
		condition = 5 <= length(var.name) && length(var.name) <= 40
		error_message = "Variable 'name' must between 5 - 40 characters in length."
	}
}
variable "type" {
	default = "worker"
	type = string

	validation {
		condition = var.type == "website" || var.type == "worker"
		error_message = "Variable 'type' can only be 'website' or 'worker'."
	}
}
