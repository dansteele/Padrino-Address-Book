AddressBook::App.controllers :people, :map => :person do
  

  before do
    #binding.pry
    @person = Person.find(params[:id]) if params[:id]
    unless session[:logged_in] || env["REQUEST_PATH"] == "/person/login" ||
      env["REQUEST_PATH"] == "/person/signup"
      redirect url_for(:people, :login)
    end
  end

  get :login do
    @message = flash[:bad_login]
    render 'people/login'
  end

  post :login do
    user = User.find_by_username(params[:username])
    unless user.nil?
      #binding.pry
      if params[:password] == user.password
        session[:logged_in] = true
        redirect url_for(:people, :all)
      end
    end
  flash[:bad_login] = "Bad login."
  redirect url_for(:people, :login)
  end

  get :signup do
    render :'people/sign_up'
  end

  post :signup do
    binding.pry
    unless User.find_by_username(params[:user][:username])
      if User.create(params[:user])
        session[:logged_in] = true
        redirect 'person/all'
      end
    end
  end

  get :all do
    @people = Person.all
    render 'people/all'
  end

  get :search do
    @letter_array = ("A".."Z").to_a
    render :search
  end

  get :find, :with => :letter do
    binding.pry
    people = Person.where("last_name LIKE ?", "#{:letter}%")
    redirect url_for(:index, :with => people.id)
  end

  get :edit, :map => ":id/edit" do
    @person = Person.find(params[:id])
    render :edit
  end

  put :update, :map => ":id" do
    @person = Person.find(params[:id])
    @person.update(params[:person])
    redirect url_for(:people, :all)
  end

  get :new do
    @person = Person.new
    render :preferences
  end

  get :preferences do
    @person = Person.find(params[:person])
    render :preferences
  end


  post :create, :map => "" do
    Person.create(params[:person])
    #binding.pry
    redirect url_for(:people, :all, :with => params[:person][:id])
  end

  get :index, :with => :id do
    @person = Person.find(params[:id])
    #binding.pry
    render :person
  end

  post :delete, :map => ':id' do
    Person.find(params[:id]).destroy
  end


end