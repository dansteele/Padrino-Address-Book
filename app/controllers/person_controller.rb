AddressBook::App.controllers :person do


before do
  # binding.pry
  unless session[:logged_in] || env["REQUEST_PATH"] == "/person/login" ||
    env["REQUEST_PATH"] == "/person/signup"
    redirect 'person/login'
  end
end

  get '/login' do
    #binding.pry
    @message = flash[:bad_login]
    render 'people/login'
  end

  post '/login' do
    user = User.find_by_username(params[:username])
    unless user.nil?
      if user.params[:password] == user.password
        session[:logged_in] = true
        redirect 'person/all'
      end
    end
  flash[:bad_login] = "Bad login."
  redirect 'person/login'
  end

  get '/signup' do
    render :'people/sign_up'
  end

  post '/signup' do
    if User.create(params)
      session[:logged_in] = true
      redirect 'person/all'
    end
  end

  get '/all' do
    @people = Person.all
    render 'people/all'
  end

  get '/edit/:id' do
    @person = Person.find(params[:id])
    render :'people/edit'
  end

  post '/update/:id' do
    @person = Person.find(params[:id])
    @person.update(params[:person])
    redirect 'person/all'
  end

  get '/new' do
    @person = Person.new
    render 'people/new_person'
  end


  post '/create' do
    Person.create(params[:person])
    binding.pry
    redirect "/person/#{params[:person][:first_name]}"
  end

  get "/:first_name" do
    @person = Person.find_by_first_name(params[:first_name])
    #binding.pry
    render 'people/person'
  end

  post '/delete' do
    Person.find(params[:id]).destroy
  end

end