class CatsController < ApplicationController
  # before_action do
  #   return if session[:notice].nil?
  #   msg, flag = session[:notice]
  #   session[:notice] = [msg, false]
  # end
  #
  # after_action do
  #   return if session[:notice].nil?
  #   msg, flag = session[:notice]
  #   return if flag
  #   session[:notice] = nil
  # end

  def index
    # GET /cats
    # if params[:tag]
    #   @cats = Tag.find_by(name: params[:tag]).cats
    # else
    #   @cats = Cat.all
    # end
    # render :index
    @cats = Cat.all
    render :index    
  end

  def show
    # GET /cats/123
    @cat = Cat.find(params[:id])
    render :show
  end

  # 1. GET Request for blank /cats/new form
  # 2. POST to /cats
  # 3. Validation fails
  # 4. Server render new template again.
  # 5. The form is filled in with @cat data

  def create
    # POST /cats
    # Content-Length: ...
    #
    # { "cat": { "name": "Sally" } }

    @cat = Cat.new(params[:cat].permit([:name, :skill]))

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  # 1. GET /cats/new to fetch a form
  # 2. User fills out form, clicks submit.
  # 3. POST /cats the data in the form
  # 4. Create action is invoked, cat is created.
  # 5. Send client a redirect to /cats/#{id}
  # 6. Client makes a GET request for /cats/#{id}
  # 7. Show action for newly created cat is invoked.

  def new
    @cat = Cat.new
    render :new
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def destroy
    cat = Cat.find(params[:id])
    cat.destroy

    redirect_to cats_url
  end

  private
  def cat_params
    params[:cat].permit(
      :name, :skill
    )
  end
end
