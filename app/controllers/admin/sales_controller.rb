class Admin::SalesController < AdminController
  def index
    @admin_sales = Sale.all
  end

  def show
    @admin_sale = Sale.find(params[:id])
  end

  def edit
    @admin_sale = Sale.find(params[:id])
  end

  def update
    @admin_sale = Sale.find(params[:id])

    respond_to do |format|
      if @admin_sale.update(admin_sale_params)
        format.html { redirect_to admin_sales_path, notice: "Sales was successfully updated." }
        format.json { render :show, status: :ok, location: affiliate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def admin_sale_params
    params.require(:sale).permit(:transaction_date, :payment_method, :purchase_share, :amount, :total_amount, :payout, :status)
  end
end
