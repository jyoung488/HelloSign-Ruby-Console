def get_signature_request(id)
  client = initiate_client
  unless id.nil?
    request = client.get_signature_request :signature_request_id => id
    puts <<-EOS
    Signature Request
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

    signatures = request.signatures

    signatures.each do |sig|
      puts <<-EOS
      Signature ID: #{sig.signature_id}
      Signer Name: #{sig.signer_name}
      Signer Email: #{sig.signer_email_address}
      Status: #{sig.status_code}

      EOS
    end
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
