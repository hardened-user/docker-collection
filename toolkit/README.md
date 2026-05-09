# Toolkit Image

Образ с разными утилитами для диагностики и тестов

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: toolkit
  namespace: default
  labels:
    app.kubernetes.io/name: toolkit
spec:
  containers:
    - name: default
      image: hardeneduser/toolkit
      imagePullPolicy: Always
      command: ["sleep"]
      args: ["infinity"]
      resources:
        limits:
          cpu: "500m"
          memory: "256Mi"
        requests:
          cpu: "50m"
          memory: "64Mi"
```
