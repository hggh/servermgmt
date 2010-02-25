class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter < ActiveRecord::ConnectionAdapters::AbstractAdapter
  remove_const(:NATIVE_DATABASE_TYPES)
  NATIVE_DATABASE_TYPES = {
        :primary_key => "serial primary key".freeze,
        :string      => { :name => "character varying", :limit => 255 },
        :text        => { :name => "text" },
        :integer     => { :name => "integer" },
        :float       => { :name => "float" },
        :decimal     => { :name => "decimal" },
        :datetime    => { :name => "timestamp" },
        :timestamp   => { :name => "timestamp" },
        :time        => { :name => "time" },
        :date        => { :name => "date" },
        :binary      => { :name => "bytea" },
        :boolean     => { :name => "boolean" },
        :xml         => { :name => "xml" },
        :inet        => { :name => "inet" },
        :cidr        => { :name => "cidr" }
  }
end

class ActiveRecord::ConnectionAdapters::TableDefinition
  def inet(*args)
    options = args.extract_options!
    column(args[0], 'inet', options)
  end
  def cidr(*args)
    options = args.extract_options!
    column(args[0], 'cidr', options)
  end
end

class ActiveRecord::ConnectionAdapters::PostgreSQLColumn
  private
  def simplified_type(field_type)
    case field_type
      # Numeric and monetary types
      when /^(?:real|double precision)$/
              :float
      # Monetary types
      when /^money$/
              :decimal
      # Character types
      when /^(?:character varying|bpchar)(?:\(\d+\))?$/
              :string
      # Binary data types
      when /^bytea$/
              :binary
      # Date/time types
      when /^timestamp with(?:out)? time zone$/
              :datetime
      when /^interval$/
              :string
      # Geometric types
      when /^(?:point|line|lseg|box|"?path"?|polygon|circle)$/
              :string
      # Hack: We want to use inet type
      when /^inet$/
              :inet
      when /^cidr$/
              :cidr
      # Network address types
      when /^(?:cidr|inet|macaddr)$/
              :string
      # Bit strings
      when /^bit(?: varying)?(?:\(\d+\))?$/
              :string
      # XML type
      when /^xml$/
              :xml
      # Arrays
      when /^\D+\[\]$/
              :string
      # Object identifier types
      when /^oid$/
              :integer
      # Pass through all types that are not specific to PostgreSQL.
    else
      super
    end
  end
  
end

