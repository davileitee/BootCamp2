# ESTÁGIO 1: Build (Onde instalamos tudo e compilamos)
FROM node:18-alpine AS builder
WORKDIR /app

# Copia apenas os arquivos de dependências primeiro (cache eficiente)
COPY package*.json ./
RUN npm install --frozen-lockfile

# Copia o código e faz o build (se houver passo de build, ex: TS ou React)
COPY . .
# RUN npm run build  <-- Ative se você tiver uma pasta /dist ou /build

---

# ESTÁGIO 2: Produção (A imagem que será enviada ao registro)
FROM node:18-alpine AS runner
WORKDIR /app

# Definir ambiente como produção para o Node otimizar performance
ENV NODE_ENV=production

# Copia APENAS as dependências de produção (ignora devDependencies)
COPY package*.json ./
RUN npm install --only=production --ignore-scripts

# Copia apenas os arquivos necessários do estágio de build
# Se você tiver uma pasta /dist, substitua o "." abaixo por "dist"
COPY --from=builder /app .

# Remove caches de pacotes que o npm deixa pra trás
RUN rm -rf /root/.npm

EXPOSE 3000
CMD ["npm", "start"]
