AddressBook::App.controllers :person do

  get '/all' do
    @people = Person.all
    render 'people/all'
  end

  get "/:first_name" do
    @person = Person.find_by_first_name(params[:first_name])
    #binding.pry
    render 'people/person'
  end



end