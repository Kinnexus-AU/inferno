#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'uri'
require 'open3'

# Configuration
VALIDATOR_URL = 'http://localhost:8080/validate'
INPUT_FILE = 'validation_requests.txt'

# Read validation requests from file
def read_requests(file_path)
  File.readlines(file_path, chomp: true)
end

# Send validation request
def send_validation_request(request_body, index)
  uri = URI.parse(VALIDATOR_URL)

  http = Net::HTTP.new(uri.host, uri.port)
  http.read_timeout = 300 # 5 minutes timeout

  request = Net::HTTP::Post.new(uri.path)
  request['Content-Type'] = 'application/json'

  # Convert Python dict format to JSON using Python
  python_code = <<~PYTHON
    import sys
    import json
    import ast
    data = ast.literal_eval(sys.stdin.read())
    print(json.dumps(data))
  PYTHON

  json_body, status = Open3.capture2('python3', '-c', python_code, stdin_data: request_body)
  unless status.success?
    puts "[#{index}] Error: Failed to convert Python dict to JSON"
    return nil
  end

  request.body = json_body.strip

  puts "\n[#{index}] Sending validation request..."

  begin
    response = http.request(request)

    puts "[#{index}] Status: #{response.code}"

    if response.code == '200'
      result = JSON.parse(response.body)
      puts "[#{index}] Response: #{result}"
    else
      puts "[#{index}] Error: #{response.body}"
    end

    response
  rescue StandardError => e
    puts "[#{index}] Exception: #{e.message}"
    nil
  end
end

# Main execution
def main
  unless File.exist?(INPUT_FILE)
    puts "Error: File '#{INPUT_FILE}' not found"
    exit 1
  end

  requests = read_requests(INPUT_FILE)
  puts "Found #{requests.size} validation requests"

  successful = 0
  failed = 0

  requests.each_with_index do |request_body, index|
    response = send_validation_request(request_body, index + 1)

    if response && response.code == '200'
      successful += 1
    else
      failed += 1
    end

    # Small delay between requests to avoid overwhelming the server
    # sleep(0.5)
  end

  puts "\n" + "=" * 50
  puts "Summary:"
  puts "Total requests: #{requests.size}"
  puts "Successful: #{successful}"
  puts "Failed: #{failed}"
  puts "=" * 50
end

main
