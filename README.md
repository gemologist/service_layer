# ServiceLayer

Service Layer Pattern Implementation.

Provide an easy way to write service layer object.  
Services are used to encapsulate application logic business.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'service_layer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install service_layer

## Usage

```ruby
class MatchingService < ApplicationService
  def perform
    # business logic
    Success.new(data: matches_created)
  rescue Geocoder::OverQueryLimitError => exception
    Error.new(data: exception, message: exception.message)
  end
end
```
```ruby
class TendersController < ApplicationController
  def update
    @tender = Tender.find(params[:id])
    result = MatchingService.perform(tender: @tender)

    respond_to do |format|
      if result.success?
        format.html { redirect_to tender_path(@tender), status: :see_other }
      else
        format.html do
          flash.now[:message] = t(result.message)
          render :edit
        end
      end
    end
  end
end
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/adriensldy/service_layer).

Everyone interacting in the ServiceLayer project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gemologist/service_layer/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
