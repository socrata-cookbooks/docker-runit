include_recipe 'docker-runit'

docker_runit_service 'test-image' do
  if node['docker'] && node['docker']['insecure-registry']
    registry node['docker']['insecure-registry']
  end
  image node['image']
  tag node['tag'] || 'latest'
  log_size node['log_size']
  environment_variables node['env_vars']
  ports node['ports']
  volumes node['volumes']
  run_command 'sleep 10'
end
