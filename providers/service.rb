use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

def env_vars
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
    log_size new_resource.log_size
    restart_on_update new_resource.restart_on_update
    options command: [
      'docker run --rm',
      "--name #{new_resource.name}",
      env_vars,
      ports,
      volumes,
      "#{image}:#{new_resource.tag}",
      new_resource.run_command
            ].join(' '),
            log_size: 100000000
  end

  ruby_block "enable-#{new_resource.name}" do
    block do
      Chef::Log.debug("Enabling #{new_resource.name}")
    end
    notifies :enable, runit, :delayed
  end

  ruby_block "start-#{new_resource.name}" do
    block do
      Chef::Log.debug("Starting #{new_resource.name}")
    end
    notifies :start, runit, :delayed
  end

  new_resource.updated_by_last_action(runit.updated_by_last_action?)
end

action :remove do
  runit = runit_service new_resource.name do
    action :disable
  end
  new_resource.updated_by_last_action(runit.updated_by_last_action?)
end
