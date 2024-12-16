
# Educaterapia - Configuração e Execução

Este repositório contém o backend (PHP com Laravel) e o frontend (Flutter) do projeto **Educaterapia**.

---

## **Requisitos**

### Ferramentas Necessárias
- **PHP** (>= 8.1)
- **Composer** (Gerenciador de dependências PHP)
- **MySQL** (ou outro banco de dados configurado no projeto)
- **Node.js** (opcional, para gerenciar dependências JS no Laravel, como Mix ou Vite)
- **Flutter SDK**: Instale a versão mais recente em [flutter.dev](https://flutter.dev/).
- **Dart SDK**: Incluído no Flutter SDK.
- **Android Studio** ou **Visual Studio Code** (para edição e execução do código Flutter)
- **Git** (para clonar o repositório)

---

## **Configuração do Backend**

O backend utiliza **Laravel** e inclui **migrations** e **seeders** para configurar o banco de dados.

### 1. Clone o repositório
```bash
git clone https://github.com/jajpert/innova.git
```

Acesse o diretório do backend:
```bash
cd innova/educaterapia/educaterapia_back
```

### 2. Instale as dependências do Laravel
```bash
composer install
```

### 3. Configure o arquivo `.env`
- Copie o arquivo de exemplo:
  ```bash
  cp .env.example .env
  ```
- Edite o arquivo `.env` e configure os parâmetros como o banco de dados

### 4. Gere a chave da aplicação
```bash
php artisan key:generate
```

### 5. Execute as migrations e os seeders
- Crie as tabelas no banco de dados:
  ```bash
  php artisan migrate
  ```
- Popule o banco de dados com dados iniciais:
  ```bash
  php artisan db:seed
  ```

### 6. Inicie o servidor
```bash
php artisan serve
```
O servidor estará disponível em [http://localhost:8000/api](http://localhost:8000/api).

---

## **Configuração do Frontend**

O frontend foi desenvolvido com **Flutter**.

### 1. Acesse o diretório do frontend
```bash
cd ../educaterapia_front
```

### 2. Instale as dependências do Flutter
```bash
flutter pub get
```

### 3. Configure a URL do backend
Edite o arquivo de configuração (como `lib/config.dart` ou equivalente) para ajustar o endpoint da API:
```dart
const String BASE_API_URL = "http://localhost:8000/api";
```

### 4. Inicie o aplicativo
Certifique-se de que um emulador ou dispositivo esteja conectado, então execute:
```bash
flutter run
```

### 5. Compilação para Produção
- **Android**:
  ```bash
  flutter build apk --release
  ```
  O APK estará na pasta `build/app/outputs/flutter-apk`.

- **iOS**:
  ```bash
  flutter build ios --release
  ```
  Certifique-se de estar em um dispositivo macOS com Xcode instalado.

---

## **Resumo dos Comandos Principais**

### Backend
- Instalar dependências:
  ```bash
  composer install
  ```
- Migrations:
  ```bash
  php artisan migrate
  ```
- Seeders:
  ```bash
  php artisan db:seed
  ```
- Iniciar servidor:
  ```bash
  php artisan serve
  ```

### Frontend
- Instalar dependências:
  ```bash
  flutter pub get
  ```
- Rodar no emulador/dispositivo:
  ```bash
  flutter run
  ```
- Gerar APK:
  ```bash
  flutter build apk --release
  ```

---

## **Observações**
1. Certifique-se de que o backend esteja rodando antes de iniciar o frontend.
2. Para configurar um ambiente de produção, ajuste as variáveis de ambiente no backend e utilize serviços como **PM2** (para o backend) e distribua o APK/IPA gerado para dispositivos móveis.
3. Teste o aplicativo com a API em execução para validar a integração completa.

Para dúvidas ou contribuições, entre em contato com os mantenedores do projeto.
