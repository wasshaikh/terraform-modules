output "password" {
	description = "The password for SASL access to application"
	sensitive = true
	value = ""
}
output "urls_string" {
	description = "String of urls seperated by ',' (commas)"
	value = heroku_addon.default.config_vars
}
output "username" {
	description = "The username for SASL access to application"
	sensitive = true
	value = ""
}
