# # encoding: utf-8

# Inspec test for recipe tomcat_centos::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


describe command 'curl http://localhost:80' do
  its(:stdout) { should match /Tomcat/ }
end

describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed}
end

describe group('tomcat')do
  it { should exist }
end

describe user('tomcat') do
  it { should exist }
  it { should belong_to_group('tomcat')}
  it { should have_home_directory('/opt/tomcat')}
end

describe file('/opt/tomcat') do
  it { should exist }
  it { should be_a_directory }
end

describe file('opt/tomcat/conf') do
  it { should exist }
  it { should be_mode 70}
end

%w[ webapps work temp logs].each do
  describe file("/opt/tomcat/#{path}") do
    it { should exist }
    it { should be_owned_by 'tomcat'}
end
