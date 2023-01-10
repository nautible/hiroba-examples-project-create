apiVersion: v1
kind: Service
metadata:
  labels:
    app: ${project_name}
  name: ${project_name}
  namespace: ${namespace}
spec:
  ports:
  - name: 8080-8080
    port: 8080
    protocol: TCP
    targetPort: 80
  selector:
    app: ${project_name}
  type: ClusterIP
