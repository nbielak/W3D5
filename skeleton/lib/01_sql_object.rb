require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.


class SQLObject
  def self.columns
     @table ||= DBConnection.execute2(<<-SQL)
      SELECT 
        * 
      FROM
        #{table_name}
      LIMIT
        0
    SQL
    @table.first.map(&:to_sym)
  end

  def self.finalize!
    # cols = self.class.columns
    self.columns.each do |name|
      define_method(name) do 
        @attributes[name] 
      end
      
      define_method("#{name}=") do |arg|
        self.attributes[name] = arg
      end
    end  
  end

  def [](i)
    self[i]
  end
  
  def []=(x, value)
    self[x] = value
  end
  
  def self.table_name=(table_name)
    snake = ""
    name = self.to_s.chars
    snake << name.shift
    name.each do |char|
      snake << "_" if char == char.upcase
      snake << char
    end
     @table_name = snake
  end

  def self.table_name
    "#{self.to_s.downcase}s"
  end

  def self.all
    rows = (DBConnection.execute2(<<-SQL)
     SELECT 
       * 
     FROM
       #{table_name}
      SQL
    )
    rows[1..-1]
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    attr_names = params.keys
    attr_names.each do |attr_name|
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name.to_sym)
      self.send("#{attr_name.to_sym}=", params[attr_name])
      
      
      
    end
  end

  def attributes
    @attributes ||= {}
    
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
