module BrTerminacoes

  require 'net/http'
  attr_reader :usuario, :senha, :id

  def initialize(usuario, senha)
    @usuario = usuario
    @senha = senha
    @uri = URI('http://webapi.comtele.com.br/api/api_fuse_connection.php')
    @params = { :fuse => 'get_id', :user => @usuario, :pwd => @senha }
    @id = conectar(@params)
  end

  def saldo()
    @params = { :fuse => 'get_balance', :id => id}
    conectar(@params)
  end

  private

  def conectar(params)
    self.uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      res.body
    else
      "Entre em contato com suport e informe a mensagem: #{res.body}"
    end
  end

#  params = { :fuse => 'get_balance', :id => id}
#  uri.query = URI.encode_www_form(params)
#  res = Net::HTTP.get_response(uri)
#  print "saldo: "
#  puts res.body if res.is_a?(Net::HTTPSuccess)

#  params = { :fuse => 'get_report', :id => id, :dt_begin => '2012-01-01', :dt_end => '2012-01-03', :mode => 'detail' }
#  uri.query = URI.encode_www_form(params)
#  res = Net::HTTP.get_response(uri)
#  print "relatorio detalhado:"
#  puts res.body if res.is_a?(Net::HTTPSuccess)

#  params = { :fuse => 'send_msg', :id => id, :from => 'tobias', :msg => mensagem, :number => numero }
#  uri.query = URI.encode_www_form(params)
#  res = Net::HTTP.get_response(uri)
#  print "resposta do envio:"
#  puts res.body if res.is_a?(Net::HTTPSuccess)
end
