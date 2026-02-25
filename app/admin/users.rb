ActiveAdmin.register User do
  permit_params :name, :email, :login
end
