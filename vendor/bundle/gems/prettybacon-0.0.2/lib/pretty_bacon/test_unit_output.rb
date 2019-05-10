module Bacon

  # Overrides the TestUnitOutput to provide colored result output.
  #
  module TestUnitOutput

    # Represents the specifications as `:`.
    #
    def handle_specification(name)
      indicator = PrettyBacon.color(nil, ':')
      print indicator
      @indicators||=''
      @indicators << indicator
      @last_spec_name = name
      yield
    end

    # Represents the requirements as:
    #
    # - [.] successful
    # - [E] error
    # - [F] failure
    # - [_] skipped
    #
    # After the first failure or error all the other requirements are skipped.
    #
    def handle_requirement(description, disabled = false)
      if @skip_the_rest
        indicator = PrettyBacon.color(nil, '_')
      else
        error = yield
        if !error.empty?
          @skip_the_rest = true
          message = error[0..0]
          color = (message == "E" ? :red : :yellow)
          indicator = PrettyBacon.color(color, message)
          spec_message = @last_spec_name
          desc_message = PrettyBacon.color(color, description)
          @failing_rquirement = "#{spec_message}: #{desc_message}"
        elsif disabled
          indicator =  "D"
        else
          indicator = PrettyBacon.color(nil, '.')
        end
      end
      print indicator
      @indicators||=''
      @indicators << indicator
    end

    def handle_summary
      puts "\n\n"
      puts @failing_rquirement

      first_error = ''
      error_count = 0
      ErrorLog.lines.each do |s|
        error_count += 1 if s.include?('Error:') || s.include?('Informative')
        first_error << s if error_count <= 1
      end
      first_error = first_error.gsub(Dir.pwd + '/', '')
      first_error = first_error.gsub(/lib\//, PrettyBacon.color(:yellow, 'lib') + '/')
      first_error = first_error.gsub(/:([0-9]+):/, ':' + PrettyBacon.color(:yellow, '\1') + ':')
      puts "\n#{first_error}" if Backtraces
      unless Counter[:disabled].zero?
        puts PrettyBacon.color(:yellow, "#{Counter[:disabled]} disabled specifications")
      end
      result = "%d specifications (%d requirements), %d failures, %d errors" %
        Counter.values_at(:specifications, :requirements, :failed, :errors)
      if Counter[:failed].zero? && Counter[:errors].zero?
        puts PrettyBacon.color(:green, result)
      else
        puts PrettyBacon.color(:red, result)
      end
    end

  end

end
