# Rails + GraphQL Tutorial

This project loosely followed the How to GraphQL hands-on tutorial for how to
build a GraphQL server with Ruby:

https://www.howtographql.com/graphql-ruby/0-introduction/

Significant differences are described [below](#differences-with-tutorial).

## GraphQL Client

This GraphQL server was used when developing the following GraphQL frontend
project:

https://github.com/mikong/react-apollo-tutorial

The frontend project uses the [Apollo client][apollo-client].

## Differences with Tutorial

## Local Setup

### Ruby version

This application requires [Ruby][ruby] (MRI) 2.6.5.

For Ruby gem installation, make sure you have [bundler][bundler] installed.
Rails 6.0.2 requires Bundler >= 1.3.0.

```bash
$ gem install bundler
```

### Database

PostgreSQL 9.2 and later are supported.

### Other requirements

* [Git][git]

### Getting Started

Checkout the project with git:

```bash
$ git clone git@github.com:mikong/rails-graphql-tutorial.git
```

Install gems:

```bash
$ cd /path/to/project/rails-graphql-tutorial
$ bundle install
```

Make sure your PostgreSQL server is running. Update `config/database.yml` with
your credentials. Then, create the database, load the schema and the seed data:

```bash
# create the database
$ rails db:create

# load the schema
$ rails db:schema:load
```

Alternatively, you can run the following command:

```bash
$ rails db:setup
```

Start the GraphQL server on a custom port, e.g. 4000:

```bash
$ rails s -p 4000
```

The GraphQL server can now be accessed by the client via http://localhost:4000.

[ruby]: https://www.ruby-lang.org/en/documentation/installation/
[bundler]: https://bundler.io/
[git]: https://git-scm.com/
[apollo-client]: https://www.apollographql.com/docs/react/
