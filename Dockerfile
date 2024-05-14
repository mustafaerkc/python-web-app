# Adım 1: Üretim için uygun ve güvenli temel imajı kullanın
FROM python:3.9-slim AS base

# Adım 2: Uygulama kodunu Docker imajına kopyalayın ve kullanıcıyı oluşturun
WORKDIR /app
COPY . .
# Adım 3: Gerekli bağımlılıkları yükleyin
RUN pip install --no-cache-dir -r requirements.txt


