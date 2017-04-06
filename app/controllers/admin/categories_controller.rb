class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.roots.page(params[:page] || 1).
      per_page(params[:per_page] || 10).order('id desc')
  end

  def new
    @category = Category.new
    @root_categories = Category.roots.order('id desc')
  end

  def create
    # 接收全部参数
    @category = Category.new(params.require(:category).permit!)
    @root_categories = Category.roots.order('id desc')
    if @category.save
      flash[:notice] = "保存成功"
      redirect_to admin_categories_path
    else
      render action: :new
    end
  end

  def edit
  end
end
