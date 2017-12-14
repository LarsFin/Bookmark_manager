require 'data_mapper'
require 'dm-postgres-adapter'
require_relative './lib/models/link.rb'
require_relative './lib/models/tag.rb'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bm_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
