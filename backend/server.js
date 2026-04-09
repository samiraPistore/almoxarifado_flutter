import express from "express";
import cors from "cors";
import { randomUUID } from "crypto"; // gerar id único e aleatório
import fs, { read } from "fs"; // mexer com o arquivo json para armazenar dados sem db

const app = express();
app.use(cors());
app.use(express.json());

const DB_FILE = "./data.json"; // arquivo onde estarão os dados

//abre o arquivo json
function readData() {
  const data = fs.readFileSync(DB_FILE);
  return JSON.parse(data);
}

//salva os dados
function saveData(data) {
  fs.writeFileSync(DB_FILE, JSON.stringify(data, null, 2));
}

//CRUD USERS
//GET
app.get("/users", (req, res) => {
  const data = readData();
  res.json(data.users);
});

//POST
app.post("/users", (req, res) => {
  const data = readData();
  //User armazenado no json
  const novoUser = {
    id: randomUUID(),
    nome: req.body.nome,
    cargo: req.body.cargo,
    email: req.body.email,
    senha: req.body.senha,
  };
  data.users.push(novoUser);
  saveData(data);

  res.json(novoUser);
});

//DELETE
app.delete("/users/:id", (req, res) => {
  const data = readData();
  const id = req.params.id;
  const novosUsers = data.users.filter((p) => p.id !== id);
  data.users = novosUsers;
  saveData(data);
  res.json({ msg: "Produto deletado com sucesso" });
});

//UPDATE
app.put("/users/:id", (req, res) => {
  const data = readData();
  const id = req.params.id;

  const index = data.users.findIndex((p) => p.id === id);
  data.users[index] = {
    ...data.users[index],
    ...req.body,
  };

  saveData(data);

  res.json(data.users[index]);
});

//CRUD PRODUTOS
//GET
app.get("/produtos", (req, res) => {
  const data = readData();
  res.json(data.produtos);
});

//POST
app.post("/produtos", (req, res) => {
  const data = readData();

  const novoProduto = {
    id: randomUUID(),
    nome: req.body.nome,
    codigo: req.body.codigo,
    categoria: req.body.categoria,
    uniMedida: req.body.uniMedida,
    qtdMin: req.body.qtdMin,
    qtdAtual: req.body.qtdAtual,
    localEstoq: req.body.localEstoq,
    valorUni: req.body.valorUni,
  };

  data.produtos.push(novoProduto);
  saveData(data);

  res.json(novoProduto);
});

//DELETE
app.delete("/produtos/:id", (req, res) => {
  const data = readData();
  const id = req.params.id;
  const novosProdutos = data.produtos.filter((p) => p.id !== id);
  data.produtos = novosProdutos;
  saveData(data);
  res.json({ msg: "Produto deletado com sucesso" });
});

//UPDATE
app.put("/produtos/:id", (req, res) => {
  const data = readData();
  const id = req.params.id;
  const index = data.produtos.findIndex((p) => p.id === id);

  data.produtos[index] = {
    ...data.produtos[index], // mantém o que já existe
    ...req.body, // sobrescreve com novos dados
  };

  saveData(data);

  res.json(data.produtos[index]);
});

//CRUD MOVIMENTAÇÕES
//GET
app.get("/movimentacoes", (req, res) => {
  const data = readData();
  res.json(data.movimentacoes);
});

//POST
app.post("/movimentacoes", (req, res) => {
  const data = readData();

  const novaMoviment = {
    id: randomUUID(),
    produtoId: req.body.produtoId,
    tipo: req.body.tipo,
    quantidade: Number(req.body.quantidade),
    data: new Date().toISOString(),
    responsavel: req.body.responsavel,
    obs: req.body.obs || null,
    destino: req.body.destino || null,
  };

  const produto = data.produtos.find((p) => p.id === req.body.produtoId); //buscar id do produto relacionado a movimentação

  if (!produto) {
    return res.status(404).json({ msg: "Produto não encontrado" });
  }

  produto.qtdAtual = Number(produto.qtdAtual);

  if (req.body.tipo === "entrada") {
    produto.qtdAtual += novaMoviment.quantidade;
  } else if (req.body.tipo === "saída") {
    produto.qtdAtual -= novaMoviment.quantidade;
  }

  data.movimentacoes.push(novaMoviment);
  saveData(data);

  res.json(novaMoviment);
});

//DELETE
app.delete("/movimentacoes/:id", (req, res) => {
  const data = readData();
  const id = req.params.id;

  const moviment = data.movimentacoes.find((m) => m.id === id);

  if (!moviment) {
    return res.status(404).json({ msg: "Movimentação não encontrada" });
  }

  // 🔹 acha o produto
  const produto = data.produtos.find((p) => p.id === moviment.produtoId);

  if (!produto) {
    return res.status(404).json({ msg: "Produto não encontrado" });
  }

  produto.qtdAtual = Number(produto.qtdAtual);
  const quantidade = Number(moviment.quantidade);

  if (moviment.tipo === "entrada") {
    produto.qtdAtual -= quantidade;
  } else if (moviment.tipo === "saida") {
    produto.qtdAtual += quantidade;
  }

  data.movimentacoes = data.movimentacoes.filter((m) => m.id !== id);

  saveData(data);

  res.json({ msg: "Movimentação deletada com sucesso" });
});

app.put("/movimentacoes/:id", (req, res) => {
  const data = readData();
  const id = req.params.id;

  const moviment = data.movimentacoes.find((m) => m.id === id);

  if (!moviment) {
    return res.status(404).json({ msg: "Movimentação não encontrada" });
  }

  const produto = data.produtos.find((p) => p.id === moviment.produtoId);

  if (!produto) {
    return res.status(404).json({ msg: "Produto não encontrado" });
  }

  produto.qtdAtual = Number(produto.qtdAtual);

  const quantidadeAntiga = Number(moviment.quantidade);

  if (moviment.tipo === "entrada") {
    produto.qtdAtual -= quantidadeAntiga;
  } else if (moviment.tipo === "saida") {
    produto.qtdAtual += quantidadeAntiga;
  }

  const { tipo, quantidade, responsavel, obs, destino } = req.body;

  const novaQuantidade = Number(quantidade);

  if (tipo === "entrada") {
    produto.qtdAtual += novaQuantidade;
  } else if (tipo === "saida") {
    produto.qtdAtual -= novaQuantidade;
  }

  moviment.tipo = tipo;
  moviment.quantidade = novaQuantidade;
  moviment.responsavel = responsavel;
  moviment.obs = obs || null;
  moviment.destino = destino || null;

  saveData(data);

  res.json(moviment);
});

//Dashboard
app.get("/dashboard", async (req, res) => {
  const data = readData();

  const produtos = data.produtos;
  const movimentacoes = data.movimentacoes;

  const totalProd = produtos.length;
  const totalMov = movimentacoes.length;
  
  
  let totalEntrada = 0;
  let totalSaida = 0;
  for(const m of movimentacoes){
    if(m.tipo === 'entrada'){
        totalEntrada += 1;
    }else if(m.tipo === 'saída'){
        totalSaida +=1;
    }
  }

   let estoqueBaixo = 0;
   for(const p of produtos){
    if(p.qtdAtual <= p.qtdMin){
        estoqueBaixo +=1;
    }
   }
  


  res.json({ totalMov, totalProd, totalEntrada, totalSaida, estoqueBaixo});
});
//RODA O SERVER
app.listen(process.env.PORT ?? 3001, () => {
  console.log("Servidor rodando na porta 3001");
});
