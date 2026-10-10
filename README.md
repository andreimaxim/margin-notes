# Margin Notes

A small Rails JSON notebook backed by SQLite. Notes have draft/published status,
an archive flag, and JSON metadata. Listings use Jbuilder; exports use inline jobs,
an in-process cache, and a Live/SSE endpoint.

Requires Ruby 3.4.7. Install the locked bundle, then prepare the local database:

```sh
bundle install
bin/rails db:prepare
bin/rails server
```

The application runs Rails 8.0.5 and retains its original Rails 7.0 framework
defaults. The installed Rails version and `load_defaults` are separate choices.
SQLite stores development data in `db/development.sqlite3`; no database daemon
or Redis service is needed. This is local development configuration, not a
production deployment setup.

The JSON API supports `GET /notes.json`, `POST /notes` with `note[title]`, and
`GET /notes/:id`. Creation redirects to the new note. `GET /health` returns the
application status, while `GET /stream` emits the current note count.
