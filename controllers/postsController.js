const conn = require('../database/db');

const index = (req, res) => {
    const sql = `
        SELECT posts.*,
        GROUP_CONCAT(categories.name SEPARATOR ', ') AS category_names,
            GROUP_CONCAT(categories.slug SEPARATOR ', ') AS category_slugs
        FROM posts
        INNER JOIN post_categories ON posts.id = post_categories.post_id
        INNER JOIN categories ON post_categories.category_id = categories.id
        GROUP BY posts.id;
    `;

    conn.query(sql, (err, results) => {
        if (err) return res.status(500).send("Internal Server Error");
        res.json(results);
    })
}

const show = (req, res) => {
    const id = parseInt(req.params.id);

    const sql = `
        SELECT posts.*,
        GROUP_CONCAT(categories.name SEPARATOR ', ') AS category_names,
            GROUP_CONCAT(categories.slug SEPARATOR ', ') AS category_slugs
        FROM posts
        INNER JOIN post_categories ON posts.id = post_categories.post_id
        INNER JOIN categories ON post_categories.category_id = categories.id
        WHERE posts.id = ?
        GROUP BY posts.id;
    `;

    conn.query(sql, [id], (err, results) => {
        if (err) return res.status(500).send("Internal Server Error");
        res.json(results);
    })
}

module.exports = { index, show }