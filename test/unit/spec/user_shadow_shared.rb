shared_examples_for 'testuser' do |distro, version|
  it 'creates user testuser' do
    expect(chef_run).to create_user('testuser')
  end

  it 'sets shadow attributes for user testuser' do
    expect(chef_run).to modify_shadow_attributes('testuser').with(
      sp_lstchg: '2015-07-01',
      sp_expire: '2030-08-30',
      sp_min: 20,
      sp_max: 60,
      sp_inact: 10,
      sp_warn: 10
    )
  end
end
