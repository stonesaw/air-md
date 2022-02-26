# frozen_string_literal: true

require_relative "air_md/version"
require_relative "air_md/context"

module AirMd
  class Error < StandardError; end

  START_WORD = "```ruby:air"
  END_WORD = "```"
  DISPLAY_COMMENT = true

  def self.dir
    @@dir
  end

  def self.read_with_md(text)
    is_code = false
    buf = +""
    ctx = []
    first_i, last_i = 0, 0
    lines = text.split(/\R/)
    lines.each_with_index do |line, i|
      if is_code
        if line.match(END_WORD) || lines.length == i + 1
          is_code = false
          last_i = i
          ctx << Context.new(buf, first_i, last_i)
          buf = +""
        else
          buf << line << "\n"
        end
      else
        if line.match(START_WORD)
          is_code = true
          first_i = i
        else
          # skip (markdown sentence)
        end
      end
    end
    return ctx
  end

  def self.main
    fname = ARGV[0]
    @@dir = File.join(Dir.pwd, File.dirname(fname))
    output_fname = ARGV[1] || "_output.md"
    
    raise "Please file name (*.md or *.rb)" unless fname
    raise "File not found: #{File.expand_path(fname)}" unless File.exist?(fname)
    

    text = File.read(fname)
    if fname =~ /\.md$/
      contexts = read_with_md(text)
      contexts.each do |ctx|
        ctx.exec
      end
      # replace
      output = +""
      lineno = 0
      contexts.each_with_index do |ctx, i|
        output << text.split(/\R/)[lineno..ctx.first_i - 1].join("\n") << "\n"
        output << "<!-- start: air md -->\n" if DISPLAY_COMMENT
        output << ctx.result
        lineno = ctx.last_i + 1
      end
      output << "<!-- end: air md -->\n" if DISPLAY_COMMENT
      output << text.split(/\R/)[lineno..-1].join("\n") << "\n"

      File.write(output_fname, output)
    elsif fname =~ /\.rb/
      ctx = Context.new(text)
      ctx.exec
      File.write(output_fname, ctx.result)
    else
      STDERR.print "Please file type *.md or *.rb"
    end
  end
end

AirMd.main
