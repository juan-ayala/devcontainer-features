#!/usr/bin/env bash

[ -f "../defaults-with-quickstart/mock-cq-quickstart-6.6.0.jar" ] \
    && rm "../defaults-with-quickstart/mock-cq-quickstart-6.6.0.jar"

javac SimpleHttpServer.java
jar --create \
    --file mock-cq-quickstart-6.6.0.jar \
    --main-class=SimpleHttpServer *.class
rm *.class

cp mock-cq-quickstart-6.6.0.jar ../defaults-with-quickstart/
rm mock-cq-quickstart-6.6.0.jar