# frozen_string_literal: true

require_relative "air_md/version"

module AirMd
  class Error < StandardError; end

  START_WORD = "```ruby:air"
  END_WORD = "```"

  def exec(str)

  end

  def read_with_md(text)
    is_code = false
    buf = ""
    text.each_line do |line|
      if is_code
        if line.match(END_WORD)
          is_code = false
        else
          buf << line
        end
      else
        if line.match(START_WORD)
          is_code = true
        else
          # skip (markdown sentence)
        end
      end
    end
  end

  def main
    fname = ARGV[0]
    if fname && File.exist?(fname)
      text = File.read(fname)
      if fname =~ /(.+)\.md/
        read_with_md(text)
      elsif fname =~ /(.+)\.rb/
      else
        raise "Please file name (*.md or *.rb)"
    else
      raise "Please file name  (*.md or *.rb)"
    end
  end
end

AirMd.main
