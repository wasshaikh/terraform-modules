terraform {
	required_version = "~> 0.13"

	required_providers {
		archive = {
			source = "hashicorp/archive"
			version = "~> 1, >= 1.3.0"
		}
		aws = {
			source = "hashicorp/aws"
			version = "~> 3"
		}
		random = {
			source = "hashicorp/random"
			version = "~> 2, >= 2.3.0"
		}
	}
}
