# The Turn At: system map

Starter version. Copy to OpenLore at `/turnat/system-map.md` and keep it
current there. Never put secret values here; say where they live instead.

## Products
- **Resident app** (`com.theturnat.user`): React Native, iOS and Android.
  Community feed, groups, chats, vendor ads.
- **Vendor app** (`com.theturnat.vendor`): React Native. Vendors manage ads,
  chat with residents, and handle billing.
- **Admin panel** (`theturn-admin`): community admins approve vendors and
  moderate content.

## Backend
- Node.js + Mongoose API on Render.
- MongoDB Atlas, database `TheTurnAt` (selected by `APP_NAME`).
- Scripts in `scripts/` must pass `dbName: process.env.APP_NAME` when
  connecting, or they hit the wrong database.

## Identity
- Email/password and Sign in with Apple.
- `APPLE_CLIENT_ID` on Render lists both bundle IDs, comma-separated.
- One account per email or Apple ID, with one role. A resident signing into the
  vendor app gets "unauthorized."

## Push notifications
- Firebase project `theturnat-prod`, using APNs authentication keys (not
  certificates).
- Resident app and vendor app each have their own key configuration in
  Firebase Cloud Messaging. Key files are in the password manager.

## Builds and signing
- GitHub Actions with fastlane match. Signing files live in the
  `theturn-credentials` repo, accessed with a fine-grained token stored as the
  `MATCH_GIT_BASIC_AUTHORIZATION` secret in each app repo.

## Payments
- Vendor ad placements are billed through Stripe hosted checkout, outside the
  app (App Store guideline 3.1.3(g)). No in-app purchases.

## Shared knowledge
- OpenLore at `https://openlore.onrender.com`, connected to agents as the
  `openlore` MCP server.
