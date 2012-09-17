module Fluent

class HogeInput < Input
  Plugin.register_input('hoge', self)

  config_param :tag, :string
  config_param :value, :integer, :default => 100

  def initialize
    super

    #Fluentdのロガーがグローバル変数で提供されている
    $log.debug 'HogeInput::initialize'
  end

  def start
    #Fluentdのロガーがグローバル変数で提供されている
    $log.debug 'HogeInput::start'
  end

  def shutdown
    #Fluentdのロガーがグローバル変数で提供されている
    $log.debug 'HogeInput::shutdown'
  end

  def configure(conf)
    super

    # config_paramで設定した内容がインスタンス変数にセットされている
    $log.debug @tag
    $log.debug @value

    # config_paramで出来ないような複雑な事も出来る。conf変数に設定ファイルの内容がハッシュで渡ってくる。
    $log.debug 'HogeInput::configure ' + conf.to_s
    $log.debug conf
  end
end

end
