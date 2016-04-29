include_recipe 'docker-runit'

docker_runit_service 'test-image' do
  image node['image']
  environment_variables node['env_vars']
  ports node['ports']
  volumes node['volumes']
  run_command 'sleep 10'
end
