require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')




describe "Person Model" do


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
    assert_equal 1, Person.count 
  end

  it "should render the edit page" do
    Person.create(:first_name => "Dan", :last_name => "Steele",
      :phone => "0787234235", :email => "danielsteele@hotmail.co.uk", :twitter => "@dan")
    get '/person/edit', {:id => 1}
    assert last_response.ok?
  end

  it "should update a person" do
    Person.create(:first_name => "Dan", :last_name => "Steele",
      :phone => "0787234235", :email => "danielsteele@hotmail.co.uk", :twitter => "@dan")
    assert_equal 1, Person.count

    post '/person/update/1', {:last_name => "Smith"}
    assert_equal "Smith", Person.find(1).last_name
  end

  it "should delete a person" do 
    Person.create(:first_name => "Dan", :last_name => "Steele",
      :phone => "0787234235", :email => "danielsteele@hotmail.co.uk", :twitter => "@dan")
    assert_equal 1, Person.count
    post '/person/delete', { :id => 1 }
    assert_equal 0, Person.count
  end



end
