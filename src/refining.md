Até aqui definimos bem:

O QUE queremos gerar
        ↓
Archetype × Profile × Capability

mas ainda não:

COMO a plataforma de templates materializa isso

E isso muda completamente o custo real da solução.

Eu separaria explicitamente:

Software Architecture — arquitetura dos projetos gerados.

de:

Template Platform Architecture — arquitetura da ferramenta que gera esses projetos.

As alternativas que eu levaria para decisão seriam:
| Modelo                      | Como funciona                                | Vantagem                            | Principal risco                             |
| --------------------------- | -------------------------------------------- | ----------------------------------- | ------------------------------------------- |
| Templates físicos separados | `dac-api-essential`, `dac-api-standard` etc. | Simples de entender                 | Drift + explosão combinatória               |
| `dotnet new` parametrizado  | Archetype + `--profile` + capabilities       | Ferramenta nativa, baixa barreira   | Condicionais podem virar um template enorme |
| Scaffolder próprio          | CLI monta componentes                        | Composição e validação muito fortes | Passamos a manter uma plataforma própria    |
| **Híbrido**                 | Template Engine + composição controlada      | Equilíbrio                          | Exige desenho cuidadoso                     |

Minha recomendação inicial: híbrido sobre o Template Engine

Eu começaria tentando algo conceitualmente assim:
DS/DAC Templates Package
│
├── dac-api
│   ├── profile: essential | standard | advanced
│   └── capabilities...
│
├── dac-worker
│   └── ...
│
├── dac-library
│   └── ...
│
└── dac-job
    └── ...

Exemplo futuro:
dotnet new dac-api \
  --profile standard \
  --persistence dapper

ou:
dotnet new dac-worker \
  --profile advanced \
  --messaging kafka

Mas com uma regra importante:

não transformar dotnet new em um motor de feature flags com 40 parâmetros.

Capabilities de alta frequência e baixa complexidade podem ser parâmetros. Composições muito sofisticadas talvez mereçam outro mecanismo futuramente.

Eu não criaria um scaffolder próprio agora. Primeiro tentaria provar que o Template Engine atende 80–90% do problema. Só assumiria o custo de uma CLI proprietária se um POC demonstrasse limitação real.


Minha proposta anterior dizia aproximadamente:

Essential
→ 1 production assembly
→ boundaries conceituais
→ architecture tests excluídos

Existe uma tensão aí.

Se dizemos:

Controller → banco é proibido

mas nada verifica isso, então na prática temos:

Controller → banco é proibido se alguém perceber no PR.

E o aprendizado do legado mostra justamente que boundaries baseados apenas em disciplina tendem a sofrer erosão ao longo dos anos.

Eu mudaria a classificação.

Essential revisado

Não colocaria uma suite completa de Architecture Tests, mas colocaria:

Lightweight Architecture Guardrails — MANDATORY

A implementação ainda precisa ser escolhida.
