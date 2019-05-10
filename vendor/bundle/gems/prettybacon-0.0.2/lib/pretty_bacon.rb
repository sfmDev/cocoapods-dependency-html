require 'bacon'
require 'pretty_bacon/version'

require 'pretty_bacon/spec_dox_output.rb'
require 'pretty_bacon/test_unit_output.rb'
require 'pretty_bacon/context.rb'

module PrettyBacon

  def self.color(color, string)
    case color
    when :red
      "\e[31m#{string}\e[0m"
    when :green
      "\e[32m#{string}\e[0m"
    when :yellow
      "\e[33m#{string}\e[0m"
    when :none
      string
    else
      "\e[0m#{string}\e[0m"
    end
  end

end

module Bacon
  summary_at_exit

  @needs_first_put = true

  module FilterBacktraces
    def handle_summary
      ErrorLog.replace(ErrorLog.split("\n").reject do |line|
        line =~ %r{(gems/mocha|ruby_noexec_wrapper|pretty_bacon)}
      end.join("\n").lstrip << "\n\n")
      super
    end
  end

  extend FilterBacktraces
end
