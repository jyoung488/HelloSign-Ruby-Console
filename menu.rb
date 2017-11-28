require 'dotenv/load'
require 'hello_sign'
require_relative('account-requests.rb')
require_relative('nonembedded-requests.rb')

def selection(option)
  case option

  when "1"
    account
  when "2"
    update_account
  when "3"
    create_account
  when "4"
    puts "Enter an email to verify:"
    email = input
    if verify_account(email)
      puts "An account for #{email} exists."
    else
      puts "There is no account for #{email}."
    end
  when "5"
    puts "Enter Signature Request ID:"
    id = input
    get_signature_request(id)
  when "6"
    list_signature_requests
  when "7"
  when "8"
  when "9"
  when "10"
  else
    puts "I did not understand that request"
    menu
  end
end

def menu
  puts <<-EOS
  Welcome to the HelloSign Ruby Console App!

  Select from the menu:
  // ACCOUNT
  1 - Get Account
  2 - Update Account
  3 - Create Account
  4 - Verify Account

  // NON-EMBEDDED SIGNATURE REQUEST
  5 - Get Signature Request
  6 - List Signature Requests
  7 - Send Signature Request
  8 - Send with Template
  9 - Send Request Reminder
  10 - Update Signature Request
  11 - Cancel Incomplete Signature Request
  12 - Remove Signature Request Access
  13 - Get Files
  EOS

  response = input
  selection(response)
end
