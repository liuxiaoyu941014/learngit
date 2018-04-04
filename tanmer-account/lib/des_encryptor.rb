module DesEncryptor
  require 'openssl'
  extend self
  def encrypt(key, str)
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC').encrypt
    cipher.key = Digest::SHA1.hexdigest key
    s = cipher.update(str) + cipher.final

    s.unpack('H*')[0].upcase
  end

  def decrypt(key, str)
    cipher = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC').decrypt
    cipher.key = Digest::SHA1.hexdigest key
    s = [str].pack("H*").unpack("C*").pack("c*")

    cipher.update(s) + cipher.final
  end
end