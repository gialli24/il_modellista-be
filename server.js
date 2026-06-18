const express = require('express');
const app = express();
const port = 3000;

/* Routers */
const postsRouter = require('./routers/posts');

/* Cors middleware */
const cors = require('cors');
app.use(cors());

app.use('/posts', postsRouter);

app.get('/', (req, res) => {
    res.send("Il Modellista | Backend");
});

app.listen(port, () => {
    console.log(`Server in ascolto su http://localhost:${port}`);
})