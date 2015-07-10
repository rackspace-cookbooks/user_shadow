shared_examples_for 'testuser' do
  # Basic tests
  describe user('testuser') do
    it { should exist }
  end

  describe command('chage -l testuser') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match(/Last password change[[:space:]]+: Jul 01, 2015/) }
    its(:stdout) { should match(/Password expires[[:space:]]+: Aug 30, 2015/) }
    its(:stdout) { should match(/Account expires[[:space:]]+: Aug 30, 2030/) }
    its(:stdout) { should match(/Minimum number of days between password change[[:space:]]+: 20/) }
    its(:stdout) { should match(/Maximum number of days between password change[[:space:]]+: 60/) }
    its(:stdout) { should match(/Number of days of warning before password expires[[:space:]]+: 10/) }
  end
end
