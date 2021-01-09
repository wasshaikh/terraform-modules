terraform {
	required_version = "~> 0.13"

	required_providers {
		archive = {
			source = "hashicorp/archive"
			version = "~> 2"
		}
		aws = {
			source = "hashicorp/aws"
			version = "~> 3"
		}
		random = {
			source = "hashicorp/random"
			version = "~> 3"
		}
	}
}
