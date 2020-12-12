require 'active_record'
require 'active_support/all'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'csv'
require 'yaml'

@dbname = File.dirname(File.expand_path(__FILE__)).split('/').last

ActiveRecord::Base.logger = Logger.new(STDERR)

# DBのタイムゾーン設定
Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local

# DB接続処理
ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  database: @dbname,
  host: '127.0.0.1',
  username: ENV['RAILS_DATABASE_USERNAME'],
  password: ENV['RAILS_DATABASE_PASSWORD'],
  charset: 'utf8mb4',
  encoding: 'utf8mb4',
  collation: 'utf8mb4_general_ci'
)

class Page < ActiveRecord::Base
end

class Detail < ActiveRecord::Base
end
