class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  before_action :move_to_index, except: [:index, :show]
  before_action :current_user_prototype_user, except: [:index, :new, :create, :show]

  def index
    query = "SELECT * FROM prototypes"
    @prototype = Prototype.find_by_sql(query)


  end

  def new
    @prototype = Prototype.new
  end

  def create
    #binding.pry
    @prototype = Prototype.new(prototypes_params)
    #binding.pry
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end

  end

  def destroy
   # @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  def show
  @prototype = Prototype.find(params[:id])
   @comment = Comment.new
   @comments = @prototype.comments.includes(:user)

    
  end

  def edit
    #@prototype = Prototype.find(params[:id])
  end

  def update
   # @prototype = Prototype.find(params[:id])

    if @prototype.update(prototypes_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

 


  private

  def prototypes_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def current_user_prototype_user
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end
  
end
