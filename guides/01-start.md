# Start

This workshop guide is designed for learning _how to build event-driven, serverless functions in Kubernetes_. The following are required from you before joining the workshop:

- Knowledge of cloud computing and building cloud-native apps/service.
- Basic understanding and familiarity with patterns like serverless functions or event-driven architecture.
- Basic familiarity with Kubernetes.
- Basic knowledge of JavaScript (because the examples are in JavaScript).

JavaScript knowledge is not strictly required because the code snippet will be briefly explained, and the concept can be applied to other popular programming languages. The last section of the workshop, you'd get to build something from your imagination and use whatever programming language you prefer.

You would need the following tools installed in order to code along in the workshop.

- Node.js [v18.x](https://nodejs.org/en/download/current/) and above.
- A Kubernetes cluster.
- [Knative](https://knative.dev/docs/install/yaml-install/serving/install-serving-with-yaml/) installed and configured on your k8s cluster.

Follow the instruction in the [Node.js](https://nodejs.org/en/download/current/) installation page to install Node.js. I provide set up instructions for setting up Kubernetes and Knative below.

## Set Up A Kubernetes Cluster

You can use a local cluster using Kind, Docker Desktop, or Rancher Desktop. For this workshop, I'll provide instructions for working with Kubernetes on [Civo](civo.com) Cloud. In order to follow the set up instructions, pls make sure you have the following CLI tools installed:

- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [Civo CLI](https://github.com/civo/cli#set-up)

> The links should take you to the installation page.

### Set Up A Civo Cluster

You need a Civo account in order to create a Civo Kubernetes cluster. If you don't have one, go to [dashboard.civo.com/signup](https://dashboard.civo.com/signup). After you're registered, follow the instruction below to set up the CLI and create a k8s cluster.

1. Add your API Key to the Civo CLI using the command `civo apikey save <Name for your API Key> <API key>`. You can find your API key on Civo dasboard by going to [**Account > Settings > Security**](https://dashboard.civo.com/security).

2. Ensure that the Civo CLI is using the correct API key by running the command `civo apikey current <Name for your API Key>`.

3. Create the cluster using the command `civo kubernetes create workshop-cluster --size "g4s.kube.medium" --nodes 2 --wait --save --merge --region FRA1 --switch -r Traefik-v2-nodeport`

### Set Up Knative

I've prepared a couple of bash scripts that you can use to install and configure Knative in your cluster. Open your terminal and run the following commands:

1. Installing Knative serving using the command `curl -sL https://raw.githubusercontent.com/pmbanugo/k8s-eda-workshop/main/scripts/01-serving.sh | sh`.

2. Install and configure Contour as the networking layer using the command `curl -sL https://raw.githubusercontent.com/pmbanugo/k8s-eda-workshop/main/scripts/02-contour.sh | sh`.

3. Configure additional extensions such as automatic TLS provisioning for Knative services `curl -sL https://raw.githubusercontent.com/pmbanugo/k8s-eda-workshop/main/scripts/03-serving-extensions.sh | sh`
