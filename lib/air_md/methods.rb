require "json"

module AirMd
  module Methods
    def h1(str)
      puts "# #{str}"
    end
    
    def h2(str)
      puts "## #{str}"
    end
    
    def h3(str)
      puts "### #{str}"
    end
    
    def h4(str)
      puts "#### #{str}"
    end
    
    def h5(str)
      puts "##### #{str}"
    end
    
    def h6(str)
      puts "###### #{str}"
    end

    def p(str)
      puts str
    end

    def i(str)
      puts "*#{str}*"
    end

    def b(str)
      puts "**#{str}**"
    end
    
    def li(str)
      puts "- #{str}"
    end

    def code(str)
      puts "`#{str}`"
    end

    def pre(str, lang = "")
      puts "```#{lang}\n#{str}\n```"
    end

    def table(ary)
      # TODO
    end

    def read(fname)
      path = File.join(AirMd.dir, fname)
      return File.read(path)
    end

    def json(fname)
      path = File.join(AirMd.dir, fname)
      return JSON.parse(File.read(path))
    end
  end
end
