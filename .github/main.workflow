workflow "main" {
  on = "push"
  resolves = ["docker run"]
}

action "docker build" {
  uses = "actions/docker/cli@master"
  args = "build -t pokey:latest ."
}

action "docker run" {
  uses = "actions/docker/cli@master"
  needs = ["docker build"]
  args = "run pokey:latest"
}
