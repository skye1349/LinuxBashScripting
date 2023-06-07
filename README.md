# LinuxBashScripting
How to verify the scripting work 
# temporarily change the names of the certificate files
mv /etc/elasticsearch/fullchain.pem /etc/elasticsearch/fullchain-verify.pem
mv /etc/elasticsearch/privkey.pem /etc/elasticsearch/privkey-verify.pem

# try to access the Elasticsearch cluster using curl
curl --cacert /etc/elasticsearch/fullchain.pem https://logging.xxxx.com.au

# if the connection fails, run the script to restore the correct certificate files
./pem_copy.sh

# try to access the Elasticsearch cluster using curl again
curl --cacert /etc/elasticsearch/fullchain.pem https://logging.xxxx.com.au

# if the connection succeeds, the certificate files have been successfully updated

# restore the original names of the certificate files
mv /etc/elasticsearch/fullchain-verify.pem /etc/elasticsearch/fullchain.pem
mv /etc/elasticsearch/privkey-verify.pem /etc/elasticsearch/privkey.pem
