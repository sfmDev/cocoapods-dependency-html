module Bacon

  class Context

    # Add support for disabled specs
    #
    def xit(description, &block)
      Counter[:disabled] += 1
      Bacon.handle_requirement(description, true) {[]}
    end

    # Add support for running only focused specs
    #
    # @note The implementation is a hack because bacon evaluates Context#it
    #       immediately. Therefore this method is intended to be **temporary**.
    #
    # @example
    #
    # module BaconFocusedMode; end
    #
    # describe "A Context" do
    #   it "will *not* runt" do; end
    #   fit "will runt" do; end
    # end
    #
    #
    def fit(description, &block)
      origina_it(description, &block)
    end

    # Add support for focused specs
    #
    alias :origina_it :it
    def it(description, &block)
      unless defined?(::BaconFocusedMode)
        origina_it(description, &block)
      end
    end
  end

end
