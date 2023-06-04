var database = require("../database/config");
function buscarIds(nomeSetor){

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select ss.idSensor from sensor ss inner join servidor s on ss.fkServidor = s.idServidor inner join setorEmpresa se on s.fkSetorEmp = se.idSetorEmp where se.nome = '${nomeSetor}'`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `
        select ss.idSensor from sensor ss inner join servidor s on ss.fkServidor = s.idServidor inner join setorEmpresa se on s.fkSetorEmp = se.idSetorEmp where se.nome = '${nomeSetor}';
        `;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarUltimasMedidas(idAquario, limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        temperatura as temperatura, 
        umidade as umidade,  
                        momento,
                        FORMAT(momento, 'HH:mm:ss') as momento_grafico
                    from medida
                    where fkSensor = ${idAquario}
                    order by id desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        temperatura as temperatura, 
        umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    from medida
                    where fkSensor = ${idAquario}
                    order by idMedida desc limit ${limite_linhas}`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


function alertaSetor(idAquario, limite_linhas) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        temperatura as temperatura, 
        umidade as umidade,  
                        momento,
                        FORMAT(momento, 'HH:mm:ss') as momento_grafico
                    from medida
                    where fkSensor = ${idAquario}
                    order by id desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select idSensor,setorEmpresa.nome as NomeSetor, temperatura as temperatura, umidade as umidade, momento, DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, setorEmpresa.fkEmpresa
        from medida 
            JOIN sensor ON medida.fkSensor = sensor.idSensor
                JOIN servidor ON sensor.fkServidor = servidor.idServidor
                    JOIN setorEmpresa ON servidor.fkSetorEmp = setorEmpresa.idSetorEmp
                        where fkSensor = ${idAquario} order by idMedida desc limit ${limite_linhas};`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {
    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        temperatura as temperatura, 
        umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fkSensor 
                        from medida where fkSensor = ${idAquario} 
                    order by idMedida desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select temperatura as temperatura, umidade as umidade, DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, fkSensor from medida where fkSensor = ${idAquario} order by idMedida desc limit 1`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    alertaSetor,
    buscarIds
}
