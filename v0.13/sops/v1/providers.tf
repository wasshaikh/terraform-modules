terraform {
	required_version = "~> 0.13"

	required_providers {
		sops = {
			source = "carlpett/sops"
			version = "~> 0.5, >= 0.5.2"
		}
	}
}
