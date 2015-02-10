/* Adding effective_date & expiration_date to polling table */
ALTER TABLE polling
ADD (effective_date date, expiration_date date);

/* Adding effective_date & expiration_date to polling history table */
ALTER TABLE polling_hst
ADD (effective_date date, expiration_date date);