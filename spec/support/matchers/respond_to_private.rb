# frozen_string_literal: true

class RespondToPrivate < RSpec::Matchers::BuiltIn::RespondTo
  private def find_failing_method_names(actual, filter_method)
    @actual = actual
    @failing_method_names = @names.__send__(filter_method) do |name|
      !@actual.respond_to?(name) && @actual.respond_to?(name, true) &&
        matches_arity?(actual, name)
    end
  end
end

RSpec::Matchers.instance_eval do
  define_method :respond_to_private do |*methods|
    RespondToPrivate.new(*methods)
  end
end
