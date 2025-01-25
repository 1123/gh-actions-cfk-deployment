mkdir generated

openssl genrsa -out generated/rootCAkey.pem 2048

openssl req -x509  -new -nodes \
  -key generated/rootCAkey.pem \
  -days 3650 \
  -out generated/cacerts.pem \
  -subj "/C=US/ST=CA/L=MVT/O=TestOrg/OU=Cloud/CN=TestCA"

openssl x509 -in generated/cacerts.pem -text -noout

