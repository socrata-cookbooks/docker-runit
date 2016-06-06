# Encoding: UTF-8

source 'https://supermarket.chef.io'

metadata

cookbook 'apt', '~> 2.0'
cookbook 'build-essential', '= 2.1.3'
cookbook 'iptables', '0.14.1'

cookbook 'cronic',
         git: 'git@git.socrata.com:azure-chef-repo',
         rel: 'cookbooks/cronic'
cookbook 'docker-legacy',
         github: 'socrata-cookbooks/chef-docker-legacy'

group :integration do
  cookbook 'test-docker-runit',
           path: 'test/fixtures/cookbooks/test-docker-runit'
end
