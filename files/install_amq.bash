#!/usr/bin/bash

#ActiveMQ Installation:
wget http://champtc.com/amq/apache-activemq-5.15.2-bin.tar.gz
tar xzvf apache-activemq-5.15.2-bin.tar.gz
mv apache-activemq-5.15.2 /opt
adduser activemq -r -U -m
ln -s /opt/apache-activemq-5.15.2/ /opt/activemq
chown -R activemq:activemq /opt/activemq
chown -R activemq:activemq /opt/apache-activemq-5.15.2
ln -s /opt/activemq/bin/activemq /etc/init.d/activemq
chkconfig --add activemq
#set default TTL to 5 mins
sed -i '/<broker xmlns="http:\/\/activemq.apache.org\/schema\/core" brokerName="localhost" dataDirectory="${activemq.data}">/a \ \t<plugins>\n\t\t<!-- If not already set, set ttl to 5 minutes -->\n\t\t<timeStampingBrokerPlugin zeroExpirationOverride="300000"\/>\n\t<\/plugins>' /opt/activemq/conf/activemq.xml
#Change config to use non-root user
sed -i 's/ACTIVEMQ_USER=""/ACTIVEMQ_USER="activemq"/' /opt/activemq/bin/env
#Open firewall ports:
firewall-cmd --zone=public --add-port=61616/tcp --permanent
firewall-cmd --zone=public --add-port=61617/tcp --permanent
firewall-cmd --zone=public --add-port=8161/tcp --permanent
firewall-cmd --zone=public --add-port=8162/tcp --permanent
firewall-cmd --reload
#Start the service:
service activemq start
