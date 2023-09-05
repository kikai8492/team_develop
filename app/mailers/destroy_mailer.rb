class DestroyMailer < ApplicationMailer
  def destroy_mail(agenda)
    #binding.pry
    @users= agenda.team.members
    @agenda = agenda
    # email = @user.where(email: email)

      #binding.pry
      mail to: @users.pluck(:email), subject: "アジェンダが削除されました" #pluckでemailを配列で取得
  end
end