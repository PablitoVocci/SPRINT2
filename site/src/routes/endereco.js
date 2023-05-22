var express = require("express");
var router = express.Router();
console.log("estou na endereço routes");
var enderecoController = require("../controllers/enderecoController");

router.get("/", function (req, res) {
    enderecoController.testar(req, res);
});
console.log("Estou na routes");
router.get("/listar", function (req, res) {
    enderecoController.listar(req, res);
});

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    enderecoController.cadastrar(req, res);
})

router.post("/autenticar", function (req, res) {
    enderecoController.entrar(req, res);
});

module.exports = router;