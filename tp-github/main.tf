resource "github_repository" "app" {
  name        = "${var.project_name}-demo"
  description = "Dépôt géré par Terraform - DevOps 4A"
  visibility  = "public"
  has_issues  = true
  topics      = ["terraform", "devops"]
  auto_init   = true # Initialise avec un README
}

# resource "github_branch_protection" "main" {
#  repository_id = github_repository.app.node_id
#  pattern = "main"
#  required_pull_request_reviews {
#  required_approving_review_count = 1
#  dismiss_stale_reviews = true
#  }
# }

resource "github_actions_secret" "db_url" {
  repository      = github_repository.app.name
  secret_name     = "DATABASE_URL"
  plaintext_value = var.db_url
}

resource "github_repository" "existing" {
  name = "tp-terraform-test-import"
}

resource "github_repository" "app_secondary" {
  name        = "${var.project_name}-secondary"
  description = "Deuxième dépôt géré par Terraform"
  visibility  = "public"

  has_issues   = true
  has_wiki     = false
  has_projects = false

  topics = ["terraform", "devops"]

  auto_init = true
}
