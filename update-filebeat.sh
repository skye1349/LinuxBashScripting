#!/bin/bash

container_id=$(docker ps | grep jobpin-nextjs-prod | awk '{print $1}')

if [ -z "$container_id" ]; then
  echo "No container with image name jobpin-nextjs-prod is running"
  exit 1
fi

sed -i "s#- /var/lib/docker/containers.*#- /var/lib/docker/containers/$container_id*/*.log#" /etc/filebeat/filebeat.yml

# Restart the filebeat service
systemctl restart filebeat

# Print a message indicating that the filebeat.yml file has been updated
echo "filebeat.yml file updated & filebeat restart"
