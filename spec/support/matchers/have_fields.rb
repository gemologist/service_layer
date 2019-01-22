# frozen_string_literal: true

RSpec::Matchers.define :have_fields do |**fields|
  match do |actual|
    fields.each do |field, value|
      actual.instance_variable_get(:"@#{field}") == value
    end
  end
end
