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
    erb :new
  end
end

post '/todos' do
  @new_todo = Todo.new(params[:todos])
  if @new_todo.save
    if request.xhr?
      # sends back a partial and just the new object data
      erb :'_task', layout: false, locals: {todo: @new_todo }
    else
      redirect '/todos'
    end
  else
    status 422
    redirect '/todos/new'
  end
end

get '/todos/:id' do
  @todo = Todo.find(params[:id])
  erb :show
end
