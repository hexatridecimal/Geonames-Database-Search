class City < ActiveRecord::Base
  def self.make_name(name)
    name.to_s.gsub(/\W/o, "").downcase
  end

  def self.make_metaphone(test, len=5)
    if test =~ /^(\d+)/o
      mph = $1
    elsif test =~ /^([wy])$/io
      mph = $1
    else
      mph = Text::Metaphone.metaphone test
    end
    return mph[0...len.to_i]
  end
end
