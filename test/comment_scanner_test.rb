require 'test_helper'
require 'stringio'

class CommentScannerTest < Minitest::Test
    
  def test_that_it_has_a_version_number
    refute_nil ::CommentScanner::VERSION
  end
  
  def test_returns_nil_when_no_comment
    src = strip_heredoc <<-RUBY
      # This will not match
      class Example
        1 + 1
    RUBY
    
    comment = CommentScanner.new(src).before(2)
    assert_nil comment
  end
  
  def test_detects_leading_comments
    src = strip_heredoc <<-RUBY
      class Example
        # Alpha
        # Beta
        1 + 1
    RUBY
    
    comment = CommentScanner.new(src).before(3)
    assert_equal "# Alpha\n# Beta", comment
  end
    
  def test_detects_trailing_comments
    src = strip_heredoc <<-RUBY
      class Example
        1 + 1
        # Alpha
        # Beta
    RUBY
    
    comment = CommentScanner.new(src).after(1)
    assert_equal "# Alpha\n# Beta", comment
  end
  
  def test_skips_lines_before_matching_a_pattern
    src = strip_heredoc <<-RUBY
      class Example
        # Alpha
        # Beta
        assert true
        assert false
    RUBY
    
    comment = CommentScanner.new(src, skip: /^\s+assert/).before(4)
    assert_equal "# Alpha\n# Beta", comment
  end
  
  def test_can_accept_an_io_object
    src = strip_heredoc <<-RUBY
      class Example
        # Alpha
        # Beta
        1 + 1
    RUBY
    
    io = StringIO.new(src)
    comment = CommentScanner.new(io).before(3)
    assert_equal "# Alpha\n# Beta", comment
  end
  
  private
  
  # This is copied from ActiveSupport 4.2's String#strip_heredoc.
  # 
  def strip_heredoc(str)
    indent = str.scan(/^[ \t]*(?=\S)/).min.size rescue 0
    str.gsub(/^[ \t]{#{indent}}/, '')
  end
  
end