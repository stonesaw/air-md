# air-md
example: first

```ruby:air-md
h2 "convert ruby code to markdown"
p "inline .md file"
p "generate markdown with ruby code"

h2 "libraries"
pkg = json "./package.json"
pkg["dependencies"].each {|name, ver|
  li "**#{name}** *#{ver}*"
}

```
