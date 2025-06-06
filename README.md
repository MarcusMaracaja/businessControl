# Business Control App 📱

Sistema de controle de vendas e estoque, desenvolvido como projeto da disciplina Programação Para Dispositivos Móveis - PROG_ORIENTADA_A_OBJETOS.

---

## 👥 Integrantes do Grupo

- Marcus Vínícius Maracajá Pires  
  

---

## 📦 Funcionalidades Implementadas

- ✅ Tela de Login com validação
- ✅ Tela de Cadastro de Usuário
- ✅ Tela Inicial com navegação entre módulos
- ✅ Cadastro de Produto
- ✅ Cadastro de Venda
- ✅ Adição de Itens à Venda
- ✅ Listagem de Produtos e Vendas
- ✅ Alteração e Remoção de Registros
- ✅ Exibição de desenvolvedor via ícone de informação na tela de login
- ✅ Integração com banco de dados local SQLite (`sqflite`)
- ✅ Uso de gerenciamento de estado com `setState`

---

## 🎥 Vídeo Explicativo

📺 Link para o vídeo:  
[**Clique aqui para assistir**](https://exemplo.com)  
*Duração: até 10 minutos*

> O vídeo mostra o funcionamento da aplicação e explica:
> - Navegação entre telas
> - Operações de CRUD
> - Implementação dos DAOs (`ProdutoDAO`, `VendaDAO`, `VendaItemDAO`)
> - Gerenciamento de estados com `setState`

---

## 🗃️ Estrutura de Banco de Dados (DAOs)

### Produto
- `id`, `nome`, `descricao`, `preco`, `estoque`

### Venda
- `id`, `data`, `total`

### VendaItem
- `id`, `venda_id`, `produto_id`, `quantidade`, `subtotal`

### DAOs utilizados:
- `ProdutoDAO`: Responsável por salvar, atualizar, deletar e buscar produtos.
- `VendaDAO`: Salva as vendas com seus dados principais.
- `VendaItemDAO`: Relaciona produtos a vendas específicas e calcula totais.

---

## ⚙️ Gerenciamento de Estado

Utilizamos o `setState` em todas as telas que precisaram de atualização dinâmica, como:

- Tela de listagem de produtos (ao adicionar/remover)
- Tela de itens da venda
- Tela de resumo da venda (soma de totais)

O `setState` foi escolhido pela simplicidade e por ser suficiente para o escopo do projeto.

---

---

## 🔗 Link do Projeto no GitHub

📂 Repositório:  
[**Clique aqui para acessar**](https://github.com/MarcusMaracaja/businessControl.git)
> Inclui todos os commits relevantes com histórico de desenvolvimento do projeto.

---

## 🎨 Layout

O layout segue as diretrizes do documento fornecido pelo professor. As telas foram organizadas conforme o modelo apresentado, com atenção à responsividade e usabilidade.

---

## 🧪 Tecnologias Utilizadas

- ✅ **Flutter** (obrigatório)
- ✅ Dart
- ✅ SQFlite (SQLite local)
- ✅ Material Design
