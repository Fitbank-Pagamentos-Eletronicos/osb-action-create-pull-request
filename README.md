# osb-action-create-pull-request
Repositório destinado à Action de criação de Pull Requests nos WhiteLabels OSB

## Exemplo de uso:
    name: Create Pull Requests in WhiteLabels OSB

    on:
      push:
        branches:
          - 'main'
        paths-ignore:
          - '.github/**'
          - '/**/*.png'

    jobs:
      pull-request:
        runs-on: ubuntu-latest
        steps:
          - name: Checkout
            uses: actions/checkout@v3
            with:
              fetch-depth: 0

          - name: Create pull request on WhiteLabel X
            uses: Fitbank-Pagamentos-Eletronicos/osb-action-create-pull-request@main
            env:
              API_TOKEN_GITHUB: ${{ secrets.API_TOKEN_GITHUB }}
            with:
              whiteLabel_source_folder: '*'
              whiteLabel_repo: 'Fitbank-Pagamentos-Eletronicos/whitelabel-generoso'
              whiteLabel_head_branch: 'features'
              user_email_fitbank: 'user-email@fitbank.com.br'
              user_name_fitbank: 'user-name'


## Variáveis
* whiteLabel_source_folder: A pasta a ser movida.
* whiteLabel_repo: O repositório no qual colocar o arquivo ou diretório.
* whitelabel_folder: [opcional] A pasta no repositório de destino para colocar o arquivo, se não for o diretório raiz.
* user_email_fitbank: Email do github associado ao API token secret.
* user_name_fitbank: Nome do usuário github associado ao API token secret.
* whitelabel_base_branch: [Opcional] A ramificação na qual você deseja que seu código seja mesclado. A padrão é 'main'.
* whitelabel_head_branch: A ramificação a ser criada para enviar as alterações. Não pode ser a 'main'.

## ENV
* API_TOKEN_GITHUB: Você deve criar um token de acesso pessoal em sua conta. Saiba mais clicando no link abaixo:
- [Personal access token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token)

## Notas
- A ação criará quaisquer caminhos de destino se eles não existirem;
- Ela também substituirá os arquivos existentes se eles já existirem nos locais para os quais está sendo copiado;
- Não excluirá todo o repositório de destino.
