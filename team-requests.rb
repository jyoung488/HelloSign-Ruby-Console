def print_members(team)
  accounts = team.accounts

  accounts.each do |acct|
    puts <<-EOS
    Account ID: #{acct.account_id}
    Email: #{acct.email_address}
    Locked: #{acct.is_locked}
    Role: #{acct.role_code.upcase}
    EOS
  end
end

def print_team(team)
  puts <<-EOS
  #{team.name.upcase}
  -----
  EOS

  print_members(team)
end

def get_team
  client = initiate_client
  team = client.get_team

  print_team(team)
end

def create_team(name)
  client = initiate_client
  team = client.create_team :name => name

  print_team(team)
end

def update_team(name)
  client = initiate_client
  team = client.update_team :name => name

  print_team(team)
end
