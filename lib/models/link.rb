require 'data_mapper'
require 'dm-postgres-adapter'

class Link

  attr_reader :name, :url

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :url, String

end

DataMapper.setup(:default, "postgres://localhost/bookmark_manager")
DataMapper.finalize
DataMapper.auto_upgrade!
