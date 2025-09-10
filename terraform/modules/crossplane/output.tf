output "release_name" {
  description = "The name of the Helm release"
  value       = helm_release.crossplane.name
}
