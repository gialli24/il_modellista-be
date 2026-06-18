-- 1. Creazione del Database
CREATE DATABASE il_modellista;

USE il_modellista;

-- 2. Tabella dei Post
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    thumbnail_url VARCHAR(500) NOT NULL,
    content TEXT NOT NULL,
    likes_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabella dei Media (Foto e Video per i post)
CREATE TABLE IF NOT EXISTS post_media (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    media_url VARCHAR(500) NOT NULL,
    media_type ENUM('image', 'video') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- 4. Tabella delle Categorie (Statico, Dinamico, Miniature, ecc.)
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Tabella di Relazione Post-Categorie (Molti-a-Molti)
CREATE TABLE IF NOT EXISTS post_categories (
    post_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (post_id, category_id),
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- 6. Tabella dei Commenti e Risposte (Struttura ad Albero)
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    -- Se parent_comment_id è NULL, è un commento principale. 
    -- Se contiene un ID, è una risposta a quel determinato commento.
    parent_comment_id INT DEFAULT NULL, 
    content TEXT NOT NULL,
    likes_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_comment_id) REFERENCES comments(id) ON DELETE CASCADE
);

-- 7. Indici per ottimizzare le performance delle query
CREATE INDEX idx_post_media_post_id ON post_media(post_id);
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_parent_id ON comments(parent_comment_id);