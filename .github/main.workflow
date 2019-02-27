workflow "main" {
  on = "push"
  resolves = ["docker run", "docker scan"]
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

action "docker scan" {
  uses = "actions/docker/cli@master"
  args = "run uzyexe/nmap -sP 172.21.0.0/16"
}
