# Book Club App

O Book Club é um aplicativo Flutter para amantes de livros que desejam gerenciar suas leituras, acompanhar seu progresso e descobrir novos títulos. O aplicativo permite aos usuários manter uma estante virtual organizada, acompanhar seu histórico de leitura e interagir com detalhes de livros.

## Funcionalidades Principais

- **Autenticação**: Cadastro, login e recuperação de senha
- **Busca de Livros**: Pesquisa por título, autor ou ISBN, além de categorias
- **Detalhes do Livro**: Visualização de informações detalhadas sobre livros
- **Estante Virtual**: Organização de livros por status de leitura
- **Histórico de Leitura**: Acompanhamento do progresso de leitura
- **Perfil de Usuário**: Gerenciamento de informações pessoais e foto de perfil

## Arquitetura

O projeto segue os princípios da **Arquitetura Limpa (Clean Architecture)** com uma estrutura organizada por módulos:

```
lib/
├── core/                # Funcionalidades compartilhadas
├── data/                # Implementações de dados
├── domain/              # Regras de negócio e entidades
├── features/            # Módulos de funcionalidades
└── main.dart            # Ponto de entrada da aplicação
```

### Camadas da Aplicação

#### Core
Contém utilitários, configurações e componentes compartilhados entre todas as camadas:
- **config**: Configurações como cores, rotas, temas e valores constantes
- **di**: Configuração de injeção de dependência
- **error**: Tratamento de erros e exceções
- **network**: Utilitários de rede
- **storage**: Armazenamento local
- **ui**: Componentes de UI reutilizáveis
- **utils**: Funções utilitárias

#### Data
Implementa a camada de acesso a dados:
- **models**: Modelos de dados e DTOs
- **repositories**: Implementações de repositórios
- **sources**: Fontes de dados (local e remoto)

#### Domain
Define as regras de negócio e entidades do sistema:
- **entities**: Objetos do domínio
- **interfaces**: Contratos para repositórios
- **usecases**: Casos de uso que encapsulam a lógica de negócio

#### Features
Organiza o aplicativo em módulos de funcionalidades:
- **auth**: Autenticação do usuário
- **books**: Gerenciamento e visualização de livros
- **bookshelves**: Estantes virtuais de livros
- **profile**: Gerenciamento do perfil do usuário
- **search**: Busca de livros

## Tecnologias Utilizadas

- **Flutter**: Framework UI para desenvolvimento multiplataforma
- **Firebase**: Autenticação, Firestore (banco de dados) e Storage (armazenamento)
- **BLoC/Cubit**: Gerenciamento de estado
- **GetIt**: Injeção de dependência
- **Go Router**: Navegação
- **Dartz**: Programação funcional (Either para tratamento de erros)
- **Equatable**: Comparações de igualdade simplificadas
- **Formz**: Validação de formulários
- **flutter_launcher_icons**: Personalização de ícones do aplicativo
- **flutter_native_splash**: Configuração da tela de splash

## Dependências entre Camadas

- **Features** → **Domain**: Acessa entidades, interfaces e casos de uso
- **Features** → **Data** (limitado): Utiliza modelos de dados
- **Data** → **Domain**: Implementa interfaces e converte modelos para entidades
- **Todas as camadas** → **Core**: Utilizam recursos compartilhados

## Configuração do Projeto

### Pré-requisitos
- Flutter (versão mais recente)
- Firebase CLI
- IDE (VS Code ou Android Studio)

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/book-club.git
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Configure o Firebase para seu ambiente:
```bash
flutterfire configure
```

4. Execute o aplicativo:
```bash
flutter run
```

### Configuração de Ícones e Splash Screen

O projeto utiliza os pacotes `flutter_launcher_icons` e `flutter_native_splash` para personalizar o ícone do aplicativo e a tela de splash.

#### Configuração dos Ícones do Aplicativo

1. Adicione a dependência no `pubspec.yaml`:
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1
```

2. Adicione a configuração no `pubspec.yaml`:
```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/images/app_icon.png"
  min_sdk_android: 21 # android min sdk min:16, default 21
  web:
    generate: true
    image_path: "assets/images/app_icon.png"
    background_color: "#hexcode"
    theme_color: "#hexcode"
  windows:
    generate: true
    image_path: "assets/images/app_icon.png"
    icon_size: 48 # min:48, max:256, default: 48
  macos:
    generate: true
    image_path: "assets/images/app_icon.png"
```

3. Execute o comando para gerar os ícones:
```bash
flutter pub run flutter_launcher_icons
```

#### Configuração da Tela de Splash

1. Adicione a dependência no `pubspec.yaml`:
```yaml
dev_dependencies:
  flutter_native_splash: ^2.3.2
```

2. Adicione a configuração no `pubspec.yaml`:
```yaml
flutter_native_splash:
  color: "#FFFFFF"
  # background_image: "assets/images/background.png"
  image: assets/images/splash_logo.png
  
  android_12:
    image: assets/images/splash_logo.png
    icon_background_color: "#FFFFFF"
    
  web: false
```

3. Execute o comando para gerar a tela de splash:
```bash
flutter pub run flutter_native_splash:create
```

Observação: Certifique-se de que as imagens especificadas nas configurações existam nos caminhos correspondentes.

## Estrutura de Módulos

### Auth
Gerencia a autenticação do usuário com telas de login, cadastro e recuperação de senha.

### Books
Apresenta detalhes dos livros e opções para gerenciamento de leitura.

### Bookshelves
Exibe e organiza os livros do usuário por status de leitura (lido, lendo, quero ler, etc.).

### Profile
Permite ao usuário visualizar e editar suas informações pessoais e foto de perfil.

### Search
Possibilita a busca de livros por título, autor, ISBN ou categoria.

## Boas Práticas

O projeto segue as seguintes boas práticas:

- **Separação de Responsabilidades**: Cada classe tem uma responsabilidade única
- **Injeção de Dependência**: Dependências são injetadas, não criadas diretamente
- **Tratamento de Erros**: Uso de Either para tratamento elegante de erros
- **Testes**: Estrutura projetada para facilitar testes unitários e de integração
- **Padrões de Design**: Implementação de padrões como Repository, Factory e Singleton

Este projeto foi desenvolvido com foco em manutenibilidade, testabilidade e escalabilidade, permitindo a adição de novas funcionalidades de forma organizada e coesa.
