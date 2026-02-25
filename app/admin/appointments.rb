ActiveAdmin.register Appointment do
  permit_params :time, :status, :package, :provider, :unique_id, :attachment, :customer_id

  # Add custom action buttons on the index page
  index do
    selectable_column
    id_column
    column :customer
    column :time
    column :provider
    column :package
    column :status do |appointment|
      status_tag appointment.status
    end
    actions defaults: true do |appointment|
      if appointment.may_confirm?
        item "Confirm", confirm_admin_appointment_path(appointment), class: "member_link"
      end
      if appointment.may_complete?
        item "Complete", complete_admin_appointment_path(appointment), class: "member_link"
      end
      if appointment.may_cancel?
        item "Cancel", cancel_admin_appointment_path(appointment), class: "member_link"
      end
    end
  end

  # Define the actual routes and actions for those buttons
  member_action :confirm, method: [:get, :put] do
    if resource.may_confirm?
      resource.confirm!
      redirect_to resource_path, notice: "Appointment Confirmed!"
    else
      redirect_to resource_path, alert: "This appointment is already #{resource.status} and cannot be confirmed again."
    end
  end

  member_action :complete, method: [:get, :put] do
    if resource.may_complete?
      resource.complete!
      redirect_to resource_path, notice: "Appointment Completed!"
    else
      redirect_to resource_path, alert: "This appointment is already #{resource.status}."
    end
  end

  member_action :cancel, method: [:get, :put] do
    if resource.may_cancel?
      resource.cancel!
      redirect_to resource_path, notice: "Appointment Cancelled!"
    else
      redirect_to resource_path, alert: "This appointment is already #{resource.status}."
    end
  end
end
