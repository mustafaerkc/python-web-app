# Adım 1: Üretim için uygun ve güvenli temel imajı kullanın
FROM python:3.9-slim AS base

# Adım 2: Uygulama kodunu Docker imajına kopyalayın ve kullanıcıyı oluşturun
WORKDIR /app
COPY . .
# Adım 3: Gerekli bağımlılıkları yükleyin
RUN pip install --no-cache-dir -r requirements.txt

# Adım 4: Üretim için optimize edilmiş küçük boyutlu imaj oluşturun
FROM python:3.9-slim AS production

# Adım 5: Kullanıcıyı oluşturun ve uygulama kodunu kopyalayın
RUN groupadd -g 1000 appuser && useradd -r -u 1000 -g appuser appuser
WORKDIR /app
COPY --from=base --chown=appuser:appuser /app /app
COPY --from=base --chown=appuser:appuser /usr/local /usr/local

# Adım 6: Kullanıcıyı değiştirin ve uygulamayı çalıştırın
USER appuser
CMD ["python", "app.py"]
