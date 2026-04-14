# Sistema de Gestão de Almoxarifado

Aplicativo desenvolvido em **Flutter** para controle de estoque e movimentações de produtos em almoxarifado. Permite cadastro de usuários, produtos, entradas, saídas e dashboard com indicadores.

## Tecnologias Utilizadas

* Flutter
* Dart
* Provider
* HTTP
* Node.js
* Express
* JSON API

## Funcionalidades

* Login de usuários
* Cadastro de produtos
* Listagem de produtos
* Movimentação de entrada
* Movimentação de saída
* Dashboard com gráficos
* Controle de estoque baixo
* Tema escuro/claro

## Como Rodar o Projeto

### Frontend

1. Clone o repositório:

```bash
git clone link-do-repositorio
```

2. Instale as dependências:

```bash
flutter pub get
```

3. Execute o projeto:

```bash
flutter run
```

### Backend

1. Instale as dependências:

```bash
npm install
```

2. Inicie o servidor:

```bash
npm start
```

ou

```bash
node server.js
```

## Configuração da API (Render)

Antes de executar o aplicativo, altere a URL da API no arquivo:

```text
lib/config/api_config.dart
```

Substitua pela URL do seu servidor hospedado no Render:

```dart
const String baseUrl = 'https://SEU-PROJETO.onrender.com';
```

### Exemplo:

```dart
const String baseUrl = 'https://almoxarifado-api.onrender.com';
```

Após alterar, execute novamente:

```bash
flutter pub get
flutter run
```

## Observações

* Caso utilize o plano gratuito do Render, o servidor pode demorar alguns segundos para responder na primeira requisição.
* Verifique se o backend está online antes de testar o aplicativo.

## Autor

Desenvolvido por Samira Pistore
