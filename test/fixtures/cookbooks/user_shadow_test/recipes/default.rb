user 'testuser'

user_shadow 'testuser' do
  sp_lstchg '2015-07-01'
  sp_expire '2030-08-30'
  sp_min 20
  sp_max 60
  sp_inact 10
  sp_warn 10
end
