ActiveAdmin.register Customer do
  permit_params :email, :first_name, :last_name, :mobile, :password, :password_confirmation

  remove_filter :encrypted_password
  remove_filter :reset_password_token
  remove_filter :reset_password_sent_at
  remove_filter :remember_created_at
  remove_filter :gender
  remove_filter :date

  # Clean up the sidebar search filters
  filter :email
  filter :first_name
  filter :last_name
  filter :mobile

  # Remove blank passwords on update so Devise doesn't throw a validation error
  controller do
    def update
      if params[:customer][:password].blank? && params[:customer][:password_confirmation].blank?
        params[:customer].delete("password")
        params[:customer].delete("password_confirmation")
      end
      super
    end
  end

  # Clean up the Edit / Create Form
  form do |f|
    f.semantic_errors *f.object.errors.attribute_names
    f.inputs "Customer Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :mobile
      
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      else
        f.input :password, hint: "Leave blank to keep the current password"
        f.input :password_confirmation
      end
    end
    f.actions
  end

  # Clean up the main table (Index page)
  index do
    selectable_column
    id_column
    column "Name" do |c|
      "#{c.first_name} #{c.last_name}".strip.presence || "No Name"
    end
    column :email
    column :mobile
    actions
  end

  # Display the customer's name at the top of their page instead of "Customer #12"
  show title: proc { |c| "Welcome, #{c.to_s}" } do
    attributes_table title: "Customer Details" do
      row "Name" do |c|
        "#{c.first_name} #{c.last_name}".strip
      end
      row :email
      row :mobile
      row :created_at
    end

    panel "Customer's Appointments" do
      if customer.appointments.any?
        table_for customer.appointments.order('time DESC') do
          column "ID", :id
          column "Date & Time", :time
          column "Provider", :provider
          column "Package", :package
          column "Status" do |appointment|
            status_tag appointment.status
          end
          column "Actions" do |appointment|
            link_to("View", admin_appointment_path(appointment), class: "member_link") +
            link_to("Edit", edit_admin_appointment_path(appointment), class: "member_link")
          end
        end
      else
        div style: "padding: 15px;" do
          h4 "This customer has no appointments yet."
        end
      end
    end
    
    # Don't forget the comments at the bottom!
    active_admin_comments
  end
end
