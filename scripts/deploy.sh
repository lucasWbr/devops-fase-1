

set -e


IMAGE_NAME="devops-fase-1"
CONTAINER_NAME="devops-temp-container"
OUTPUT_DIR="./build-output"

echo "=== Iniciando processo de deploy ==="


echo "Limpando builds anteriores..."
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"


echo "Buildando imagem Docker..."
docker build -t "$IMAGE_NAME:latest" .


echo "Criando container temporário..."
docker run -d --name "$CONTAINER_NAME" "$IMAGE_NAME:latest"


echo "Extraindo arquivos do container..."
docker cp "$CONTAINER_NAME:/usr/share/nginx/html/." "$OUTPUT_DIR/"


echo "Limpando container temporário..."
docker rm -f "$CONTAINER_NAME"


if ! command -v aws &> /dev/null; then
    echo "ERRO: AWS CLI não encontrado. Instale o AWS CLI e configure suas credenciais."
    exit 1
fi


echo "Fazendo deploy para S3..."
if [ -n "$1" ]; then
    BUCKET_NAME="$1"
else
    BUCKET_NAME="devops-fase-1"
fi

aws s3 sync "$OUTPUT_DIR" "s3://$BUCKET_NAME" --delete

echo "=== Deploy concluído com sucesso! ==="
echo "Aplicação disponível em: http://$BUCKET_NAME.s3-website-us-east-1.amazonaws.com"


rm -rf "$OUTPUT_DIR" 