# LinuxBashScripting

This repository contains two Linux bash scripts:

1. `ssl-cert-copy.sh`: Automates the process of copying the SSL certificate to the target path for Elasticsearch.
2. `update-filebeat.sh`: Automates the updating of the container ID in the `filebeat.yaml` configuration file.

## How to Verify the Scripts Work 

Here are steps you can follow to verify the working of these scripts:

1. Temporarily change the names of the certificate files:
    ```
    mv /etc/elasticsearch/fullchain.pem /etc/elasticsearch/fullchain-verify.pem
    mv /etc/elasticsearch/privkey.pem /etc/elasticsearch/privkey-verify.pem
    ```

2. Try to access the Elasticsearch cluster using curl:
    ```
    curl --cacert /etc/elasticsearch/fullchain.pem https://logging.xxxx.com.au
    ```

3. If the connection fails, run the script to restore the correct certificate files:
    ```
    ./pem_copy.sh
    ```

4. Try to access the Elasticsearch cluster using curl again:
    ```
    curl --cacert /etc/elasticsearch/fullchain.pem https://logging.xxxx.com.au
    ```

    If the connection succeeds, the certificate files have been successfully updated.

5. Restore the original names of the certificate files:
    ```
    mv /etc/elasticsearch/fullchain-verify.pem /etc/elasticsearch/fullchain.pem
    mv /etc/elasticsearch/privkey-verify.pem /etc/elasticsearch/privkey.pem
    ```
