module Fluent

class TailMultiLineInput < TailInput
  Plugin.register_input('tail_multiline', self)

  def configure(conf)
    super

    @format = conf['format']
    if @format == nil
      raise ConfigError, "'format' parameter is required"
    end

    @parser = Fluent::TextParser::RegexpParser.new(Regexp.new(@format[1..-2]))
  end

  def receive_lines(lines)
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
