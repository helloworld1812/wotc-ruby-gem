# Changelog

## 0.1.15 (unreleased)

- Every 4xx and 5xx from wotc.com now raises. Named statuses get their own
  class (403 → `WOTC::Forbidden`, 422 → `WOTC::UnprocessableEntity`,
  429 → `WOTC::TooManyRequests`); anything unnamed raises `WOTC::ClientError`
  or `WOTC::ServerError`. Previously a 403 — and any status without a `case`
  arm — passed through as if the request had succeeded, which is how a 403
  came to look like a revoked token (WS-50887). All new classes subclass
  `WOTC::Error`, so existing rescues still catch them.
- New: `WOTC::Client#token_state` → `:valid` / `:revoked` / `:unknown`.
  Only a 401 means `:revoked`; a 403, a 5xx, a timeout or an unreadable body
  is `:unknown` and must not be treated as revocation. `token_valid?` is kept
  for compatibility and now delegates to `token_state`, collapsing `:revoked`
  and `:unknown` into the same `false`.
- `WOTC::MissingRequiredArgument` now subclasses `StandardError` and takes a
  plain message; it previously inherited `Error#initialize(response)` and
  crashed at the raise site.

## 0.1.14 (2026-03-16)

- Error middleware handles `Faraday::Response` correctly. Before this, every
  raise from the middleware crashed with `NoMethodError` on `Faraday::Env`,
  so no typed `WOTC::*` error had ever reached a caller.

## 0.1.13 and earlier

- Untracked.
