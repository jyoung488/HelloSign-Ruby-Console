def initiate_client
  HelloSign::Client.new :api_key => ENV['API_KEY']
end

def input
  gets.chomp
end

def account
  client = initiate_client
  account = client.get_account
  puts <<-EOS
    Get Account
    -----
    Account ID: #{account.account_id}
    Email Address: #{account.email_address}
    Callback URL: #{account.callback_url}
    HelloSign Paid Account: #{account.is_paid_hs}
    HelloFax Paid Account: #{account.is_paid_hf}
    API Signature Requests Left: #{account.quotas.api_signature_requests_left}
  EOS
end

def update_account
  client = initiate_client
  puts "Enter your new account callback URL"
  url = input
  account = client.update_account :callback_url => url

  puts <<-EOS
    Update Account
    -----
    Account ID: #{account.account_id}
    Email Address: #{account.email_address}
    Callback URL: #{account.callback_url}
    HelloSign Paid Account: #{account.is_paid_hs}
    HelloFax Paid Account: #{account.is_paid_hf}
    API Signature Requests Left: #{account.quotas.api_signature_requests_left}
  EOS
end

def verify_account(email)
  client = initiate_client
  client.verify :email_address => email
end

def create_account
  client = initiate_client

  puts "Enter email you'd like to use for the new HelloSign account"
  email = input

  if verify_account(email)
    puts "An account for #{email} already exists!"
  else
    account = client.create_account :email_address => email

    puts <<-EOS
      Create Account
      -----
      Account ID: #{account.account_id}
      Email Address: #{account.email_address}
      Callback URL: #{account.callback_url}
      HelloSign Paid Account: #{account.is_paid_hs}
      HelloFax Paid Account: #{account.is_paid_hf}
      API Signature Requests Left: #{account.quotas.api_signature_requests_left}
    EOS
  end
end
