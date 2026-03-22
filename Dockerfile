FROM apache/spark:3.5.0

USER root

RUN apt-get update && \
    apt-get install -y python3 python3-pip wget && \
    pip3 install --no-cache-dir jupyter pyspark && \
    mkdir -p /tmp && chmod 777 /tmp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add S3A dependencies for MinIO
RUN wget -P /opt/spark/jars https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar && \
    wget -P /opt/spark/jars https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar

WORKDIR /workspace

EXPOSE 8888 4040

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]