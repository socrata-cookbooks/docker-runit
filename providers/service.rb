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
  docker_image new_resource.image do
    action :pull
  end

  runit = runit_service new_resource.name do
    action :create
    template_name 'generic'
    cookbook 'docker-runit'
    default_logger true
    start_down true
    options command: [
      'docker run --rm',
      envvars,
      ports,
      volumes,
      new_resource.image,
      new_resource.run_command
    ].join(' ')
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