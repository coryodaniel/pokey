#! /bin/sh

echo $(env)
echo $HOSTNAME
cat /proc/self/cgroup | grep -o  -e "docker-.*.scope" | head -n 1 | sed "s/docker-\(.*\).scope/\\1/"

