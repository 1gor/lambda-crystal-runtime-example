require "lambda_runtime"

lambda_event_loop do |event_body|
  puts event_body
  "all is ok"
end
