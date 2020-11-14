[
  {
    "name": "webapp",
    "image": "${webapp_docker_image}",
    "cpu": 128,
    "memory": 128,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ],
    "command": [],
    "entryPoint": [],
    "links": [],
    "mountPoints": [],
    "volumesFrom": []
  }
]