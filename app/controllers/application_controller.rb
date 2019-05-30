class ApplicationController < ActionController::Base
  after_action  :delete_tempfiles

  def index
    if request.post?
      report = AwesomeRunner.new(tempfile).report
      report.sub! /#<File:.*>?/, filename
      render json: { report: report }
    else
      render
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
    file.original_filename
  end

  def delete_tempfiles
    FileUtils.rm(tempfile.path) if tempfile
  end
end
