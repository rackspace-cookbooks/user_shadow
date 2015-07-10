require_relative 'spec_helper'
require_relative 'ubuntu1404_options'

describe 'user_shadow_test::default on Ubuntu 14.04' do
  before do
    stub_resources
  end

  cached(:chef_run) do
    ChefSpec::SoloRunner.new(UBUNTU1404_SERVICE_OPTS) do |node|
      node_resources(node)
    end.converge('user_shadow_test::default')
  end

  it_behaves_like 'testuser'
end
