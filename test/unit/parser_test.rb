
require "#{File.dirname(__FILE__)}/../test_helper.rb"

context "parser" do

  def setup
    @s = Ultrasphinx::Search.new("")
  end

  [
  'artichokes', 
  'artichokes',
   
   '  artichokes  ', 
   'artichokes',
   
   'artichoke heart', 
   'artichoke heart',
   
   '"artichoke hearts"', 
   '"artichoke hearts"',
   
   '  "artichoke hearts  " ', 
   '"artichoke hearts"',
   
   'artichoke AND hearts', 
   'artichoke hearts',
   
   'artichoke OR hearts', 
   'artichoke | hearts',
   
   'artichoke NOT heart', 
   'artichoke -heart',
   
   'title:artichoke', 
   '@title artichoke',
   
   'user:"john mose"', 
   '@user "john mose"',
   
   'artichoke OR rhubarb NOT heart user:"john mose"', 
   'artichoke | rhubarb -heart @user "john mose"',
   
   'title:artichoke hearts', 
   'hearts @title artichoke',

   'title:artichoke AND hearts', 
   'hearts @title artichoke',
   
   'title:artichoke NOT hearts', 
   'hearts -@title artichoke',

   'title:artichoke OR hearts', 
   'hearts | @title artichoke',

   'title:artichoke title:hearts', 
   '@title (artichoke hearts)',

   'title:artichoke OR title:hearts', 
   '@title (artichoke | hearts)',

   'title:artichoke NOT title:hearts "john mose" ', 
   '"john mose" @title (artichoke -hearts)',
   
  ].in_groups_of(2).each do |query, result|
    it "should work" do
     @s.send(:parse_google_to_sphinx, query).should.equal(result)
    end
  end
  
end
