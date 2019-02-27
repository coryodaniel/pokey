workflow "main" {
  on = "push"
  resolves = ["docker run", "inspect"]
}

### Build and say hi

action "docker build" {
  uses = "actions/docker/cli@master"
  args = "build -t pokey:latest ."
}

action "docker run" {
  uses = "actions/docker/cli@master"
  needs = ["docker build"]
  args = "run pokey:latest"
}


### build a network and connect nodes?

action "network" {
  uses = "actions/docker/cli@master"
  args = "network create --driver bridge my_bridge"
}

actions "postgres" {
  uses = "actions/docker/cli@master"
  needs = ["network"]
  args = "run --net=my_bridge --name=my_psql_db postgres"
}

actions "inspect" {
  uses = "actions/docker/cli@master"
  needs = ["postgres"]
  args = "network inspect my_bridge"
}
