require './config/environment'

begin
  fi_check_migration

  use Rack::MethodOverride
  run ApplicationController
rescue ActiveRecord::PendingMigrationError => e
  warn e
  exit 1
end

use Rack::MethodOverride

use GenresController
use ArtistsController
use SongsController
run ApplicationController
