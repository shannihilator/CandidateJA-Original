Though this project relies heavily on the starter kit, it should not be run natively

In order to run, please use bin/rails server

Go to localhost:3000

###Troubleshooting

If you come accross an error asking to run bin/rails db:migrate, run this:

rm -f db/*.sqlite3
rake db:create
RAILS_ENV=development rake db:migrate
rails s -e development


Be sure to add .env to this project

/.env:

SALESLOFT_APPLICATION_ID=changeme
SALESLOFT_APPLICATION_SECRET=changeme
API_PORT=5000
WEBPACK_PORT=5001
API_KEY=INSERT_KEY_HERE