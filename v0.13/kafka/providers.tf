terraform {
	required_version = "~> 0.13.0"

	required_providers {
		heroku = {
			source = "heroku/heroku"
			version = "~> 2.5"
		}
	}
}
