module Puppet::Parser::Functions
  newfunction(:to_bytes, :type => :rvalue, :doc => <<-EOS
    Converts the argument into bytes, for example 4 kB becomes 4096.
    Takes a single string value as an argument.
    EOS
  ) do |arguments|

    raise(Puppet::ParseError, "to_bytes(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    arg = arguments[0]

    if arg.is_a? Numeric then return arg.to_i end

    value,unit = */([0-9.]*)\s*([kMGTE]?)/.match(arg)[1,2]

    value = value.to_f
    case unit
      when nil: value *= (1<<0)
      when 'k': value *= (1<<10)
      when 'M': value *= (1<<20)
      when 'G': value *= (1<<30)
      when 'T': value *= (1<<40)
      when 'E': value *= (1<<50)
    end

    return value.to_i
  end
end

