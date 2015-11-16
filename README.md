# CommentScanner

Detect comment blocks in Ruby source.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'comment_scanner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install comment_scanner

## Usage

Given a source file that looks like this:

``` ruby
class Sample
  def test
    # Alpha
    # Beta
    assert true
    assert false
  end
end
```

Read the file in: `src = IO.read("sample.rb")`, and then use `CommentScanner` to find comment blocks.

``` ruby
scanner = CommentScanner.new(src)
scanner.before(4) #=> "# Alpha\n# Beta"
scanner.before(1) #=> nil
scanner.after(1)  #=> "# Alpha\n# Beta"
```

Instantiate CommentScanner with a `:skip` parameter to ignore blocks of code before it starts matching.
For instance, ignore leading assertions in the example:

``` ruby
scanner = CommentScanner.new(src, skip: /^\s+assert/)
scanner.before(4) #=> "# Alpha\n# Beta"
scanner.before(5) #=> "# Alpha\n# Beta"
scanner.before(6) #=> nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adamsanderson/comment_scanner.

