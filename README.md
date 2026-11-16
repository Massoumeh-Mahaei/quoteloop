# QuoteLoop

QuoteLoop helps small service businesses turn more estimates into booked work.

The first release is a single-user workspace for tracking clients, jobs, quotes,
and the follow-ups that need attention.

## Product scope: version 1

- Create and view clients
- Record a job for a client
- Create quote revisions while keeping quote history
- Track a quote through Draft, Sent, Won, Lost, or Expired
- Schedule and complete follow-ups
- See due follow-ups and open quote value on a dashboard

Not included in version 1: authentication, team accounts, email/SMS delivery,
payments, accounting integrations, or AI features.

## Planned stack

- Frontend: React + TypeScript (Vite)
- Backend: Go 1.22+ REST API with Clean Architecture
- Database: PostgreSQL
- Local development: Docker Compose

## Repository layout

```text
backend/     Go API
frontend/    React + TypeScript application
docs/        Product and technical decisions