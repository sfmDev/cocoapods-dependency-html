# coding: utf-8

module Bacon

  # Overrides the SpecDoxzRtput to provide colored output by default
  #
  # Based on https://github.com/zen-cms/Zen-Core and subsequently modified
  # which is available under the MIT License. Thanks YorickPeterse!
  #
  module SpecDoxOutput

    def handle_specification(name)
      if @needs_first_put
        @needs_first_put = false
        puts
      end
      @specs_depth = @specs_depth || 0
      puts spaces + name
      @specs_depth += 1

      yield

      @specs_depth -= 1
      puts if @specs_depth.zero?
    end

    #:nodoc:
    def handle_requirement(description, disabled = false)
      start_time = Time.now.to_f
      error = yield
      elapsed_time = ((Time.now.to_f - start_time) * 1000).round

      if !error.empty?
        puts PrettyBacon.color(:red, "#{spaces}- #{description} [FAILED]")
      elsif disabled
        puts PrettyBacon.color(:yellow, "#{spaces}- #{description} [DISABLED]")
      else
        time_color = case elapsed_time
          when 0..200
            :none
          when 200..500
            :yellow
          else
            :red
          end

        if elapsed_time <= 1
          elapsed_time_string = ''
        elsif elapsed_time >= 1000
          elapsed_time_string = "(#{'%.1f' % (elapsed_time/1000.0)} s)"
        else
          elapsed_time_string = "(#{elapsed_time} ms)"
        end

        elapsed_time_string = PrettyBacon.color(time_color, " #{elapsed_time_string}") unless elapsed_time_string == ''

        puts PrettyBacon.color(:green, "#{spaces}✓ ") + "#{description}" + elapsed_time_string
      end
    end

    #:nodoc:
    def handle_summary
      print ErrorLog  if Backtraces
      unless Counter[:disabled].zero?
        puts PrettyBacon.color(:yellow, "#{Counter[:disabled]} disabled specifications\n")
      end
      result = "%d specifications (%d requirements), %d failures, %d errors" %
        Counter.values_at(:specifications, :requirements, :failed, :errors)
      if Counter[:failed].zero? && Counter[:errors].zero?
        puts PrettyBacon.color(:green, result)
      else
        puts PrettyBacon.color(:red, result)
      end
    end

    #:nodoc:
    def spaces
      return '  ' * @specs_depth
    end
  end
end
