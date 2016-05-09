docker-runit Cookbook
========================

Cookbook to define an lwrp for running a docker container via runit

Requirements
============

Usage
=====

Add docker\_runit to your metadata depends and then create a docker\_runit\_service
resource in your recipe. e.g. 

```ruby
docker_runit_service 'test-image' do
  image node['image']
  environment_variables node['env_vars']
  ports node['ports']
  volumes node['volumes']
  run_command 'sleep 10'
end
```

The attribute can come from an arbirary location or be hardcoded in the recipe
during resource creation.

If you have not already done so, include the default
recipe to install docker.


Contributing
============

Pull requests are welcome, but may not always be accepted, as this cookbook is
specific to Socrata's usage of Samhain. The better route to add any additional
desired attributes would be to write a Samhain wrapper cookbook of your own.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for the new feature; ensure they pass (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

License & Authors
=================
- Author:: Justin Haynes <justin.haynes@socrata.com>

Copyright 2015-2016, Socrata, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
