-- PostgreSQL Music Store Database Schema

-- 1. genre Table
CREATE TABLE genre (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(120)
);

-- 2. media_type Table
CREATE TABLE media_type (
    media_type_id SERIAL PRIMARY KEY,
    name VARCHAR(120)
);

-- 3. artist Table
CREATE TABLE artist (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(120)
);

-- 4. album Table
CREATE TABLE album (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(160) NOT NULL,
    artist_id INT REFERENCES artist(artist_id) ON DELETE CASCADE
);

-- 5. employee Table
CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    last_name VARCHAR(20) NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    title VARCHAR(30),
    reports_to INT REFERENCES employee(employee_id),
    birthdate TIMESTAMP,
    hire_date TIMESTAMP,
    address VARCHAR(70),
    city VARCHAR(40),
    state VARCHAR(40),
    country VARCHAR(40),
    postal_code VARCHAR(10),
    phone VARCHAR(24),
    fax VARCHAR(24),
    email VARCHAR(60)
);

-- 6. customer Table
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    company VARCHAR(80),
    address VARCHAR(70),
    city VARCHAR(40),
    state VARCHAR(40),
    country VARCHAR(40),
    postal_code VARCHAR(10),
    phone VARCHAR(24),
    fax VARCHAR(24),
    email VARCHAR(60) NOT NULL,
    support_rep_id INT REFERENCES employee(employee_id)
);

-- 7. invoice Table
CREATE TABLE invoice (
    invoice_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id) ON DELETE CASCADE,
    invoice_date TIMESTAMP NOT NULL,
    billing_address VARCHAR(70),
    billing_city VARCHAR(40),
    billing_state VARCHAR(40),
    billing_country VARCHAR(40),
    billing_postal_code VARCHAR(10),
    total NUMERIC(10,2) NOT NULL
);

-- 8. track Table
CREATE TABLE track (
    track_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    album_id INT REFERENCES album(album_id) ON DELETE SET NULL,
    media_type_id INT REFERENCES media_type(media_type_id),
    genre_id INT REFERENCES genre(genre_id),
    composer VARCHAR(220),
    milliseconds INT NOT NULL,
    bytes INT,
    unit_price NUMERIC(10,2) NOT NULL
);

-- 9. invoice_line Table
CREATE TABLE invoice_line (
    invoice_line_id SERIAL PRIMARY KEY,
    invoice_id INT REFERENCES invoice(invoice_id) ON DELETE CASCADE,
    track_id INT REFERENCES track(track_id),
    unit_price NUMERIC(10,2) NOT NULL,
    quantity INT NOT NULL
);

-- 10. playlist Table
CREATE TABLE playlist (
    playlist_id SERIAL PRIMARY KEY,
    name VARCHAR(120)
);

-- 11. playlist_track Table
CREATE TABLE playlist_track (
    playlist_id INT REFERENCES playlist(playlist_id) ON DELETE CASCADE,
    track_id INT REFERENCES track(track_id) ON DELETE CASCADE,
    PRIMARY KEY (playlist_id, track_id)
);
