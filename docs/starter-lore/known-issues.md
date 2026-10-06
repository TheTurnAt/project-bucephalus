# Known issues

Starter version. Copy to OpenLore at `/turnat/known-issues/`.

- **Scripts connect to the wrong database** if they skip `dbName`. Always pass
  `dbName: process.env.APP_NAME` and print the database name on connect.
- **Account deletion doesn't cascade.** Deleting a user leaves their posts,
  ads, gigs, and memberships behind. A cascade delete is planned, and it needs
  to cancel Stripe subscriptions and revoke Sign in with Apple tokens.
- **Demo seed data reached production.** `seed-comprehensive.js` ran against
  `TheTurnAt`. Clean up with `scripts/cleanup-demo-data.js` (dry run first).
  Seed scripts must never run against production.
- **Merge conflicts can drop lines silently.** A vendor merge removed
  `const response =` while keeping `response?.data?.resetToken`. Reviewers
  should check for this.
