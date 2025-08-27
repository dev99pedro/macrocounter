  class ApplicationController < ActionController::Base
    before_action :set_daily_macros
    # falanado que assim que o application rodar, chamar o set_daily_macros

    # se o usuário está logado, cria um novo Daily Macro
    def set_daily_macros
      if user_signed_in?
        @daily_macro = DailyMacro.new
        @daily_macro_show = current_user.daily_macros
      end
    end


    # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
    allow_browser versions: :modern
  end
