-- +goose Up
CREATE TABLE quotes (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    job_id BIGINT NOT NULL REFERENCES jobs(id) ON DELETE RESTRICT,
    revision_of BIGINT REFERENCES quotes(id) ON DELETE RESTRICT,
    amount_cents BIGINT NOT NULL CHECK (amount_cents >= 0),
    currency CHAR(3) NOT NULL DEFAULT 'CAD',
    valid_until DATE NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('draft', 'sent', 'won', 'lost')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE follow_ups (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    quote_id BIGINT NOT NULL REFERENCES quotes(id) ON DELETE RESTRICT,
    due_date DATE NOT NULL,
    note TEXT,
    status TEXT NOT NULL CHECK (status IN ('open', 'done', 'cancelled')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_quotes_job_id ON quotes (job_id);
CREATE INDEX idx_follow_ups_quote_id ON follow_ups (quote_id);

CREATE UNIQUE INDEX idx_one_active_quote_per_job
ON quotes (job_id)
WHERE status IN ('draft', 'sent');

CREATE UNIQUE INDEX idx_one_open_follow_up_per_quote
ON follow_ups (quote_id)
WHERE status = 'open';

-- +goose Down
DROP TABLE IF EXISTS follow_ups;
DROP TABLE IF EXISTS quotes;
