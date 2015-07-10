require_relative 'spec_helper'
require_relative 'ubuntu1204_options'

describe 'user_shadow_test::default on Ubuntu 12.04' do
  before do
    stub_resources
  end

  cached(:chef_run) do
    ChefSpec::SoloRunner.new(UBUNTU1204_SERVICE_OPTS) do |node|
      node_resources(node)
    end.converge('user_shadow_test::default')
  end

  it_behaves_like 'testuser'
end
