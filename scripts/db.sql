CREATE DATABASE app;

USE app;

CREATE TABLE todos
    (
        id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        description VARCHAR(144) NOT NULL,
        priority INT(2) UNSIGNED CHECK ( priority >= 1 AND priority <= 10 ),
        complete BOOLEAN DEFAULT FALSE
    );
