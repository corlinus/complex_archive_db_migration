class AccessDb
  attr_accessor :mdb, :connection, :data, :fields

  def initialize(mdb=nil)
    require 'win32ole'
    WIN32OLE.codepage = WIN32OLE::CP_UTF8
    @mdb = mdb
    @connection = nil
    @data = nil
    @fields = nil
  end

  def open
    connection_string =  'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='
    connection_string << @mdb
    @connection = WIN32OLE.new('ADODB.Connection')
    @connection.Open(connection_string)
  end

  def query sql, limit=0
    recordset = WIN32OLE.new('ADODB.Recordset')
    recordset.Open(sql, @connection)
    @fields = []
    recordset.Fields.each do |field|
      @fields << field.Name
    end
    begin
      @data = recordset.GetRows(limit).transpose
    rescue
      @data = []
    end
    recordset.Close
  end

  def each_in_query sql, &block
    recordset = WIN32OLE.new('ADODB.Recordset')
    recordset.Open(sql, @connection)

    while true
      begin
        data = recordset.GetRows(1).transpose.first
      rescue
        break
      end
      yield data
    end

    recordset.Close
  end

  def execute(sql)
    @connection.Execute(sql)
  end

  def close
    @connection.Close
  end
end

