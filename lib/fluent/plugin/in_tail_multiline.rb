module Fluent

class TailMultiLineInput < TailInput
  Plugin.register_input('tail_multiline', self)

  def initialize
    super

    #Fluentdのロガーがグローバル変数で提供されている
    $log.debug 'TailMultiLineInput::initialize'
  end

  def start
    super

    #Fluentdのロガーがグローバル変数で提供されている
    $log.debug 'TailMultiLineInput::start'
  end

  def shutdown
    super

    #Fluentdのロガーがグローバル変数で提供されている
    $log.debug 'TailMultiLineInput::shutdown'
  end

  def configure(conf)
    super

    # config_paramで出来ないような複雑な事も出来る。conf変数に設定ファイルの内容がハッシュで渡ってくる。
    $log.debug 'TailMultiLineInput::configure ' + conf.to_s

    @format = conf['format']
    if @format == nil
      raise ConfigError, "'format' parameter is required"
    end

    @parser = Fluent::TextParser::RegexpParser.new(Regexp.new(@format[1..-2]))
  end

  def receive_lines(lines)
    $log.debug 'TailMultiLineInput::receive_lines ' + lines.to_s

    es = MultiEventStream.new
    record = lines.join
    begin
      time, parsed = @parser.call(record)
      $log.debug time
      $log.debug parsed

      es.add(time, parsed)
    rescue
      $log.warn record, :error=>$!.to_s
      $log.debug_backtrace
    end

    unless es.empty?
      Engine.emit_stream(@tag, es)
    end
  end
end

end
