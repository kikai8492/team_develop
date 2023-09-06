class AdminMailer < ApplicationMailer
  def admin_mail(user)
    @user = user
    #binding.pry
    mail to: @user.email, subject: "権限移譲のお知らせ"
  end
end