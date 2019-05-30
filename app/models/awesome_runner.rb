class AwesomeRunner

  def initialize(file)
    @file = file
  end

  def report
    capture(:stdout) do
      AwesomeBot.cli_process(@file, options)
    end
  end

  def options
    { 'allow_dupe' => true,
      'allow_redirect' => true,
      'no_results' => true }
  end

  private

  def capture(stream)
    stream = stream.to_s
    captured_stream = Tempfile.new(stream)
    stream_io = eval("$#{stream}")
    origin_stream = stream_io.dup
    stream_io.reopen(captured_stream)
    yield
    stream_io.rewind
    return captured_stream.read
  ensure
    captured_stream.close
    captured_stream.unlink
    stream_io.reopen(origin_stream)
  end

end
