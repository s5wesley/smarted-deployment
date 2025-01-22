#!/bin/bash

# Set variables
REPO_NAME="smartedu-deployment-repo"
DEPLOYMENT_FILE="deployment.yaml"

# Create a new directory for the repository
mkdir "$REPO_NAME"
cd "$REPO_NAME" || exit

# Initialize a new Git repository
git init

# Create the deployment.yaml file
cat <<EOF > "$DEPLOYMENT_FILE"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: smartedu-app
  labels:
    app: smartedu-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: smartedu-app
  template:
    metadata:
      labels:
        app: smartedu-app
    spec:
      containers:
      - name: smartedu-app
        image: bulawesley/smartedu:v1
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: smartedu-app-service
  labels:
    app: smartedu-app
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
  selector:
    app: smartedu-app
EOF

# Add the file to the Git repository
git add "$DEPLOYMENT_FILE"

# Commit the changes
git commit -m "Add Kubernetes deployment.yaml for smartedu-app"

# Print success message
echo "Repository $REPO_NAME created with deployment.yaml"

