config=YAML.load_file('config/accounts.yml')
admin = config['admin']

namespace :users do
  desc "TODO"
  task create_admin: :environment do
    u = User.create!(email: admin["email"], password: admin["password"], admin: true)
    if(u.save) then 
      puts("admin created")
    end 
  end
end