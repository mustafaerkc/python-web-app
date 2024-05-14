# Adım 1: Üretim için uygun ve güvenli temel imajı kullanın
FROM python:3.9-slim AS base

# Adım 2: Uygulama kodunu Docker imajına kopyalayın ve gerekli bağımlılıkları yükleyin
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

# Adım 3: Kullanıcıyı oluşturun ve uygulamayı çalıştırın
RUN groupadd -g 1000 appuser && useradd -r -u 1000 -g appuser appuser
USER appuser
CMD ["python", "app.py"]
