var express = require("express");
var router = express.Router();
console.log("estou na setor rotes");
var setorController = require("../controllers/setorController");

router.get("/", function (req, res) {
    setorController.testar(req, res);
});
console.log("Estou na routes");
router.get("/listar", function (req, res) {
    setorController.listar(req, res);
});

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    setorController.cadastrar(req, res);
})

router.post("/autenticar", function (req, res) {
    setorController.entrar(req, res);
});

module.exports = router;