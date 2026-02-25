ActiveAdmin.register Appointment do
  permit_params :time, :status, :package, :provider, :unique_id, :attachment, :customer_id

  # Customize the form so the Date/Time picker looks modern and other fields are neat
  form do |f|
    f.semantic_errors # shows errors on form
    f.inputs "Appointment Details" do
      f.input :customer
      # Use HTML5 datetime-local for a modern pop-up calendar and time selector
      f.input :time, as: :string, input_html: { type: 'datetime-local', value: f.object.time&.strftime('%Y-%m-%dT%H:%M') }
      f.input :provider, as: :select, collection: Appointment::PROVIDER_OPTIONS
      f.input :package, as: :select, collection: Appointment::PACKAGE_OPTIONS
      # It's better to render status as a dropdown matching your AASM states
      f.input :status, as: :select, collection: Appointment.aasm.states.map(&:name).map(&:to_s)
      f.input :attachment, as: :file
    end
    f.actions
  end

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
