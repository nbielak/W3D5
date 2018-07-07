class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # names = names.map do |name|
    #   name = "@#{name}"
    # end
    names.each do |name|
      next unless name.is_a?(Symbol)
      define_method(name) do 
        self.instance_variable_get("@#{name.to_s}")
      end
      
      define_method("#{name}=") do |arg|
        self.instance_variable_set("@#{name.to_s}", arg)
      end
    end
        
    # ...
  end
end
