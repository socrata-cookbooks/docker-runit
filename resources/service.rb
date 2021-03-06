actions :create, :remove
default_action :create
attribute :name, kind_of: String, name_attribute: true
attribute :registry, kind_of: String, default: nil
attribute :image, kind_of: String
attribute :tag, kind_of: String
attribute :environment_variables, kind_of: Hash, default: {}
attribute :log_size, kind_of: Integer, default: nil
attribute :volumes, kind_of: Array, default: []
attribute :ports, kind_of: Array, default: []
attribute :run_command, kind_of: String, default: ''
attribute :restart_on_update, kind_of: [TrueClass, FalseClass], default: true
