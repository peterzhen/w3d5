require_relative 'rubysequel'

DEMO_DB_FILE = 'pokemon.db'
DEMO_SQL_FILE = 'pokemon.sql'


`rm '#{DEMO_DB_FILE}'`
`pokemon '#{DEMO_SQL_FILE}' | sqlite3 '#{DEMO_DB_FILE}'`

DBConnection.open(DEMO_DB_FILE)

class Town < SQLObject
  self.table_name = "towns"
  has_many :trainers,
  class_name: 'Trainer',
  foreign_key: :town_id

  finalize!
end

class Trainer < SQLObject
  self.table_name = "trainers"
  has_many :pokemons,
  class_name: "Pokemon",
  foreign_key: :trainer_id

  belongs_to :town,
  class_name: "Town",
  foreign_key: :town_id

  finalize!
end


class Pokemon < SQLObject
  self.table_name = "pokemons"
  belongs_to :trainer,
  class_name: 'Trainer',
  primary_key: :id,
  foreign_key: :trainer_id

  has_one_through :town, :trainer, :town

  finalize!
end
