ActiveAdmin.register Customer do
  permit_params :email, :first_name, :last_name, :mobile, :gender, :date

  remove_filter :encrypted_password
  remove_filter :reset_password_token
  remove_filter :reset_password_sent_at
  remove_filter :remember_created_at
end
