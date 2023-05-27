class ApplicationController < ActionController::Base
  
  # 新規登録した後マイページに遷移する
  def after_sign_in_path_for(resource)
    my_page_path
  end
  
end
