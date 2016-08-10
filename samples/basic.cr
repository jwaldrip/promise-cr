require "../src/promise"

promises = [] of Promise(String | Nil)
10.times do |i|
  promises << Promise(String).execute do
    sleep 1
    "finished ##{i + 1}"
  end.then do |result|
    puts result
    "after catch: #{result}"
  end.catch do |ex|
    ex.message
  end.then do |message|
    puts message
  end
end

# Create a promise that rejects and prints the rejection
promises << Promise(String).new do |_, reject|
  sleep 1
  reject.call("Oh no!")
end.catch do |ex|
  puts ex.message
end

# Create a promise that raises and prints the rejection
promises << Promise(String).new do |_, reject|
  sleep 1
  raise "Throw!!!"
end.catch do |ex|
  puts ex.message
end

promises << Promise(String).new do |_, reject|
  sleep 1
  raise "Silent Throw!!!"
end

promises.each(&.await)
