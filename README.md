
# Project Base Node.js

Este projeto é um **boilerplate** para a criação de novas aplicações Node.js, pronto para CI/CD e publicação em Docker.

## Objetivo

Fornecer uma estrutura inicial organizada e padronizada, facilitando o desenvolvimento de novos projetos com Node.js, promovendo boas práticas e agilidade na configuração inicial.

## Estrutura do Projeto

- **src/**: Código-fonte principal
   - **controllers/**: Lógica dos controladores
   - **repositories/**: Acesso a dados
   - **routes/**: Definição das rotas
   - **services/**: Lógica de negócio
- **tests/**: Testes automatizados (unitários e de integração)
- **index.js**: Ponto de entrada da aplicação
- **package.json**: Gerenciamento de dependências
- **eslint.config.js**: Configuração do ESLint

---

## 🚀 Como rodar localmente

```bash
npm install
npm start
```
Acesse em [http://localhost:3000](http://localhost:3000).

---

## 🐳 Publicação e uso com Docker

### Build da imagem

```bash
docker build -t meu-app-node .
```

### Rodando o container

```bash
docker run -p 3000:3000 meu-app-node
```

A aplicação estará disponível em [http://localhost:3000](http://localhost:3000).

---

on:
jobs:

on:
jobs:
## ⚙️ Pipeline CI/CD

Este projeto conta com uma pipeline de integração e entrega contínua (CI/CD) altamente automatizada, utilizando o GitHub Actions e um workflow reutilizável hospedado em outro repositório. A seguir, detalhamos cada etapa, variáveis, validações e boas práticas:

### Visão Geral

A pipeline é disparada automaticamente a cada push na branch `main` (ou outras branches configuradas). Ela garante que todo código enviado para o repositório passe por validações rigorosas antes de ser publicado como imagem Docker.

### Etapas detalhadas da pipeline

1. **Checkout do código**
  - O workflow faz o checkout do código-fonte do repositório para o runner do GitHub Actions.

2. **Configuração do Node.js**
  - Define a versão do Node.js a ser utilizada (ex: 20.x), garantindo ambiente consistente para build e testes.

3. **Instalação de dependências**
  - Executa `npm install` para instalar todas as dependências do projeto, conforme o `package.json`.

4. **Execução dos testes automatizados**
  - Roda todos os testes unitários e de integração definidos no projeto.
  - Se qualquer teste falhar, a pipeline é interrompida e o build Docker não é realizado.
  - Os resultados dos testes ficam disponíveis nos logs do workflow.

5. **Build da aplicação**
  - Caso haja etapa de build (ex: transpilar TypeScript, gerar arquivos estáticos), ela é executada aqui.

6. **Build da imagem Docker**
  - Utiliza o Dockerfile do projeto para construir uma imagem Docker da aplicação.
  - A tag da imagem normalmente utiliza o hash do commit (`${{ github.sha }}`) para garantir rastreabilidade.

7. **Login no Docker Registry**
  - Realiza login no Docker Hub (ou outro registry) usando as secrets configuradas no repositório.
  - As secrets necessárias são:
    - `DOCKERHUB_USERNAME`: usuário do Docker Hub
    - `DOCKERHUB_PASSWORD`: token de acesso do Docker Hub (nunca use senha diretamente)

8. **Push da imagem Docker**
  - Publica a imagem Docker construída para o registry configurado.
  - Permite que a imagem seja utilizada em ambientes de produção, homologação, etc.

9. **Deploy automático (opcional)**
  - Caso configurado, pode acionar um deploy automático após o push da imagem.

### Uso de reusable workflow

Esta pipeline utiliza um **reusable workflow** hospedado em outro repositório:

```
HiagoScierry/simple-workflow-nodejs-boilerplate/.github/workflows/nodejs-reusable.yml@main
```

Isso garante padronização, reuso e fácil manutenção das etapas de CI/CD entre múltiplos projetos. Para utilizar, basta referenciar o workflow externo no seu arquivo local:

```yaml
jobs:
  build-and-push:
   uses: HiagoScierry/simple-workflow-nodejs-boilerplate/.github/workflows/nodejs-reusable.yml@main
   secrets: inherit
```

### Variáveis e secrets

- **Secrets obrigatórias:**
  - `DOCKERHUB_USERNAME` e `DOCKERHUB_PASSWORD` devem ser configuradas nas configurações do repositório (Settings > Secrets and variables > Actions).
  - Essas secrets são usadas para autenticar no Docker Hub e publicar a imagem.
- **Outras variáveis:**
  - O workflow pode aceitar variáveis extras para customização (consulte o reusable workflow para detalhes).

### Validações e boas práticas

- **Testes são obrigatórios:** O build e a publicação Docker só ocorrem se todos os testes passarem.
- **Imagens versionadas:** Use sempre tags únicas (ex: hash do commit) para rastrear builds.
- **Segurança:** Nunca exponha secrets no código ou logs. Use sempre o mecanismo de secrets do GitHub.
- **Padronização:** O uso de reusable workflow facilita a manutenção e padronização entre projetos.

### Exemplo de workflow local (`.github/workflows/ci-cd.yml`):

```yaml
name: CI/CD

on:
  push:
   branches: [main]

jobs:
  build-and-push:
   uses: HiagoScierry/simple-workflow-nodejs-boilerplate/.github/workflows/nodejs-reusable.yml@main
   secrets: inherit
```

> **Importante:**
> - Configure as secrets `DOCKERHUB_USERNAME` e `DOCKERHUB_PASSWORD` no repositório para permitir o login e o push da imagem Docker.
> - O workflow acima utiliza um workflow reutilizável (reusable workflow) de outro repositório, promovendo padronização e reuso entre projetos.

---

## Recomendações

- Utilize o ESLint para manter o padrão de código.
- Organize novas funcionalidades seguindo a estrutura proposta.
- Escreva testes para garantir a qualidade do código.
- Use caminhos relativos nos imports para garantir compatibilidade com Docker e Node.js ES Modules.
- O servidor deve escutar em `0.0.0.0` para funcionar no Docker.

---

Sinta-se à vontade para customizar este boilerplate conforme as necessidades do seu projeto!
