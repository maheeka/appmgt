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
ENV TENANT_PATH $CARBON_HOME_PATH/repository/tenants/$TENANT_ID/
ENV CAR_DEPLOYMENT_DIR $CARBON_HOME_PATH/repository/tenants/$TENANT_ID/carbonapps/
ENV RESOURCES_PATH $INSTALL_PATH/resources/
ENV APP_HOST ws-com-esbapp-1-0-0.wso2localapps.com
ENV TOTAL_MEMORY 1024

RUN mkdir -p $CAR_DEPLOYMENT_DIR

WORKDIR "$CAR_DEPLOYMENT_DIR"
RUN wget "$URL"
RUN cp -r $RESOURCES_PATH/carbonapps/ $TENANT_PATH
RUN cp -r $RESOURCES_PATH/conf/ $CARBON_HOME_PATH/repository/

RUN sed -i '/<!--HostName>/c<HostName>'$APP_HOST'</HostName>' $CARBON_HOME_PATH/repository/conf/carbon.xml && \
    sed -i '/<!--MgtHostName>/c<MgtHostName>'$APP_HOST'</MgtHostName>' $CARBON_HOME_PATH/repository/conf/carbon.xml
RUN sed -i '/<!--parameter name=\"WSDLEPRPrefix/c<parameter name=\"WSDLEPRPrefix\" locked=\"false\">'$APP_HOST'</parameter>' $CARBON_HOME_PATH/repository/conf/axis2/axis2.xml

WORKDIR "/"

CMD ["bash", "-c", "source /init.sh"]
