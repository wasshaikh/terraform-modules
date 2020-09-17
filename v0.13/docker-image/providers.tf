terraform {
	required_version = "~> 0.13.0"

	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~> 2.58"
		}
		random = {
			source = "hashicorp/random"
			version = "~> 2.3"
		}
		time = {
			source = "hashicorp/time"
			version = "~> 0.5"
		}
	}
}
