require 'dotenv/load'
require 'hello_sign'
require 'date'
require_relative('account-requests.rb')
require_relative('nonembedded-requests.rb')
require_relative('template-requests.rb')
require_relative('team-requests.rb')

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
    send_signature_request
  when "8"
    send_with_template
  when "9"
    puts "Enter Signature Request ID:"
    id = gets.chomp
    puts "Enter email address to send reminder to:"
    email = gets.chomp

    send_reminder(id, email)
  when "10"
    puts "Enter Signature Request ID:"
    request_id = gets.chomp
    puts "Enter Signature ID:"
    sig_id = gets.chomp
    puts "Enter new email address:"
    email = gets.chomp

    update_request(request_id, sig_id, email)
  when "11"
    puts "Enter Signature Request ID:"
    id = gets.chomp

    cancel_request(id)
  when "12"
    puts "Enter Signature Request ID:"
    id = gets.chomp

    remove_access(id)
  when "13"
    puts "Enter Signature Request ID:"
    id = gets.chomp

    get_files(id)
  when "14"
    puts "Enter Template ID"
    id = gets.chomp

    get_template(id)
  when "15"
    list_templates
  when "16"
    puts "Enter Template ID:"
    id = gets.chomp

    puts "Enter email address:"
    email = gets.chomp

    add_template_access(id, email)
  when "17"
    puts "Enter Template ID:"
    id = gets.chomp

    puts "Enter email address:"
    email = gets.chomp

    remove_template_access(id, email)
  when "18"
    puts "Enter Template ID:"
    id = gets.chomp

    delete_template(id)
  when "19"
    puts "Enter Template ID:"
    id = gets.chomp

    get_template_files(id)
  when "20"
    puts "Enter Template ID:"
    id = gets.chomp

    update_template_files(id)
  when "21"
    get_team
  when "22"
    puts "Enter team name:"
    name = gets.chomp

    create_team(name)
  when "23"
    puts "Enter new team name:"
    name = gets.chomp

    update_team(name)
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

  // TEMPLATE
  14 - Get Template
  15 - List Templates
  16 - Add User Access to Template
  17 - Remove User Access to Template
  18 - Delete Template
  19 - Get Template Files
  20 - Update Template Files

  // TEAM
  21 - Get Team
  22 - Create Team
  23 - Update Team
  24 - Delete Team
  25 - Add User to Team
  26 - Remove User from Team
  EOS

  response = input
  selection(response)
end
