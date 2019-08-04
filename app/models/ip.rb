class Ip < ActiveRecord::Base
  
  def self.get(addr)
    return Ip.find_or_create(addr)
  end
  
  def self.find_or_create(addr)
    return addr if addr.class == Ip
    return nil if addr == nil
    
    Ip.with_advisory_lock("ip_find") do
      Ip.transaction do
        res = Ip.find_by_addr(addr)
        if res == nil
          res = Ip.new
          res.addr = addr
          # res.country_code = get_country_code(addr)
          res.save!
        end
        return res
      end
    end
  end
  
  def get_whois_link
    return Ip.get_whois_link(self.addr)
  end
  
  def self.get_whois_link(addr)
    return "https://gwhois.org/#{addr}"
  end
end
