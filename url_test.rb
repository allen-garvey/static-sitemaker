require_relative "ag_url"
require "test/unit"
 
class TestAG_URL < Test::Unit::TestCase
 
  def test_tld
    assert_equal(AG_URL::Url.new("http://allengarvey.com").tld, AG_URL::Url.new("http://www.allengarvey.com").tld)
    assert_equal(AG_URL::Url.new("https://allengarvey.com").tld, AG_URL::Url.new("http://www.allengarvey.com").tld)
    assert_equal(AG_URL::Url.new("https://allengarvey.com").tld, AG_URL::Url.new("http://allengarvey.com").tld)
    assert_equal(AG_URL::Url.new("https://www.allengarvey.com").tld, AG_URL::Url.new("http://www.allengarvey.com").tld)
    assert_equal(AG_URL::Url.new("https://allengarvey.com").tld, AG_URL::Url.new("http://www.allengarvey.com/").tld)
  end

  def test_equality
  	assert_equal(AG_URL::Url.new("http://www.allengarvey.com/"), AG_URL::Url.new("http://www.allengarvey.com"))
  	assert_equal(AG_URL::Url.new("http://www.allengarvey.com////"), AG_URL::Url.new("http://www.allengarvey.com"))
  end

  def test_relative_path
  	assert_equal(AG_URL::Url.new("http://www.allengarvey.com/").relative_path, AG_URL::Url.new("http://www.allengarvey.com").relative_path)
  	assert_equal('/hello/index.html', AG_URL::Url.new("http://www.allengarvey.com/hello/index.html").relative_path)
  	assert_equal('/', AG_URL::Url.new("http://www.allengarvey.com").relative_path)
  	assert_equal('/', AG_URL::Url.new("http://www.allengarvey.com/").relative_path)
  	assert_equal('/hello/index.html', AG_URL::Url.new("http://www.allengarvey.com/hello/index.html?q=something+hello").relative_path)
  end

  def test_file_extension
  	assert_equal('/', AG_URL::Url.new("http://www.allengarvey.com").file_extension)
  	assert_equal('.png', AG_URL::Url.new("http://www.allengarvey.com/example.png").file_extension)
  	assert_equal('.php', AG_URL::Url.new("http://www.allengarvey.com/example.php/").file_extension)
  end
  def test_enclosing_dir
  	assert_equal('/', AG_URL::Url.new("http://www.allengarvey.com").enclosing_dir)
  	assert_equal('/', AG_URL::Url.new("http://www.allengarvey.com/index.php").enclosing_dir)
  	assert_equal('/', AG_URL::Url.new("http://www.allengarvey.com/index.php").enclosing_dir)
  	assert_equal('/hello', AG_URL::Url.new("http://www.allengarvey.com/hello/index.php").enclosing_dir)
  	assert_equal('/hello', AG_URL::Url.new("http://www.allengarvey.com/hello/index.php/").enclosing_dir)
  	assert_equal('/hello', AG_URL::Url.new("http://www.allengarvey.com/hello/index.php?something=cool").enclosing_dir)
  end
 
end