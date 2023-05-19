var express = require("express");
var router = express.Router();
console.log("estou na pfisica rotes");
var pFisicaController = require("../controllers/pFisicaController");

router.get("/", function (req, res) {
    pFisicaController.testar(req, res);
});

router.get("/listar", function (req, res) {
    pFisicaController.listar(req, res);
});

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    pFisicaController.cadastrar(req, res);
})

router.post("/autenticar", function (req, res) {
    pFisicaController.entrar(req, res);
});

module.exports = router;