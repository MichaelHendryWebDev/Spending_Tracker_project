DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE budget;

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  state BOOLEAN
);

CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  merchant_id INT REFERENCES merchants(id) ON DELETE CASCADE,
  tag_id INT REFERENCES tags(id) ON DELETE CASCADE,
  amount INT
);

CREATE TABLE budget (
  id SERIAL PRIMARY KEY,
  budget INT
)
