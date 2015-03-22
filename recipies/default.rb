node[:deploy].each do |app_name, deploy_config|
  # determine root folder of new app deployment
  app_root = "#{deploy_config[:deploy_to]}/current"

  # use template 'resque.yml.erb' to generate 'config/resque.yml'
  template "#{app_root}/config/global/resque.yml" do
    source "resque.yml.erb"
    cookbook "redis_config"

    # set mode, group and owner of generated file
    mode "0660"
    group deploy_config[:group]
    owner deploy_config[:user]

    # define variable “@redis” to be used in the ERB template
    variables(
      :redis => deploy_config[:redis] || {}
    )

    action :create
  end
end
