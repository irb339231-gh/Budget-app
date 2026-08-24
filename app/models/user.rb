class User < ApplicationRecord
  has_many :expenditures, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :password, pwned: true, if: -> { password_required? && !Rails.env.test? }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :omniauthable,
         omniauth_providers: [ :google_oauth2 ]

  def self.from_omniauth(auth)
    # Googleでメール認証が済んでいないアカウントは拒否
    return nil if auth.provider == "google_oauth2" && !auth.info.email_verified
    # emailが空なら拒否
    return nil if auth.info.email.blank?

    # (provider, uid)で既存ユーザーを検索
    user = find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    # 同じメアドの別ユーザーがいたら拒否
    return nil if User.exists?(email: auth.info.email)

    # 初回ログイン → 新規作成
    create do |u|
      u.provider = auth.provider
      u.uid      = auth.uid
      u.email    = auth.info.email
      u.name     = auth.info.name
      u.password = SecureRandom.hex(16)
    end
  end

  # OAuthユーザーにはパスワード入力を要求しない
  def password_required?
    super && provider.blank?
  end

  def password_changeable?
    provider.blank?
  end


  def available_amount
    total_income - total_future_expenses - total_fixed_costs - total_transactions_expenses + total_transactions_incomes
  end

  def daily_available_amount
    return 0 if job_search_days.zero? # daysが0の場合は除く
    available_amount / job_search_days
  end

  def weekly_available_amount
    return 0 if job_search_days.zero? # daysが0の場合は除く
    return 0 if job_search_days < 7
    (available_amount / (job_search_days / 7.0)).to_i # 転職活動期間を7.0で割る（７日未満の場合も計算するため7.0とする）
  end

  def monthly_available_amount
    return 0 if job_search_months.zero? # monthsが0の場合は除く
    available_amount / job_search_months
  end

  def job_search_days
    return 0 if job_search_start_month.nil? || job_search_end_month.nil?
    (job_search_end_month - job_search_start_month).to_i
  end

  def job_search_months
    return 0 if job_search_start_month.nil? || job_search_end_month.nil?
    ((job_search_end_month.year - job_search_start_month.year) * 12 +
      (job_search_end_month.month - job_search_start_month.month)).abs
  end

  def total_income
    expenditures.where(category: :income).sum(:amount)
  end

  def total_future_expenses
    expenditures.where(category: :future_expense).sum(:amount)
  end

  def total_fixed_costs
    expenditures.where(category: :fixed_cost).sum(:amount) * job_search_months
  end

  def total_transactions_expenses
    transactions.where(category: :expense).sum(:amount)
  end

  def total_transactions_incomes
    transactions.where(category: :income).sum(:amount)
  end

  def available_amount_percentage
    return 0 if total_income.zero? # total_incomeが0の場合は除く
    (available_amount.to_f / total_income.to_f * 100).round
  end
end
