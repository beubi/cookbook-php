#
# Author:: Artur Melo (<artur.melo@beubi.com>)
# Cookbook Name:: php
# Recipe:: module_imap
#
# Copyright 2013, Ubiprism Lda.
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

pkg = value_for_platform(
  %w(centos redhat scientific fedora) => {
    %w(5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8) => "php53-imap",
    "default" => "php-imap"
  },
  "default" => "php5-imap"
)

package pkg do
  action :upgrade
  #notifies :run, 'execute[enable-imap-module]', :immediately
end

execute 'enable-imap-module' do
  command  "php5enmod imap"
  action   :run
  notifies :restart, 'service[apache2]', :delayed
  only_if {::File.exists?("/usr/sbin/php5enmod")}
end
