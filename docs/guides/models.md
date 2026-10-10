# Models

Apply the shared conventions in [TESTING.md](../../TESTING.md).

`Note` combines persistence with note behavior. Its public query methods own
export selection, title-length statistics, archiving, and publication. Keep
those decisions on the model rather than repeating SQL conditions in controllers.
`NotebookWorkflows` owns the export client's cache, streaming, formatting, and
job integration surfaces; it does not replace ordinary Active Record persistence.

## Attributes and callers

The model has draft/published status, an archive flag, JSON metadata, and a
caption alias for its displayed title. Both `title` and `caption` include the
"Note: " prefix in client responses. `export_heading` also includes status.
`delivery_mode` is a transient export choice, not a stored column. Read the
declarations and consuming views before changing these interfaces.

Metadata is persisted through Rails' JSON coder. Test a reload with meaningful
values rather than asserting that `serialize` was declared. An export test should
arrange both an unarchived and an archived note, then exercise `Note.exportable`
and assert which record is returned. That specifies the public selection rule
without pinning how the relation is constructed.

## Model tests

Tests under `test/models/` use `ActiveSupport::TestCase` and the shared fixtures.
Assert public behavior and persisted results, not private helpers or Active
Record's implementation. The current tests cover export eligibility and metadata
round-tripping; they do not establish every bulk-update or aggregation contract.

Read the Rails [query interface](https://guides.rubyonrails.org/active_record_querying.html)
guide for relation semantics and inspect the bundled Active Record source when
changing version-dependent calls.
