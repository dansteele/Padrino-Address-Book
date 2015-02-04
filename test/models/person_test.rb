require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
require "pry"
require "database_cleaner"


describe "Person Model" do
  before do 
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  it 'can construct a new instance' do
    @person = Person.new
    refute_nil @person
  end

  it "should list all the people" do
    @person1 = Person.create(:first_name => "Dan")
    @person2 = Person.create(:first_name => "Glykeria")
    get '/person/all'
    assert last_response.ok?
    last_response.body.must_match(/Dan/)
    last_response.body.must_match(/Glykeria/)
  end

  it "should show an individual person" do
    Person.create(:first_name => "Dan", :last_name => "Steele")
    get '/person/Dan'
    assert last_response.ok?
    last_response.body.must_match(/Dan/)
  end

  it "should render the create page" do 
    get '/person/new'
    assert last_response.ok?
  end

  it "should create a new person" do
    assert 0, Person.count
    post '/person/create', {:first_name => "Dan", :last_name => "Steele",
      :phone => "0787234235", :email => "danielsteele@hotmail.co.uk", :twitter => "@dan"}
    assert 1, Person.count 
  end

  after do
    DatabaseCleaner.clean
  end

end
