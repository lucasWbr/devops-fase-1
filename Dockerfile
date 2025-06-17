# Use nginx alpine para manter a imagem leve
FROM nginx:alpine

# Copiar arquivos da aplicação para o diretório padrão do nginx
COPY website/ /usr/share/nginx/html/

# Copiar configuração customizada do nginx se necessário
COPY nginx.conf /etc/nginx/nginx.conf

# Expor porta 80
EXPOSE 80

# Comando padrão do nginx
CMD ["nginx", "-g", "daemon off;"] 