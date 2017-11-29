def print_signature_request(request)
  puts <<-EOS
  SIGNATURE REQUEST
  -----
  Signature Request ID: #{request.signature_request_id}
  Test Mode: #{request.test_mode}
  Title: #{request.title}
  Subject: #{request.subject}
  Message: #{request.message}
  Completed: #{request.is_complete}
  Declined: #{request.is_declined}
  Requested by: #{request.requester_email_address}

  Signers:
  EOS
end

def print_signatures(request)
  signatures = request.signatures

  signatures.each do |sig|
    puts <<-EOS
    Signature ID: #{sig.signature_id}
    Signer Name: #{sig.signer_name}
    Signer Email: #{sig.signer_email_address}
    Status: #{sig.status_code}

    EOS
  end
end

def get_signature_request(id)
  client = initiate_client
  unless id.nil?
    request = client.get_signature_request :signature_request_id => id
    print_signature_request(request)
    print_signatures(request)
  else
    puts "Signature Request ID #{id} is not valid!"
  end
end

def list_signature_requests
  client = initiate_client
  requests = client.get_signature_requests :page => 1, :page_size => 3

  requests.each do |req|
    get_signature_request(req.signature_request_id)
  end
end

def send_signature_request
  client = initiate_client
  request = client.send_signature_request(
    test_mode: 1,
    title: 'Ruby Console Test',
    subject: 'Agreement',
    message: 'This is a test signature request',
    signers: [
      email_address: ENV['EMAIL'],
      name: 'Ruby HelloSign'
    ],
    files: ['Files/Psyduck.jpg']
  )

  print_signature_request(request)
  print_signatures(request)
end

def send_with_template
  client = initiate_client
  request = client.send_signature_request_with_template(
    test_mode: 1,
    template_id: '0791109a926aa40470a9b4d46581f3e86ef06dd6',
    title: 'Ruby Console Test with Template',
    message: 'This is a test signature request with template',
    signers: [
      email_address: ENV['EMAIL'],
      name: 'Ruby Template HelloSign',
      role: 'Client'
    ]
  )

  print_signature_request(request)
  print_signatures(request)
end
