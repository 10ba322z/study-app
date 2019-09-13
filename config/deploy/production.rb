server "3.114.239.184", user: "ec2-user", roles: %w{app db web}
set :ssh_options, keys: "~/.ssh/StudyApp_key.pem"
