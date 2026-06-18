const conn = require('../database/db');

const index = (req, res) => {
    const sql = "SELECT * FROM posts";

    conn.query(sql, (err, results) => {
        if (err) return res.status(500).send("Internal Server Error");
        res.json(results);
    })
}

module.exports = { index }