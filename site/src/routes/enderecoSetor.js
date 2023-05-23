var express = require("express");
var router = express.Router();
console.log("estou na ENDEREÇO SETOR rotes");
var setorEnderecoController = require("../controllers/setorEnderecoController");

router.get("/", function (req, res) {
    setorEnderecoController.testar(req, res);
});

router.get("/listar", function (req, res) {
    setorEnderecoController.listar(req, res);
});

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    setorEnderecoController.cadastrar(req, res);
})

router.post("/autenticar", function (req, res) {
    setorEnderecoController.entrar(req, res);
});
router.post("/ultima", function (req, res) {
    setorEnderecoController.ultima(req,res);
});

module.exports = router;