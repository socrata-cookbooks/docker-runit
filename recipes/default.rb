# Encoding: UTF-8
#
# Cookbook Name:: docker-runit
# Recipe:: default
#
# Copyright 2015-2016, Socrata, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'cronic'
include_recipe 'runit'
include_recipe 'docker-legacy'

file '/usr/local/bin/clean_docker_images' do
  owner 'root'
  group 'root'
  mode 744
  content <<-EOF
  #!/bin/bash
  ionice -c idle docker rm -v $(docker ps -a -q) > /dev/null 2>&1 || /bin/true
  ionice -c idle docker rmi $(docker images -q) > /dev/null 2>&1 || /bin/true
  EOF
end

cronic 'delete old images' do
  command '/usr/local/bin/clean_docker_images'
  time :midnight
end
