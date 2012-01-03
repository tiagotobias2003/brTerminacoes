require 'net/http'

class Sms

  attr_reader :usuario, :senha, :id

  def initialize(usuario, senha)
    @usuario = usuario
    @senha = senha
    @uri = URI('http://webapi.comtele.com.br/api/api_fuse_connection.php')
    @params = { :fuse => 'get_id', :user => @usuario, :pwd => @senha }
    @id = conectar(@params)
  end

  def saldo()
    @params = { :fuse => 'get_balance', :id => @id}
    conectar(@params)
  end

  def enviar(remetente, mensagem, numeros)
    @params = { :fuse => 'send_msg', :id => @id, :from => remetente, :msg => mensagem, :number => numeros }
    conectar(@params)
  end

  def relatorio(data_inicial, data_final, modo)
   @params = { :fuse => 'get_report', :id => @id, :dt_begin => data_inicial, :dt_end => data_final, :mode => modo }
    conectar(@params)
  end

  private

  def conectar(params)
    @uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(@uri)
    if res.is_a?(Net::HTTPSuccess)
      res.body
    else
      "Entre em contato com suporte e informe a mensagem: #{res.body}"
    end
  end

end
