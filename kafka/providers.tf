terraform {
	experiments = [variable_validation]

	required_providers {
		heroku = "~> 2.5"
	}
}
