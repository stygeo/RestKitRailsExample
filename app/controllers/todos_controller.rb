class TodosController < ApplicationController
  respond_to :xml, :json

  # GET /todos
  def index
    respond_with Todo.all
  end

  # GET /todos/:id
  def show
    respond_with Todo.find(params[:id])
  end

  # POST /todos
  def create
    @todo = Todo.new params[:todo]

    if @todo.save
      respond_with @todo
    else
      respond_to_error @todo and return
    end
  end

  # PATCH /todos/:id
  def update
    @todo = Todo.find params[:id]
  end

  # DELETE /todos/:id
  def destroy
    @todo = Todo.find params[:id]

    @todo.delete
  end

  protected
  def get_error todo
    {error: true, message: "Unable to save todo item", errors: todo.errors}
  end

  def respond_to_error todo
    respond_to do |page|
      page.xml  { render :xml  => get_error(todo) }
      page.json { render :json => get_error(todo) }
    end
  end
end
