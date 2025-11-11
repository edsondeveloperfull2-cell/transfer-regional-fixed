# 🚗 Transfer Regional - MVP (Backend + Frontend)

Protótipo funcional de um sistema simples de **transfer regional executivo**, com backend em **Node.js + Express** e frontend em **HTML, CSS e JavaScript puro**.

💻  Scripts Disponíveis

Comando       	        Descrição
npm start           	Inicia o servidor
npm run dev	         Inicia com Nodemon
npm test           	Roda testes Jest (se configurados)

## 📦 Estrutura do Projeto

ransfer-regional-fixed/
│
├── server.js # Ponto de entrada do servidor
├── package.json # Configurações e dependências
├── src/
│ ├── app.js # Configuração principal do Express
│ ├── routes/
│ │ ├── reservas.js # Rotas para reservas
│ │ └── cotacao.js # Rotas para cotações
│ └── data/
│ └── reservas.json # Armazena dados das reservas
│
└── public/ # Frontend estático
├── index.html # Página principal
├── css/
│ └── styles.css
└── js/
└── reservation-ui.js

🧩 Tecnologias Utilizadas

Node.js 18+

Express.js

Body-parser

Nodemon

Jest + Supertest (para testes)

HTML5 / CSS3 / JS Vanilla

📁 Frontend (Pasta public/)

index.html: interface principal.

js/reservation-ui.js: integração com a API.

css/styles.css: layout limpo e responsivo.

🧱 Melhorias Futuras

Banco de dados (PostgreSQL ou MongoDB)

Login de usuários

Integração com APIs de mapas

Dashboard administrativo

Autor

Edson Developer Full
📧 Contato: GitHub
