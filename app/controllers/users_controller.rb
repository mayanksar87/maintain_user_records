class UsersController < ApplicationController
  before_action :initialize_redis, only: [:destroy]
  def index
    @users = User.all.map(&:attributes)
    @total_users = User.count
    @daily_records = DailyRecord.all.map(&:attributes)
     render template: 'users/index', layout: false
  end

  def new
    @user = User.new
    render template: 'users/new', layout: false
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render template: 'users/new', layout: false
    end
  end

  def destroy
    user = User.find(params[:id])
    gender = user.gender.downcase

    if user.destroy
      @redis.decr(gender + '_count')
      update_daily_records_on_user_deletion(user)

      redirect_to users_path, notice: 'User was successfully destroyed.'
    else
      redirect_to users_path, alert: 'Error destroying user.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:uuid, :gender, :age, :location, name: [:first, :last, :title])
  end

  def initialize_redis
    @redis = Redis.new
  end

  def update_daily_records_on_user_deletion(user)
    date = user.created_at.to_date
    daily_record = DailyRecord.find_by(date: date)

    return unless daily_record

    if user.gender == 'male'
      daily_record.update(male_count: daily_record.male_count - 1)
    elsif user.gender == 'female'
      daily_record.update(female_count: daily_record.female_count - 1)
    end
  end
end
