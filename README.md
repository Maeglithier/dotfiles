# Arquivos com ponto

I use Debian btw.

## Introdução

Seja muito bem vindo ao meu arquivos com ponto. Neste repositório você vai encontrar todos os arquivos ocultos e alguns não ocultos que configuram toda a minha área de trabalho e o meu computador. Sinta-se livre para analisar minhas configurações e incorporar ao seu próprio repositório se você quiser, eu não me importo. Aceito sugestões para otimizar ou melhorar meu ambiente, mas não venha querer controlar o que eu fiz ou deixei de fazer.

Aliás, eu uso o Debian.

## Chezmoi

Eu uso o chezmoi pela facilidade que ele proporciona em manter, atualizar e instalar as configurações com o auxilio de scripts adicionais. O chezmoi foi feito pensando em ser utilizado em multiplas máquinas e com sistemas operacionais diferentes, porém como eu só tenho um computador, eu não estou fazendo uso dessas funcionalidades. 

## Requisitos

- Seu usuário deve estar no grupo sudo. Execute o comando abaixo e insira a senha do super usuário para adicionar seu usuário ao grupo sudo. Depois, encerre sua sessão ou reinicie seu computador para as mudanças entrarem em vigor.

``` bash
su -c 'usermod -aG sudo SEU_USUÁRIO_AQUI'
```

- É necessário que o pacote Nala esteja instalado. Nala é uma interface do apt que é mais bonito, organizado e veloz. Para isso, execute o comando abaixo após ter conseguido o super usuário para instalar o Nala e atualizar seu sistema. Opcionalmente utilize o comando `sudo nala fetch` e selecione os três primeiros repositórios mais rápidos para garantir maior velocidade de download ao instalar pacotes, reutilize o comando periodicamente se necessário (Eu uso Debian, quase não tem atualziação...).

``` bash
sudo apt update && sudo apt upgrage -y && sudo apt install nala -y
```

- É preciso que o curl ou o wget esteja instalado. Dificil esses pacotes não estarem instalado no seu sistema, porém para garantir que o curl esteja instalado execute o comando abaixo.

``` bash
sudo nala install curl
```

Não faltando nenhum requisito, tudo o que resta é instalar as configurações usando o chezmoi. Você pode usar o wget se prefirir, porém o curl funciona bem por padrão.

``` bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply maeglithier
```

Após instalar todas as configurações e programas com o comando acima, não esqueça de reiniciar o computador para que todas as mudanças entrem em vigor. Principalmente pelo fato de que o zsh é instalado e usado como shell padrão e a mudança junto com todas as configurações feitas nele só é aplicada 100% após reiniciar o computador. Além do mais as configurações do zsh são importantes para que todo o ambiente shell e suas varaiveis de ambiente funcionem corretamente. Se não quiser esbarrar em nenhum erro, apenas reinicie o computador para que todas as modificações entrem em vigor, assim como deveria ocorrer.

## Após a Instalação

Após realizar a instalação de todas essas configurações e aplicativos, ainda há coisas a ser feitas, porém são opcionais.

- Usar o LibreWolf como navegador padrão. É um navegador privado e seguro que me ganhou com seu pequeno charme. Já vem configurado e pronto para usar.
    - Use o ublock no modo dificil ou médio. Para isso, ative tudo que é lista de filtro, ative o modo avançado e bloqueie tudo que é 3rd-party. Pesquisa ai como ativar esse modo dificil ou médio.
    - Use o keepass como gerenciador de senha, ou outro de preferência. Um gerenciador de senhas é uma boa forma de manter suas contas seguras com senhas diferentes. Nunca use o gerenciador de senhas do navegador, pois ele não é nem um pouco seguro e você pode perder facilmente as senahs.
- Se você usou o firefox para acessar essa página, já pode apagar a pasta `~/.mozilla` pois esse navegador não será mais utilizado (Ou vai... não sei). Eu pessoalmente uso os dois pois as vezes preciso de um browser com configurações padrão, mas o librewolf é meu padrão.