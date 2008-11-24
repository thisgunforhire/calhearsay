namespace :deploy do
  namespace :mongrel do
    set :mongrel_clean, false
    set :mongrel_rails, 'mongrel_rails'
    set :mongrel_conf, nil
    
    def set_mongrel_conf
      set :mongrel_conf, "/etc/mongrel.yml" unless mongrel_conf
    end
    
    desc "Setup mongrel cluster configuration"
    task :configure, :roles => :app do
      set_mongrel_conf
      
      run <<-CMD
      mongrel_rails cluster::configure -e production -p #{apache_proxy_port} -a 127.0.0.1 -c #{current_path} -N 2 -C #{mongrel_conf} --user #{user} --group root -P #{shared_path}/pids/mongrel.pid
    CMD
    end

    desc <<-DESC
  Start Mongrel processes on the app server.  This uses the :use_sudo variable to determine whether to use sudo or not. By default, :use_sudo is
  set to true.
  DESC
    task :start, :roles => :app do
      set_mongrel_conf
      cmd = "#{mongrel_rails} cluster::start -C #{mongrel_conf}"
      cmd += " --clean" if mongrel_clean    
      send(run_method, cmd)
    end
    
    desc <<-DESC
  Restart the Mongrel processes on the app server by starting and stopping the cluster. This uses the :use_sudo
  variable to determine whether to use sudo or not. By default, :use_sudo is set to true.
  DESC
    task :restart, :roles => :app do
      set_mongrel_conf
      cmd = "#{mongrel_rails} cluster::restart -C #{mongrel_conf}"
      cmd += " --clean" if mongrel_clean    
      send(run_method, cmd)
    end
    
    desc <<-DESC
  Stop the Mongrel processes on the app server.  This uses the :use_sudo
  variable to determine whether to use sudo or not. By default, :use_sudo is
  set to true.
  DESC
    task :stop, :roles => :app do
      set_mongrel_conf
      cmd = "#{mongrel_rails} cluster::stop -C #{mongrel_conf}"
      cmd += " --clean" if mongrel_clean    
      send(run_method, cmd)
    end

    desc <<-DESC
  Check the status of the Mongrel processes on the app server.  This uses the :use_sudo
  variable to determine whether to use sudo or not. By default, :use_sudo is
  set to true.
  DESC
    task :status, :roles => :app do
      set_mongrel_conf
      send(run_method, "#{mongrel_rails} cluster::status -C #{mongrel_conf}")
    end
  end

  desc "Custom restart task for mongrel cluster"
  task :restart, :roles => :app, :except => { :no_release => true } do
    deploy.mongrel.restart
  end

  desc "Custom start task for mongrel cluster"
  task :start, :roles => :app do
    deploy.mongrel.start
  end

  desc "Custom stop task for mongrel cluster"
  task :stop, :roles => :app do
    deploy.mongrel.stop
  end

  desc "After-task for deploy:setup to also do mongrel:setup"
  task :after_setup do
    deploy.mongrel.configure
  end
end
