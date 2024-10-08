const express = require("express")
const app = express()

const plusHandler = (req, res) => {
    const result = parseInt(req.params.num1) + parseInt(req.params.num2);
    res.json(result);
};

app.get("/", (req, res) => res.send("Hello World!"))
app.get("/getcode", (req, res) => res.send("halo"))
app.get("/plus/:num1/:num2",plusHandler)
const server = app.listen(3002, () => console.log("Example app listening on port 3002!"))

module.exports = {
    plusHandler,
    server
}
