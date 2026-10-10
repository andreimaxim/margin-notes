class ExportsController < ActionController::API
  def create
    export = params.require(:export).permit(:title, :amount, :deadline, :time_zone)
    zone = Time.find_zone!(export.fetch(:time_zone, "UTC"))
    deadline = zone.parse(export.fetch(:deadline))
    job = NotebookWorkflows.build_export(export.fetch(:title),
      amount: BigDecimal(export.fetch(:amount)), deadline: deadline)
    job.enqueue
    head :created
  end

  def show
    note = Note.find(params[:id])
    key = "#{params.fetch(:namespace, 'exports')}/notes/#{note.id}"
    value = Rails.cache.read(key)
    unless value
      value = { "id" => note.id, "caption" => note.caption, "metadata" => note.metadata }
      NotebookWorkflows.cache_export(key, value)
    end
    render json: value
  end

  def expire
    NotebookWorkflows.expire_note_exports
    head :no_content
  end

  def manifest
    destination = ExportDestination.new(params.fetch(:destination, "archive"))
    render json: ActiveJob::Arguments.serialize([destination]).first
  end
end
