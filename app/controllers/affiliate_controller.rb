class AffiliateController < ApplicationController
  layout 'affiliate'
  before_action :authenticate_affiliate!
  before_action :set_affiliate, only: %i[index profile edit update account_setting edit_account_setting update_account_setting]

  def index
    @pending = current_affiliate.sales.pending.count
    @paid = current_affiliate.sales.paid.count
  end

  def profile
    if @affiliate.birthday.present?
      now = Time.now.utc.to_date
      @age = now.year - @affiliate.birthday.to_date.year

      if (now.month < @affiliate.birthday.to_date.month)
        @age = @age - 1
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|

      if @affiliate.update(affiliate_params)
        format.html { redirect_to affiliate_profile_path, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @affiliate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @affiliate.errors, status: :unprocessable_entity }
      end
    end
  end

  def sale
    @sales = current_affiliate.sales
  end

  def account
  end

  def account_setting
  end

  def edit_account_setting
  end

  def update_account_setting
    respond_to do |format|

      if @affiliate.update(affiliate_params)
        format.html { redirect_to affiliate_account_setting_path, notice: "Account Settings was successfully updated." }
        format.json { render :show, status: :ok, location: @affiliate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @affiliate.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_affiliate
      @affiliate = Affiliate.find(current_affiliate.id)
    end

    def affiliate_params
      params.require(:affiliate).permit(:birthday, :address, :mobile, :password, :password_confirmation, :fb, :ig, :tiktok, :youtube, :others, :type_of_id, :avatar, :attached_id, :bank, :account_name, :account_no)
    end
end