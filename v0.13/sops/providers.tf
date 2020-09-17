terraform {
	required_version = "~> 0.13.0"

	required_providers {
		sops = {
			source = "registry.terraform.io/carlpett/sops"
			version = "~> 0.5.2"
		}
	}
}
