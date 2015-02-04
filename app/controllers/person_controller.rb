AddressBook::App.controllers :person do

  get '/all' do
    @people = Person.all
    render 'people/all'
  end

  get '/edit' do
    @person = Person.find(params[:id])
    render 'people/edit'
  end

  post '/update/:id' do
    Person.find(params[:id]).update(params)
  end

  get '/new' do
    render 'people/new_person'
  end


  post '/create' do
    Person.create(params)
    redirect "/people/#{params[:first_name]}"
  end

  get "/:first_name" do
    @person = Person.find_by_first_name(params[:first_name])
    #binding.pry
    render 'people/person'
  end



end