class Relationship < ApplicationRecord
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User" 
    # これは中間テーブルを作るやつ
    # follower, followed は user.rb で使われている。User 同士を結び受けるため(中間テーブル)、分かりやすくするために自分でつけた名前。
end
