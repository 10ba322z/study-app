server "3.114.239.184",
   user: "ec2-user",
   roles: %w{web db app},
   ssh_options: {
       keys: %w(~/.ssh/StudyApp_key.pem),
       forward_agent: true
   }
