# Changerlog

Todas as mudanças notáveis nestas configurações serão documentadas neste arquivo.

Possiveis ações: Adicionado, Consertado, Alterado e Removido.

## 2024-04-03

- Commit inicial.

### Adicionado

- Uso do `.chezmoidata` para declarar pacotes a serem instalados no sistema.
  - A presença de alguns pacotes desencadeiam ações extras de instalação além do apt install.
- Uso do `.chezmoiscripts` para configurar e instalar alguns dos pacotes utilizados.
  - A instalação pelo apt é declarativa em `.chezmoidata`.
  - A instalação de plugins do asdf é declarativa em `.chezmoidata`.
- Uso do `.chezmoiexternal` para incluir alguns pacotes extras na hora da instalação.
- Adicionado as configurações atuais do meu sistema.
- Adicionado as configurações do gnupg. Os arquivos são armazenados localmente apenas.
- Adicionado as configurações, chaves e hosts usados pelo ssh, gerenciado pelo keepassxc com um arquivo local e cripitografia assimétrica.
- Adicionado o `.chezmoi.yaml.tmpl` para determinar o usuário.
  - a criptografia assimétrica depende do `segredo` ser definido como verdadeiro.