require "brace_expander/version"

module BraceExpander
  def expand(str)
    combine(expand_internal(str))
  end

  def combine(parts)
    results = ['']
    parts.each do |part|
      if part.kind_of?(Array)
        results = results.product(part).map { |p| p.join }
      else
        results.each { |r| r << part }
      end
    end
    results
  end

  # Expands things inside braces to arrays, everything else to strings
  # @example
  #   expand_internal 'woo{a,b,c}woo'
  #   # => [ 'woo', ['a', 'b', 'c'], 'woo' ]
  def expand_internal(str)
    current_part = ''
    parts = [ current_part ]
    current_group = nil

    in_braces = false
    escaped = false

    str.chars.each_with_index do |char, idx|
      if char == '\\'
        escaped = true
      elsif char == '{' && !escaped
        current_part = ''
        current_group = [ current_part ]
        parts << current_group
        in_braces = true
      elsif char == '}' && !escaped
        in_braces = false
        current_part = ''
        current_group = nil
        parts << current_part
      elsif char == ',' && !escaped
        current_part = ''
        current_group << current_part
      else
        current_part << char
        escaped = false
      end
    end

    parts
  end

  module_function :expand, :expand_internal, :combine
  private_class_method :expand_internal, :combine
end
