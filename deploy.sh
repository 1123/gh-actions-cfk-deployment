NAMESPACE=confluent

kubectl create namespace $NAMESPACE || echo "could not create namespace; may already exist"

kubectl apply -f keycloak.yaml

helm repo add confluentinc https://packages.confluent.io/helm

helm upgrade \
  --install operator confluentinc/confluent-for-kubernetes \
   --namespace $NAMESPACE

kubectl get pods --namespace $NAMESPACE

kubectl create -n $NAMESPACE secret generic oauth-jass \
  --from-file=oauth.txt=oauth_jass.txt

kubectl create secret tls ca-pair-sslcerts \
  --cert=certs/generated/cacerts.pem \
  --key=certs/generated/rootCAkey.pem -n $NAMESPACE

kubectl apply -f cp_components.yaml

kubectl create secret generic mds-token \
  --from-file=mdsPublicKey.pem=certs/mds-publickey.txt \
  --from-file=mdsTokenKeyPair.pem=certs/mds-tokenkeypair.txt \
  --namespace $NAMESPACE

# Kafka RBAC credential
kubectl create secret generic mds-client \
       --from-file=bearer.txt=creds/bearer.txt \
       --namespace confluent
# Control Center RBAC credential
kubectl create secret generic c3-mds-client \
       --from-file=bearer.txt=creds/c3-mds-client.txt \
       --namespace confluent
# Connect RBAC credential
kubectl create secret generic connect-mds-client \
       --from-file=bearer.txt=creds/connect-mds-client.txt \
       --namespace confluent
# Schema Registry RBAC credential
kubectl create secret generic sr-mds-client \
       --from-file=bearer.txt=creds/sr-mds-client.txt \
       --namespace confluent
# ksqlDB RBAC credential
kubectl create secret generic ksqldb-mds-client \
       --from-file=bearer.txt=creds/ksqldb-mds-client.txt \
       --namespace confluent
# Kafka Rest Proxy RBAC credential
kubectl create secret generic krp-mds-client \
       --from-file=bearer.txt=creds/krp-mds-client.txt \
       --namespace confluent
# Kafka REST credential
kubectl create secret generic rest-credential \
       --from-file=bearer.txt=creds/bearer.txt \
       --from-file=basic.txt=creds/bearer.txt \
       --namespace confluent

kubectl create secret generic credential \
    --from-file=plain-users.json=creds/creds-kafka-sasl-users.json 
