#!/bin/bash
# ------------------------------------------------------------------------
#
# Copyright 2005-2016 WSO2, Inc. (http://wso2.com)
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

#strip parent directory from upload zip file 

 zip="$UPLOAD_PATH/$PHP_APP_ZIP"
 dest="$WEB_ROOT"
 temp=$(mktemp -d) && unzip -d "$temp" "$zip" && mkdir -p "$dest" && shopt -s dotglob && f=("$temp"/*) &&
    if (( ${#f[@]} == 1 )) && [[ -d "${f[0]}" ]] ; then
        mv "$temp"/*/* "$dest"
    else
        mv "$temp"/* "$dest"
    fi && rm -rf "$temp"

chgrp -R www-data $WEB_ROOT
chmod -R 775 $WEB_ROOT

rm -rf "$UPLOAD_PATH/$PHP_APP_ZIP"

apachectl -DFOREGROUND
