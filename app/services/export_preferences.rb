# Settings shared with the notebook's older export clients.
module ExportPreferences
  def self.label
    Rails.application.secrets.export_label
  end

  def self.timezone
    ActiveRecord::Base.default_timezone
  end

  def self.warn_legacy_format
    ActiveSupport::Deprecation.warn("Notebook CSV v1 will be retired; use JSON exports.")
    "CSV v1"
  end

  def self.note_form(view)
    view.form_with(model: nil, scope: :note, url: "/notes") do |form|
      form.text_field(:title)
    end
  end
end
