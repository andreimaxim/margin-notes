# Margin Notes

A small Rails JSON application for storing notes and exporting them. It uses
PostgreSQL, Jbuilder, Redis caching, async jobs, and a streaming endpoint.

## Project references

- Read [TESTING.md](TESTING.md) for shared test conventions.
- Read [docs/guides/controllers.md](docs/guides/controllers.md),
  [docs/guides/models.md](docs/guides/models.md), and
  [docs/guides/views.md](docs/guides/views.md) for the layer you are changing.
- Read [docs/guides/fixtures.md](docs/guides/fixtures.md) when changing test data.
- Find similar code in this application before introducing a new pattern.

## Development commands

Run these from the application root. Ruby is pinned in `.ruby-version`;
`mise.toml` enables that idiomatic version file. Orb setup puts mise's shims on
`PATH`. In another Bash shell, activate mise once as shown below.

```sh
mise trust mise.toml
mise install
eval "$(mise activate bash --shims)"
bundle install
bin/rails db:prepare
bin/rails server
bin/rails console
bin/rails dbconsole
bin/rails routes
bin/rails test
bin/rails test test/controllers/notes_controller_test.rb
bin/rails test test/models/note_test.rb
```

- Start PostgreSQL and Redis before running Rails commands. Orb setup manages
  them through Amp's service supervisor; `.agents/resume` starts them again.
- Development uses `margin_notes_development`; tests use `margin_notes_test`.
- `PGHOST` and `PGUSER` select PostgreSQL access; `REDIS_URL` selects the cache.
- Request and SQL logs go to stderr, including when running tests.
- This app deliberately retains `config.load_defaults 7.0`; changing the installed
  Rails version is not the same operation as changing framework defaults.
- Keep local development signing settings out of any production deployment.

## Task-specific guidance

Load the applicable repository skills when changing these layers:

- `writing-rails-controllers` for controllers and request tests.
- `writing-rails-models` for model behavior and model tests.
- `writing-rails-views` for Jbuilder representations and their request tests.

Load more than one when a change crosses layers.
