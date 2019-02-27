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
  args = "network create --subnet=192.168.0.0/16 --gateway=192.168.0.100 --ip-range=192.168.1.0/24 --driver bridge my_bridge"
}

actions "postgres" {
  uses = "actions/docker/cli@master"
  needs = ["network"]
  args = "run --net=my_bridge --name=my_psql_db postgres --ip=192.168.1.5"
}

actions "network ls" {
  uses = "actions/docker/cli@master"
  needs = ["network"]
  args = "network ls"
}

actions "inspect" {
  uses = "actions/docker/cli@master"
  needs = ["postgres", "network ls"]
  args = "network inspect my_bridge"
}
