# BraceExpander

Bash-style brace expansion!

## Usage

```ruby
require 'brace_expander'

BraceExpander.expand('foo/{a,b,c}/{1,2}')
# => ['foo/a/1', 'foo/a/2', 'foo/b/1', 'foo/b/2', 'foo/c/1', 'foo/c/2']
```

Just like in bash, braces and commas can be escaped with a backslace:

```ruby
BraceExpander.expand('{a,\,b}')
# => ['a', ',b']
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brace_expander'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brace_expander
