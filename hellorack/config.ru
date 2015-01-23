class LastWord
  # Our class will be initialized with another Rack app
  def initialize(app)
    @app = app
  end
 
  def call(env)
    # First, call '@app'
    status, headers, body = @app.call(env)
 
    # Append a word to the end of the body's first chunk
    body.first << '. Last word!'
 
    # Pass our new body on through
    [status, headers, body]
  end
end
 
class DetectBadWords   
  # Our class will be initialized with another Rack app
  def initialize(app)
    @app = app
  end
 
  def call(env)
    # First, call '@app'
    status, headers, body = @app.call(env)
 
    # Set bad_word to a random word. If bad_word is present in body, then 
    # set status to 404 and body to appropriate message.
    bad_word = 'laptop'
    bad_word_present = false
    body.each do |chunk|
      bad_word_present = true if chunk.downcase.include?(bad_word)
      break if bad_word_present
    end
    
    if bad_word_present
      status = 404
      body = ['Not found because this page contains a bad word']
    end
  
    # Pass our new body on through
    [status, headers, body]
  end
end
 
class ToUpper
  # Our class will be initialized with another Rack app
  def initialize(app)
    @app = app
  end
 
  def call(env)
    # First, call '@app'
    status, headers, body = @app.call(env)
 
    # Iterate through the body, upcasing each chunk
    upcased_body = body.map { |chunk| chunk.upcase }
 
    # Pass our new body on through
    [status, headers, upcased_body]
  end
end
 
class Hello
  def self.call(env)
    # 200 indicates success, hash of headers, body is in Array so responds to each
    [200, {"Content-Type" => "text/plain"}, ["Hello from Rack. Laptop"]]
  end
end
 
use LastWord
use DetectBadWords
use ToUpper
run Hello
 
# Structure is LastWord.new(DetectBadWords.new(ToUpper.new(Hello)))