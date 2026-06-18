const express = require('express');
const app = express();
const port = 3000;

/* Cors middleware */
const cors = require('cors');
app.use(cors());

app.get('/', (req, res) => {
    res.send("Il Modellista | Backend");
});

app.listen(port, () => {
    console.log(`Server in ascolto su http://localhost:${port}`);
})