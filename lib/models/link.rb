require 'data_mapper'
require 'dm-postgres-adapter'

class Link

  attr_reader :name, :url

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :url, String

end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bm_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
