require "comment_scanner/version"

# CommentScanner will scan for comment blocks in Ruby source.
#
class CommentScanner
  attr_reader :source
  attr_reader :skip_pattern
  
  COMMENT_REGEXP = /^\s*#/
  
  # Creates a new CommentScanner for +source+.
  #
  # Options:
  # [:skip] Skip lines matching this pattern before searching for comments.
  #  
  def initialize(source, options={})
    @source = source.is_a?(Array) ? source : source.each_line.to_a
    @skip_pattern = options[:skip]
  end
  
  # Detect comment blocks immediately before +index+.
  # 
  # Note that +index+ is 0 indexed, where as an editor or stack trace is
  # typically starts at 1.
  # 
  # # Returns +nil+ if there is no match.
  def before(index)
    lines = source[0...index].reverse
    matches = match_comments(lines)
    
    strip_lines(matches).reverse.join.chomp unless matches.empty?
  end
  
  # Detect comment blocks immediately after +index+.  This is generally
  # less useful, you're probably looking for CommentScanner#before.
  # 
  # Note that +index+ is 0 indexed, where as an editor or stack trace is
  # typically starts at 1.
  # 
  # Returns +nil+ if there is no match.
  def after(index)
    lines = source[index+1..-1]
    matches = match_comments(lines)
    
    strip_lines(matches).join.chomp unless matches.empty?
  end
  
  private
  
  # First drops skipped lines, then detects a contiguous block of comments.
  def match_comments(lines)
    if skip_pattern
      lines = lines.drop_while{|line| skip_pattern.match(line) }
    end
    
    lines.take_while{|line| COMMENT_REGEXP.match(line) }
  end
  
  # Strips leading whitespace from comments.
  def strip_lines(lines)
    lines.map(&:lstrip)
  end
  
end
