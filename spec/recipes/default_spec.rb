# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bucky::default' do
  let(:runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  it 'includes the runit::default recipe' do
    expect(chef_run).to include_recipe('runit')
  end

  it 'includes the python::default recipe' do
    expect(chef_run).to include_recipe('python')
  end

  it 'installs the python package bucky' do
    expect(chef_run).to install_python_pip('bucky')
  end

  it 'creates bucky dir' do
    expect(chef_run).to create_directory('/var/log/bucky')
  end

  it 'creates bucky.conf' do
    expect(chef_run).to create_template('/etc/bucky.conf')
  end

  it 'configures the runit service for bucky' do
    expect(chef_run).to enable_runit_service('bucky')
  end
end
