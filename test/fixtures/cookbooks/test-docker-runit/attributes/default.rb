default['image'] = 'socrata/base'

default['env_vars'] = {
  'ENVIRONMENT' => 'staging',
  'ROLE' => 'kitchen-test'
}

default['volumes'] = [
  {
    host: '/tmp',
    container: '/data'
  }
]

default['ports'] = [
  {
    host: 2000,
    container: 3000,
    protocol: 'tcp'
  }
]
