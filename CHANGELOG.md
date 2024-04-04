# Changerlog

Todas as mudanças notáveis nestas configurações serão documentadas neste arquivo.

Possiveis ações: Adicionado, Consertado, Alterado e Removido.

## 2024-04-04

### Adicionado

- O pacote `nautilus-admin` para abrir arquivos como adiministrador diretamente.
- Um script para configurar o `sudoers` e evitar que crie o arquivo `~/.sudo_as_admin_successful`, o removendo caso exista.
- Uma variavel de ambiente para fazer com que o `vscode` se comporte de forma portavel, ou seja, SEM POLUIR MINHA HOME usando apenas a pasta em `XDG_DATA_HOME/vscode`. Posso usar essa pasta para portar tudo, ou apenas usar alguns arquivos para manter as configurações e extensões sincronizadas.

### Consertado

- Instalação do lazygit sempre mostrando a taxa de download quando deveria mostrar nada.
- apt install que estava pedindo permissão do usuário para instalar quando deveria ter a flag -y para aceitar tudo.

### Alterado

- O diretório padrão das pastas de usuário. Agora todas ficam localizadas dentro da pasta `~/Arquivos` para dar liberdade de fazer o que quiser ai dentro sem problema de mecher em nenhuma configuração nem ver seus arquivos ocultos.
- O `Nautilus` foi configurado para abrir diretamente em `~/Arquivos/` de forma a evitar que eu veja meus arquivos de configurações em uma home mais limpa.
- Todas as variaveis de ambiente agora são declaradas no `.zshenv` para garantir que qualquer processo tenha acesso a elas, visto que não são necessárias apenas em um terminal interativo. Revisando, `.zshenv` sempre está disponivel e atualizado. `.zshrc` somente quando abrir um terminal interativo.

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