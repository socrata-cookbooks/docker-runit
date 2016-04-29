# Encoding: UTF-8

source 'https://supermarket.chef.io'

metadata
cookbook 'apt'

group :integration do
  cookbook 'test-docker-runit',
           path: 'test/fixtures/cookbooks/test-docker-runit'
end
