var enderecoModel = require("../models/enderecoModel");

var sessoes = [];
console.log("Controller endereço");
function testar(req, res) {
    console.log("ENTRAMOS NA SETORController");
    res.json("ESTAMOS FUNCIONANDO!");
}
 
function listar(req, res) {
    enderecoModel.listar()
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!")
            }
        }).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar a consulta! Erro: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function entrar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {
        
        enderecoModel.entrar(email, senha)
            .then(
                function (resultado) {
                    console.log(`\nResultados encontrados: ${resultado.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultado)}`); // transforma JSON em String

                    if (resultado.length == 1) {
                        console.log(resultado);
                        res.json(resultado[0]);
                    } else if (resultado.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function consulta(req, res) {
    var fk = req.body.fkServer;
    console.log("FKSERVER: "+ fk);
    if (fk == undefined) {
        res.status(400).send("Sua fk está undefined!");
    } else {
        
        enderecoModel.consulta(fk)
            .then(
                function (resultado) {
                    console.log(`\nResultados encontrados: ${resultado.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultado)}`); // transforma JSON em String

                    // if (resultado.length == 1) {
                    //     console.log(resultado);
                    //     res.json(resultado[0]);
                    // } else if (resultado.length == 0) {
                    //     res.status(403).send("Email e/ou senha inválido(s)");
                    // } else {
                    //     res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    // }
                    if (resultado.length > 0) {
                        res.status(200).json(resultado);
                    } else {
                        res.status(204).send("Nenhum resultado encontrado!")
                    }
                    console.log("Estou no método de consulta");
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var pais = req.body.paisServer;
    var cep = req.body.cepServer;
    var estado = req.body.estadoServer;
    var cidade = req.body.cidadeServer;
    var bairro = req.body.bairroServer;
    var rua = req.body.ruaServer;
    var fk = req.body.fkEmpresaServer;

    // Faça as validações dos valores
    if (pais == undefined) {
        res.status(400).send("Seu País está undefined!");
    } else if (cep == undefined) {
        res.status(400).send("Seu CEP está undefined!");
    }else if (estado == undefined) {
        res.status(400).send("Seu Estado está undefined!");
    }else if (cidade == undefined) {
        res.status(400).send("Seu Cidade está undefined!");
    }else if (bairro == undefined) {
        res.status(400).send("Seu Bairro está undefined!");
    }else if (rua == undefined) {
        res.status(400).send("Seu Rua está undefined!");
    }else {
        
        // Passe os valores como parâmetro e vá para o arquivo enderecoModel.js
        enderecoModel.cadastrar(pais,cep,estado,cidade,bairro,rua,fk)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    entrar,
    cadastrar,
    listar,
    consulta
}