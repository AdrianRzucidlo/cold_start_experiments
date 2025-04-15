def lambda_handler(event:, context:)
    event['Records'].each do |record|
      message = record['Sns']['Message']
      puts "Received: #{message}"
    end
  
    nil
  end