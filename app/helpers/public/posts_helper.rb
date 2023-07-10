module Public::PostsHelper
  def introduction 
    <<-"EOS".strip_heredoc
      投稿文は３文字以上にしてください
      タグを追加する場合は全角ハッシュタグで投稿してください
    EOS
  end
end
