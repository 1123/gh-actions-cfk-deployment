NAMESPACE=confluent

kubectl delete -f cp_components.yaml
kubectl delete -f keycloak.yaml
kubectl delete secret oauth-jass -n $NAMESPACE
kubectl delete secret ca-pair-sslcerts -n $NAMESPACE
kubectl delete secret mds-token -n $NAMESPACE
kubectl delete secret mds-client -n $NAMESPACE
kubectl delete secret c3-mds-client -n $NAMESPACE
kubectl delete secret connect-mds-client -n $NAMESPACE
kubectl delete secret sr-mds-client -n $NAMESPACE
kubectl delete secret ksqldb-mds-client -n $NAMESPACE
kubectl delete secret krp-mds-client -n $NAMESPACE
kubectl delete secret rest-credential -n $NAMESPACE
kubectl delete secret credential -n $NAMESPACE
kubectl delete namespace $NAMESPACE 
