# Changerlog

Todas as mudanças notáveis nestas configurações serão documentadas neste arquivo.

Possiveis ações: Adicionado, Consertado, Alterado e Removido.

## 2024-05-18

### Adicionado

- O pacote `nginx` e um script de instalação para que ao acessar `http://startpage.local` ele redirecione a `http://172.0.0.1:9999` e assim minha startpage seja carregada tranquilamente. Há a possibilidade de facilmente adicionar novos serviços.
- Um arquivo [README.md](./README.md) contendo informações 
- Symlink na pasta de Documentos e Imagens para suas respectivas pastas dentro do MEGA para que sejam sincronizadas assim como o OneDrive faz no windows.
- O pacote `librewolf` como navegador padrão. Ele é uma versão mais "segura" do firefox, com configurações padrão voltado em uma maior segurança.
- Um arquivo `user.js` na pasta do chezmoi para que alguams configurações manuais sempre sejam reaplicadas. Atualmente, desabilidar a função chata do PiP dos videos.
- Os pacotes `freetube` `discord` e algumas fontes foram adicionados.
- Arquivo que o Dolphing usa para determinar a localização dos arquivos de usuários, assim como alguns bookmarks. Esses arquivo mantem os bookmarks e as pastas consistentes entre instalações.
- Adicionei o arquivo `user-dirs.locale` apenas para garantir que a linguagem seja a correta e a esperada.
- Script que configura o zsh como shell padrão.

## Consertado

- Problemas de espaçamento no arquivo template `.chezmoi.yaml.tmpl`.

### Alterado

- Iniciar e desligar um servidor python local no login e logout. Esse servidor dá host na minha startpage.
- Outras configurações do zsh foram alteradas. Alguns aliases criados mas nada de importante.
- Adicionar novas variaveis de ambiente XDG e criar o PATH manualmente no `.zshenv`.
- As configurações do vscode para que ficem atualziadas com as configuraçẽos atuais.
- Os arquivos do GNUPG agora ficam em `~/.local/share/gnupg`. Não, isso não gera problemas em relação as chaves e pode ser utilziado tranquilamente. Só se for usar um programa obscuro ou antigo que não respeite variaveis de ambiente ou XDG...
- Localização de toda a informação armazenada pelo librewolf. Agora tudo ficam em `~/.local/share/librewolf`. Realizar backup desta pasta ou de todo o share agora salva tudo do librewolf também.
- Agora estou usando o KDE, logo as configurações são pensadas no KDE.
- Agora as extensões padrão do vscode são definidas de forma declarativa pelo chezmoi, igual aos pacotes apt do sistema.
- Repositórios e arquivos que o chezmoi baixa da internet foram movidos para a pasta `.chezmoiexternals` para que seja possivel organizar cada arquivo ou repositório baixado por algum tipo de categoria.
- Localização dos arquivos de usuário. Para separar completamente o ambiente do usuário de qualquer pasta oculta ou arquivos que não podem seguir as especificações XDG, eu decidi mover todo o ambiente de usuário para `~/Arquivos`. Desta forma, meus arquivos nunca irão se misturar com nenhuma configuração e vise-versa.
- O script de instalação foi modificado para usar o bash e os comandos foram simplificados.
- Alguns scripts do chezmoi receberam pequenas mudanças.
- Script que instala pacotes agora ficou mais simples de instalar outros pacotes quando um pacote em especifico for identificado.

### Removido

- Um atalho para o nautilus que havia sido criado quando eu ainda utilziava GNOME.
- O pacote `chrome` pois não preciso desse navegador.

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