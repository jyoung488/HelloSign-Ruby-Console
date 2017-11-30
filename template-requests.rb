def print_template(temp)
  puts <<-EOS
  TEMPLATE
  -----
  Template ID: #{temp.template_id}
  Title: #{temp.title}
  Embedded: #{temp.is_embedded}

  EOS
end

def print_signer_roles(temp)
  signers = temp.signer_roles

  puts "SIGNER ROLES"
  signers.each do |sig|
    puts <<-EOS
    Signer Role: #{sig.name}
    Signer Order: #{sig.order}
    EOS
  end
end

def print_custom_fields(temp)
  fields = temp.custom_fields

  puts "CUSTOM FIELDS"
  fields.each do |field|
    puts <<-EOS
    Field Name: #{field.name}
    Field Type: #{field.type}
    Signer: #{field.signer}
    Required: #{field.required}
    EOS
  end
end

def get_template(id)
  client = initiate_client
  template = client.get_template :template_id => id

  print_template(template)
  print_signer_roles(template)
  print_custom_fields(template)
end

def list_templates
  client = initiate_client
  templates = client.get_templates :page => 1, :page_size => 5

  templates.each do |temp|
    print_template(temp)
  end
end

def add_template_access(id, email)
  client = initiate_client
  template = client.add_user_to_template :template_id => id, :email_address => email

  print_template(template)
end

def remove_template_access(id, email)
  client = initiate_client
  template = client.remove_user_from_template :template_id => id, :email_address => email

  print_template(template)
end

def delete_template(id)
  client = initiate_client
  template = client.delete_template :template_id => id

  puts "Template ID #{id} deleted!"
end

def get_template_files(id)
  client = initiate_client
  template = client.get_template_files :template_id => id, :get_url => false
  # #get_template_files method in Ruby SDK missing functionality to handle parameters
  # added this on 11/29, waiting to merge PR

  # p template
  # puts <<-EOS
  # Access your file here:
  # #{template["file_url"]}
  # EOS
end

def update_template_files(id)
  client = initiate_client
  template = client.update_template_files :template_id => id, :file_url => 'http://www.pdf995.com/samples/pdf.pdf'

  puts "Template ID #{template.template_id} updated!"
end
