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
    if params[:password] == user.password
      session[:logged_in] = true
      redirect 'person/all'
    else
      flash[:bad_login] = "Bad login."
      redirect 'person/login'
    end
  end

  get '/signup' do
    render 'users/sign_up'
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

  post '/delete' do
    Person.find(params[:id]).destroy
  end

end