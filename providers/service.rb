use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

def envvars
  new_resource.environment_variables.map do |k, v|
    "-e #{k}=#{v}"
  end.join(' ')
end

def ports
  new_resource.ports.map do |p|
    "-p #{p[:host]}:#{p[:container]}/#{p[:protocol]}"
  end.join(' ')
end

def volumes
  new_resource.volumes.map do |v|
    "-v #{v[:host]}:#{v[:container]}"
  end.join(' ')
end

action :create do
  if new_resource.registry
    image = "#{new_resource.registry}/#{new_resource.image}"
  else
    image = "#{new_resource.image}"
  end

  docker_legacy_image image do
    tag new_resource.tag
    action :pull
  end

  runit = runit_service new_resource.name do
    action [:enable, :start]
    template_name 'generic'
    cookbook 'docker-runit'
    default_logger true
    start_down true
    options command: [
      'docker run --rm',
      envvars,
      ports,
      volumes,
      "#{image}:#{new_resource.tag}",
      new_resource.run_command
    ].join(' ')
  end

  new_resource.updated_by_last_action(runit.updated_by_last_action?)

  if new_resource.updated_by_last_action?
    ruby_block "restart-#{new_resource.name}" do
      block do
        Chef::Log.debug("Restarting #{new_resource.name}")
      end
      notifies :restart, runit, :immediately
    end
  end

end

action :remove do
  runit = runit_service new_resource.name do
    action :disable
  end
  new_resource.updated_by_last_action(runit.updated_by_last_action?)
end
