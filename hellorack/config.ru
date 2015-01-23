class LastWord
  # Our class will be initialized with another Rack app
  def initialize(app)
    @app = app
  end

  def call(env)
    # First, call '@app'
    status, headers, body = @app.call(env)

    # Append a word nest in an array to the end of the body
    body.first << '. Last word!'

    # Pass our new body on through
    [status, headers, body]
  end
end

class CapitalizeBody
  # Our class will be initialized with another Rack app
  def initialize(app)
    @app = app
  end

  def call(env)
    # First, call '@app'
    status, headers, body = @app.call(env)

    # Iterate through the body, downcasing every second chunk
    lowercase_even_body = body.map { |chunk| chunk.capitalize }

    # Pass our new body on through
    [status, headers, lowercase_even_body]
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
    [200, {"Content-Type" => "text/plain"}, ["Hello from Rack"]]
  end
end

use LastWord
use CapitalizeBody
use ToUpper
run Hello