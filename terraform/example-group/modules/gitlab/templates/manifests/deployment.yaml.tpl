apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: ${project_name}
  name: ${project_name}
  namespace: ${namespace}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${project_name}
  strategy: {}
  template:
    metadata:
      labels:
        app: ${project_name}
    spec:
      containers:
      - image: ${image}
        name: ${project_name}
        resources: {}
