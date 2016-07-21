#!/usr/bin/env bash

#remove default java opts
sed -i '/-Xms256m/d' /opt/wso2as-5.3.0/bin/wso2server.sh

sed -i "/port=\"9763\"/a  \\\t\t   proxyPort=\"80\"" /opt/wso2as-5.3.0/repository/conf/tomcat/catalina-server.xml
sed -i "/port=\"9443\"/a  \\\t\t   proxyPort=\"443\"" /opt/wso2as-5.3.0/repository/conf/tomcat/catalina-server.xml
sed -i '/<WebContextRoot>/c\\t<WebContextRoot>/as</WebContextRoot>' /opt/wso2as-5.3.0/repository/conf/carbon.xml

#Changing admin password
if [ -z ${ADMIN_PASSWORD+x} ]; then
    echo "ADMIN_PASSWORD is not set.";
    echo "Generating admin password.";
    ADMIN_PASSWORD=${ADMIN_PASS:-$(pwgen -s 12 1)}
    echo "========================================================================="
    echo "Credentials for the instance:"
    echo
    echo "    user name: admin"
    echo "    password : $ADMIN_PASSWORD"
    echo "========================================================================="
    sed -i "s/.*<Password>admin<\/Password>.*/<Password>$ADMIN_PASSWORD<\/Password>/" /opt/wso2as-5.3.0/repository/conf/user-mgt.xml
else
    echo "ADMIN_PASSWORD set by user.";
fi

#Remove bundles from plugins dir and the bundles.info to minimize jaggery runtime
PLUGINS_DIR_PATH="/opt/wso2as-5.3.0/repository/components/plugins/"
DEFAULT_PROFILE_BUNDLES_INFO_FILE="/opt/wso2as-5.3.0/repository/components/default/configuration/org.eclipse.equinox.simpleconfigurator/bundles.info"
LIST_OF_BUNDLES_FILE="removed-bundles.txt"

while read in; do rm -rf "$PLUGINS_DIR_PATH""$in" && sed -i "/$in/d" "$DEFAULT_PROFILE_BUNDLES_INFO_FILE"; done < $LIST_OF_BUNDLES_FILE

#Remove sample
rm -rf /opt/wso2as-5.3.0/repository/deployment/server/axis2services/*
rm -rf /opt/wso2as-5.3.0/repository/deployment/server/webapps/*

#Calculate max heap size and the perm size for Java Opts
#Check whether TOTAL_MEMORY env variable defined or and not empty
if [[ $TOTAL_MEMORY && ${TOTAL_MEMORY-_} ]]; then
    let MAX_HEAP_SIZE=$TOTAL_MEMORY/512*256
    let PERM_SIZE=$TOTAL_MEMORY/512*64
    JAVA_OPTS="-Xms128m -Xmx"$MAX_HEAP_SIZE"m -XX:PermSize="$PERM_SIZE"m"
    export JAVA_OPTS=$JAVA_OPTS
fi

/opt/wso2as-5.3.0/bin/wso2server.sh
