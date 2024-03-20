# frozen_string_literal: true

require 'digest'

# Signature adding
class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, body = @app.call(env)
    sha = Digest::SHA256.hexdigest body.join
    body << "\n"
    body << sha
    [status, headers, body]
    # END
  end
end
