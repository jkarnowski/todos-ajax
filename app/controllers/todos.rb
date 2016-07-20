get '/' do
  redirect '/todos'
end

get '/todos' do
  @todos = Todo.order(:created_at)
  erb :index
end

get '/todos/new' do
  @todo = Todo.new
  if request.xhr? ## AJAX request
    erb :new, layout: false
  else
    # sending ALL THE DATA HTML CSS AND JS for NEW FORM - HEADERS
    erb :new
  end
end

post '/todos' do
  @todo = Todo.new(params[:todos])
  if @todo.save
    if request.xhr?
      content_type :json
      data = {
        id: @todo.id,
        task: @todo.task,
        description: @todo.description
        }.to_json
    else
      redirect '/todos'
    end
  else
    redirect '/todos/new'
  end
end

get '/todos/:id' do
  @todo = Todo.find(params[:id])
  erb :show
end
