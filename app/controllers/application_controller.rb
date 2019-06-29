class ApplicationController < ActionController::Base
  after_action  :delete_tempfiles

  def index
    render
  end

  def upload
    if tempfile
      report = AwesomeRunner.new(tempfile).report
      report.sub! /#<File:.*>?/, filename
      render json: { report: report }
    else
      render json: { report: '⚠️ Error or no file.' }, status: :unprocessable_entity
    end
  end

  private

  def file
    params[:file]
  end

  def tempfile
    @tempfile ||= file.try(:tempfile)
  end

  def filename
    file.try(:original_filename)
  end

  def delete_tempfiles
    FileUtils.rm(tempfile.path) if tempfile
  end
end
