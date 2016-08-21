# ------------------------------------------------------------------------
#
# Copyright 2016 WSO2, Inc. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License
#
# ------------------------------------------------------------------------

FROM wso2-appcloud/wso2esb:5.0.0-base

ENV CARBON_HOME_PATH /home/wso2user/wso2esb-5.0.0
ENV URL https://github.com/wso2/app-cloud/raw/master/samples/artifacts/HelloESBCompositeApplication_1.0.0.car
ENV TENANT_ID 1
ENV TENANT_DOMAIN ws.com
ENV TENANT_PASSWORD admin12345
ENV CREATE_TENANT true
ENV CAR_DEPLOYMENT_DIR $CARBON_HOME_PATH/repository/deployment/tenants/$TENANT_ID/carbonapps/
ENV CONF_DIR $CARBON_HOME_PATH/repository/conf/
ENV RESOURCES_PATH_CAPPS $INSTALL_PATH/resources/carbonapps/
ENV RESOURCES_PATH_CONF $INSTALL_PATH/resources/conf/
#ENV CAR_DEPLOYMENT_DIR $CARBON_HOME_PATH/repository/deployment/server/carbonapps/
ENV APP_HOST ws-com-tyyhfghfg-1-0-0.apps.cloud.wso2.com
ENV TOTAL_MEMORY 512

RUN mkdir -p $CAR_DEPLOYMENT_DIR

WORKDIR "$CAR_DEPLOYMENT_DIR"
RUN wget "$URL"
COPY "$RESOURCES_PATH_CAPPS" "$CAR_DEPLOYMENT_DIR"
#COPY "$RESOURCES_PATH_CONF" "$CONF_DIR"

RUN sed -i '/<!--HostName>/c\\t<HostName>'$APP_HOST'</HostName>' $CARBON_HOME_PATH/repository/conf/carbon.xml && \
    sed -i '/<!--MgtHostName>/c\\t<MgtHostName>'$APP_HOST'</MgtHostName>' $CARBON_HOME_PATH/repository/conf/carbon.xml
RUN sed -i '/<!--parameter name=\"WSDLEPRPrefix/c\\t<parameter name=\"WSDLEPRPrefix\" locked=\"false\">'$APP_HOST'</parameter>' $CARBON_HOME_PATH/repository/conf/axis2/axis2.xml

WORKDIR "/"

CMD ["bash", "-c", "source /init.sh"]
