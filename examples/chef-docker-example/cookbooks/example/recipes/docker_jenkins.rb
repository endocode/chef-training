#
# Cookbook:: example
# Recipe:: docker_jenkins
#

docker_service 'default' do
    action [:create, :start]
end
  
docker_image 'jenkins' do
    tag 'latest'
    action :pull
    notifies :redeploy, 'docker_container[jenkins_master]'
end

docker_volume 'jenkins_home' do
    action :create
  end

docker_container 'jenkins_master' do
    restart_policy 'always'
    repo    'jenkins'
    port    '8080:8080'
    volumes 'jenkins_home:/var/jenkins_home'
end