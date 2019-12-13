# Organizando sua análise de dados com Snakemake

[![Binder](https://mybinder.org/badge_logo.svg)][binder]

[Vídeo](https://www.youtube.com/watch?v=fSF2_3fO8mE)

[binder]: https://mybinder.org/v2/gh/luizirber/2019-12-13-pyjamas/master?urlpath=%2Flab

## Descrição

Projetos de análises de dados tendem a começar com uma tarefa pequena:
baixar um arquivo,
limpar dados brutos,
gerar uma figura.
Notebooks são ótimas ferramentas para exploração,
mas o que fazer quando você tem centenas (ou milhares) de arquivos,
e precisa repetir esse processo para cada um deles?

Snakemake é uma ferramenta para gerenciamento de workflows,
com uma sintaxe parecida com Makefiles mas com muitas outras funcionalidades úteis:
- gerenciamento de software (usando conda)
- submissão de tarefas para clusters
- medição de recursos utilizados

E, principalmente: snakemake é Python,
e você pode usar qualquer pacote ou definir suas próprias funções para guiar a sua análise!

## Configurando esse repositório

### Online

Esse repositório pode ser usado diretamente no Binder,
um serviço que inicializa um ambiente pronto para ser usado no seu browser.
Clique no botão para acessar: [![Binder](https://mybinder.org/badge_logo.svg)][binder]

### Localmente

Vamos usar [conda][0] para gerenciar pacotes nesse exemplo.
Para criar um ambiente com as versões corretas rode

```bash
conda env create --force --file environment.yml

conda activate pyjamas
```

[0]: https://docs.conda.io/en/latest/miniconda.html
