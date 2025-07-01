# Use uma imagem oficial do Python como imagem pai.
# A versão alpine é leve, o que é ótimo para produção.
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# Fazemos isso primeiro para aproveitar o cache de camadas do Docker.
COPY requirements.txt .

# Instala as dependências
# --no-cache-dir: Desativa o cache, o que reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o resto do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para o mundo fora deste contêiner
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner for iniciado
# --host 0.0.0.0: Torna o servidor acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
