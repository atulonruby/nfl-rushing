class HomesController < ApplicationController
  def index
  end

  def new
    @rushing = Rushing.new
  end

  def create
    @rushing =  Rushing.new(rushing_params)
    if @rushing.valid?
      @items = @rushing.items
      @keys = @rushing.keys
      render action: 'index'
    else
      render action: 'new'
    end
  end

  private

  def rushing_params
    params.require(:rushing).permit(:file)
  end
end
