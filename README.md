# Rexaminator

Rexaminator is a multi choice test simulator application, based on Ruby On Rails (v3.2) framework.
It has been particularly created for Ruby programming language, but can be used for any variety of domains.

## Features

* simple CRUD for questions with comments (authorized access)
* exam generator (random set of some number of questions)
* online exam tools (question navigation, final exam score with exam statistics, question review with comments)

## Instalation

#### Get the code
```
$ git clone <repo_url>
```

#### Install gems
```
$ bundle install
```

#### Setup database
```
$ cp config/database.yml.sample config/database.yml
$ vim config/database.yml
```

#### Bootstrap database
```
$ rake db:create db:migrate
```

#### Seed sample database content
```
$ psql rexaminator_development -U <user> -W < ./db/db_dump.sql
```

#### Run the app server
```
$ rails server
```

#### Access the application (public)
```
http://localhost:3000
```

#### Access the admin panel
```
http://localhost:3000/admin
```

username: admin,
password: secret
