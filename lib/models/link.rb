require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-migrations'

class Link

  attr_reader :name, :url

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :url, String
  # property :tag, String

  has n, :tag, :through => Resource

end
