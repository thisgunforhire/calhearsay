# replace with the name of your application
set :application, "hearsay"
# replace with the HTTP (NOT HTTPS) read-only URL of your Google Code SVN
set :repository,  "http://calhearsay.googlecode.com/svn/trunk/"

# directory for deployment on remote machine
set :deploy_to, "/mnt/app"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

# replace the below with the hostname of your EC2 instance:
set :machine_name, "ec2-75-101-218-95.compute-1.amazonaws.com"
role :app, "#{machine_name}"
role :web, "#{machine_name}"
role :db,  "#{machine_name}", :primary => true
set :use_sudo, false
set :user, "root"

# NOTE!! You should provide the full pathname to a directory containing
# BOTH the private key (id_rsa-cs194) AND public key (id_rsa-cs194.pub).
# If you're on a Unix-like OS, the permissions on both files should be set
# to read/write for the owner, nothing for anyone else.

# Since everyone shares the same deploy.rb, it's convenient for all team
# members to agree to put the same pathname here.  You can try putting
# the files in your home directory, and then setting this line to
#   ssh_options[:keys] = File.join(ENV["HOME"], "id_rsa-cs194")
# but if that doesn't work you can set this to a fixed string.

# ssh_options[:keys] = "/Users/fox/id_rsa-cs194"
ssh_options[:keys] = File.join(ENV["HOME"], "id_rsa-cs194")
puts ssh_options[:keys]

# Mongrel setup
set :apache_proxy_port, 8000
