# Sms
Short description and motivation.

## Usage

Create Token body:

    t = Sms::Token.new('13912345678')
    t.create code: '1234', message: 'Your token code is 1234'

Send sms:

    t.post!

Validate token code:

    t = Sms::Token.new('13912345678')
    t.valid?('1234')

Don't send sms if it's sent recently:

    t = Sms::Token.new('13912345678')
    t.post! unless t.exist?

Customize Sms service:

In default, Sms.service dones't send real SMS message, there is just a message output,
we can change it to a real service:

    Sms.setup do |s|
      s.service =
        lambda do |token_body|
          Sms::Services::YunPianService.send_text(token_body.mobile_phone, token_body.message)
        end
    end

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'sms'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install sms
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
