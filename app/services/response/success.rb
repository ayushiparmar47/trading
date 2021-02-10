# frozen_string_literal: true

class Success < Response::Base
  def success?
    true
  end

  def on_success
    yield(@data, @message, @status)
    self
  end

  def on_error
    self
  end
end
