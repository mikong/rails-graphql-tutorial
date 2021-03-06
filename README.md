# Rails + GraphQL Tutorial

This project is an API for a [Hacker News][hacker-news] clone using Rails and
the [GraphQL gem][graphql-gem]. It has the following basic features:

* show a list of links
* authentication
* users can create new links
* users can vote for links
* search links

This project loosely followed the How to GraphQL hands-on tutorial for how to
build a GraphQL server with Ruby:

https://www.howtographql.com/graphql-ruby/0-introduction/

Significant differences are described [below](#differences-with-tutorial).

## GraphQL Client

This GraphQL server was used when developing the following GraphQL frontend
project:

https://github.com/mikong/react-apollo-tutorial

The frontend project uses the [Apollo client][apollo-client].

## GraphQL Schema Structure

For reference, you can view the GraphQL schema structure
in [schema.graphql][graphql-schema].

When making changes to the schema, we can dump the updated schema to IDL in
`app/graphql/schema.graphql` with the following command:

```bash
$ rails graphql:schema:idl
```

The `SchemaTest` tests if this schema dump is up-to-date.

## Differences with Tutorial

### Versions

The following versions were used:

* rails 6.0.3
* graphql 1.9

### API-only Rails Application and PostgreSQL

The Rails application was generated using the following command:

```bash
$ rails new rails-graphql-tutorial --api -d postgresql --skip-active-storage
```

### GraphQL

While we use the same generator as in the tutorial to setup GraphQL:

```bash
$ rails g graphql:install
```

the output is a bit different due to the difference in gem version.

Also, the [graphiql-rails][graphiql] gem is normally automatically installed by
the above generator but this is skipped for API-only applications.

### CORS

To allow communication between frontend and backend applications, we need to
enable cross-origin requests. The gem `rack-cors` was added to the Gemfile. In
`config/initializers/cors.rb`, we have:

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allowed_origins = Rails.configuration.allowed_cors_origins
  if allowed_origins.present?
    allow do
      origins allowed_origins

      resource(
        '*',
        headers: :any,
        methods: [:get, :post, :options],
        credentials: true,
      )
    end
  end
end
```

We also have the following configuration in
`config/environments/development.rb`:

```ruby
config.allowed_cors_origins = [/localhost(:\d+)?\z/]
```

This allows the Rails application to accept requests from the localhost origin
using any port.

### Middleware

As an API-only Rails application, middleware for handling cookies was added
back manually:

```ruby
# in config/application.rb

config.middleware.insert_after(
  ActionDispatch::Callbacks,
  ActionDispatch::Cookies,
)
config.middleware.insert_after(
  ActionDispatch::Cookies,
  ActionDispatch::Session::CookieStore,
)
```

## Local Setup

### Ruby version

This application requires [Ruby][ruby] (MRI) 2.6.5.

For Ruby gem installation, make sure you have [bundler][bundler] installed.
Rails 6.0.3 requires Bundler >= 1.3.0.

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

[hacker-news]: https://news.ycombinator.com/
[graphql-gem]: https://graphql-ruby.org/
[ruby]: https://www.ruby-lang.org/en/documentation/installation/
[bundler]: https://bundler.io/
[git]: https://git-scm.com/
[apollo-client]: https://www.apollographql.com/docs/react/
[graphql-schema]: https://github.com/mikong/rails-graphql-tutorial/blob/master/app/graphql/schema.graphql
[graphiql]: https://github.com/rmosolgo/graphiql-rails
