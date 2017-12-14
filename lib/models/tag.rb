require 'data_mapper'
require 'dm-postgres-adapter'

class Tag

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  # property :link_id, String

  has n, :link, :through => Resource

end
