# Here goes your database connection and options:

require 'm4dbi'

$dbh = DBI.connect(
  "DBI:#{ApplicationName.options.db.adapter}:#{ApplicationName.options.db.name}",
  ApplicationName.options.db.user,
  ApplicationName.options.db.password
)

# Here go your requires for models:
require 'model/user'

