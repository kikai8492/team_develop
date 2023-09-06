class AgendasController < ApplicationController

  def index
    @agendas = Agenda.all
  end

  def new
    @team = Team.friendly.find(params[:team_id])
    @agenda = Agenda.new
  end

  def create
    @agenda = current_user.agendas.build(title: params[:title])
    @agenda.team = Team.friendly.find(params[:team_id])
    current_user.keep_team_id = @agenda.team.id
    if current_user.save && @agenda.save
      redirect_to dashboard_url, notice: I18n.t('views.messages.create_agenda')
    else
      render :new
    end
  end

  def destroy
    @agenda = Agenda.find(params[:id]) # アジェンダのIDを取得してそれに紐付いているユーザーIDとチームのオーナーIDを持ってくる
    if current_user.id != @agenda.user_id || current_user.id != @agenda.team.owner_id # 現在ログインしているユーザーIDがアジェンダの作成者IDとチームのオーナーIDの両方で一致しない場合
      redirect_to dashboard_path, notice: "アジェンダの削除権限がありません"
    else
      @agenda.destroy
      ##以下にメール送信処理を記述
      DestroyMailer.destroy_mail(@agenda).deliver
  
      redirect_to dashboard_path notice: "アジェンダを削除しました"
    end
  end

  private

  def agenda_params
    params.fetch(:agenda, {}).permit %i[title description]
  end
end
