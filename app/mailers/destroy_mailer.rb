class DestroyMailer < ApplicationMailer
  def destroy_mail(agenda) #agendas_controller.rbのdestroyアクションの30行目でで定義した@agendaを引数に取る
    @users= agenda.team.members
    @agenda = agenda

    mail to: @users.pluck(:email), subject: "アジェンダが削除されました" #pluckでemailを配列で取得
  end
end