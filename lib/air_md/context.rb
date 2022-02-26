# frozen_string_literal: true

require "stringio"

require_relative "./methods"

module AirMd
  class Context
    attr_accessor :text, :result, :first_i, :last_i
    def initialize(text, first_i = nil, last_i = nil)
      @text = text
      @result = +""
      @first_i = first_i
      @last_i = last_i
    end

    include AirMd::Methods
    def exec
      @result = with_captured_stdout do
        eval @text
      end
      puts @result
    end

    def with_captured_stdout
      original_stdout = $stdout
      $stdout = StringIO.new
      yield
      $stdout.string
    ensure
      $stdout = original_stdout
    end
  end
end
