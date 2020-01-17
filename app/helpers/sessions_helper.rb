module SessionsHelper
    def log_in(user)
        # この user には入力したユーザーの情報が全部入っている

        session[:user_id] = user.id
        # user.id は id(数字) のみで、これを session[:user_id](サーバー上)に保存する
    end

    def current_user
        User.find_by(id: session[:user_id])
        # User(テーブル上) の id と、session[:user_id](サーバー上) の id を比べて、同じなら current_user にその行の情報を保存する
    end

    def logged_in?
        !current_user.nil?
    end
    # ヘッダーのif文で使う
    # 「空ですか？」 よりも、「ありますか？」　の方がいい

    def log_out
        session.delete(:user_id)
    end
end
