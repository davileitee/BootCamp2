# Estágio 1: Build (Construção)
FROM node:18-alpine AS builder
WORKDIR /app

# Copia apenas arquivos de definição de dependências
COPY package*.json ./

# Instala todas as dependências (incluindo as de desenvolvimento)
RUN npm install

# Copia o restante do código e gera o build (se houver)
COPY . .
# Se você usa TypeScript ou algum bundler, descomente a linha abaixo:
# RUN npm run build

---

# Estágio 2: Produção (Imagem Final)
FROM node:18-alpine AS runner
WORKDIR /app

# Define a variável de ambiente para produção (otimiza alguns frameworks)
ENV NODE_ENV=production

# Copia APENAS as dependências de produção do estágio anterior
COPY --from=builder /app/package*.json ./
RUN npm install --only=production

# Copia apenas os arquivos necessários (ex: pasta dist ou arquivos JS)
COPY --from=builder /app .

# Expor a porta
EXPOSE 3000

# Comando para rodar a aplicação
CMD ["npm", "start"]
