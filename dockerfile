# Escolhe uma imagem oficial do Node.js
FROM node:20-alpine

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de dependências
COPY package*.json ./

# Instala as dependências
RUN npm install --production

# Copia o restante da aplicação
COPY . .

# Expõe a porta padrão (ajuste se necessário)
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["node", "index.js"]
