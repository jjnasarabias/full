Using gatekeeper for testing in a local cluster, in mind of changing to azure policies, the best solution is to use a gatekeeper Assign CRD

At first the idea was to use ConstraintTemplate and Constraint with a Rego custom method. However, this kind of CRD's only act on a validation webhook. And to add the same labels as our namespace or workload, it's required a mutating webhook.
Labels are copied for workloads pod template spec to avoid bottleneck on each pod creation, having the mutation only on workloads creation
It's advisable to apply in workloads instead of namespaces. Because the mutation webhook happens when the workload is created or applied. If it's added or changed the namespace label, the workload will not be updated and, therefore, pod template spec will not be updated

## [Assign CRD](https://open-policy-agent.github.io/gatekeeper/website/docs/mutation/#setting-imagepullpolicy-of-all-containers-to-always-in-all-namespaces-except-namespace-system) example

```yaml
apiVersion: mutations.gatekeeper.sh/v1
kind: Assign
metadata:
  name: copy-workload-label-to-pod-template
spec:
  applyTo:
    - groups: ["apps"]
      versions: ["v1"]
      kinds: ["Deployment", "StatefulSet", "DaemonSet"]
  match:
    scope: Namespaced
    labelSelector:
      matchLabels:
        xpto.test.com/test: "test"
  location: 'spec.template.metadata.labels."xpto.test.com/test"'
  parameters:
    assign:
      value: "test"
```

- **Disadvantages**:
    - Requires a manifest per each targeted label
    - It's more demanding

- **Advantages**:
    - Be explicit and not implicit
    - Exclude the need for an external webhook


## Testing
- Create a Kubernetes cluster

- Deploy gatekeeper

    - `helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts`

    - `kubectl create gatekeeper-system`

    - `helm -n gatekeeper-system install gatekeeper gatekeeper/gatekeeper`

- Apply Assign Manifests

```shell
cat << EOF | kubectl apply -f -
apiVersion: mutations.gatekeeper.sh/v1
kind: Assign
metadata:
  name: copy-workload-label-to-pod-template
spec:
  applyTo:
    - groups: ["apps"]
      versions: ["v1"]
      kinds: ["Deployment", "StatefulSet", "DaemonSet"]
  match:
    scope: Namespaced
    labelSelector:
      matchLabels:
        xpto.test.com/test: "test"
  location: 'spec.template.metadata.labels."xpto.test.com/test"'
  parameters:
    assign:
      value: "test"
---
apiVersion: mutations.gatekeeper.sh/v1
kind: Assign
metadata:
  name: copy-namespace-label-to-pod-template
spec:
  applyTo:
    - groups: ["apps"]
      versions: ["v1"]
      kinds: ["Deployment", "StatefulSet", "DaemonSet"]
  match:
    scope: Namespaced
    namespaceSelector:
      matchLabels:
        xpto.test.com/namespace-test: "test"
  location: 'spec.template.metadata.labels."xpto.test.com/namespace-test"'
  parameters:
    assign:
      value: "test"
EOF
```

- Create namespaces
```shell
kubectl create ns with-labels
kubectl create ns without-labels
kubectl label ns with-labels xpto.test.com/namespace-test=test
```

- Create deployment on each namespace
```
cat << EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test
  namespace: without-labels
  labels:
    app: test
    xpto.test.com/test: "test"
spec:
  replicas: 1
  selector:
    matchLabels:
      app: test
  template:
    metadata:
      labels:
        app: test
    spec:
      containers:
      - name: test
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test
  namespace: with-labels
  labels:
    app: test
    xpto.test.com/test: "test"
spec:
  replicas: 1
  selector:
    matchLabels:
      app: test
  template:
    metadata:
      labels:
        app: test
    spec:
      containers:
      - name: test
        image: nginx:latest
        ports:
        - containerPort: 80
EOF
```

## Results

- Assign CRD for workloads has been applied
```shell
k -n without-labels get pods --no-headers --show-labels
test-7cbf4966fb-ww2jv   1/1   Running   0     2m21s   app=test,pod-template-hash=7cbf4966fb,xpto.test.com/test=test
```

- Assign CRD for workloads and namesapce has been applied
```shell
 k -n with-labels get pods --no-headers --show-labels
test-659bd87c5-684wf   1/1   Running   0     90s   app=test,pod-template-hash=659bd87c5,xpto.test.com/namespace-test=test,xpto.test.com/test=test
```
