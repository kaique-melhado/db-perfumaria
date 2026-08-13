# MISSÃO

Você é um agente de engenharia de software sênior especializado em .NET, arquitetura de software, sistemas distribuídos, modernização de legados e plataformas corporativas.

Sua missão nesta etapa é **propor e justificar a futura DS/DAC .NET Engineering Baseline**, utilizando múltiplas fontes de contexto com papéis diferentes.

Esta é uma etapa de **análise e decisão arquitetural**.

NÃO implemente templates ainda.

NÃO gere código de aplicação.

NÃO crie `.sln`, `.csproj`, controllers, handlers, repositories, pipelines ou packages de template.

O objetivo é decidir primeiro **o que deve ser padronizado, por quê, em quais cenários e com qual nível de obrigatoriedade**.

---

# CONTEXTO DA INICIATIVA

O DS/DAC ainda não possui uma Engineering Baseline .NET consolidada.

Não existe hoje um padrão departamental formal que determine, para .NET:

* arquitetura;
* estrutura de solution;
* organização de projetos;
* tratamento de erros;
* validação;
* acesso a dados;
* health checks;
* observabilidade;
* testes;
* coding conventions;
* patterns;
* mensageria;
* cache;
* resiliência;
* organização de APIs;
* entre outras decisões internas da aplicação.

Portanto, esta iniciativa é **pioneira**.

O objetivo não é apenas criar três scaffolds.

O objetivo maior é avaliar a criação de uma:

> **DS/DAC .NET Engineering Baseline + Service Templates + Capability Catalog + AI Engineering Instructions**

Os templates deverão ser uma materialização executável da baseline, e não a baseline inteira.

---

# PRINCÍPIO FUNDAMENTAL

## Complexidade arquitetural deve ser proporcional à complexidade do problema.

Não considere:

* maior quantidade de projetos;
* maior quantidade de abstrações;
* maior quantidade de patterns;
* CQRS;
* MediatR;
* mensageria;
* repositories;
* Unit of Work;
* cache;
* gateway;
* microsserviços;

como indicadores automáticos de qualidade.

Toda camada, abstração, biblioteca ou pattern adicional deve responder:

> **Que problema concreto isto resolve e em quais cenários seu custo é justificado?**

Evite tanto:

* subengenharia;

quanto:

* overengineering / “matar barata com bazuca”.

---

# FONTES DE ENTRADA

Existem três fontes principais, com **papéis propositalmente diferentes**.

Leia-as integralmente antes de iniciar as decisões.

---

## FONTE A — CONTEXTO CORPORATIVO

Arquivo:

`docs/architecture/corporate-dotnet-context.md`

ou caminho equivalente disponível no workspace.

Esta é a principal fonte para responder:

> **O que a solução precisa respeitar para operar corretamente no ecossistema corporativo?**

Ela contém, entre outros:

* Bex;
* criação de repositórios;
* reusable workflows;
* CI/CD;
* Nexus;
* `packages.lock.json`;
* SonarQube;
* Fortify;
* Mend;
* Gitleaks;
* Key Vault;
* tokenização;
* IIS/WinRM;
* AKS;
* Azure;
* AWS em adoção;
* technologies disponíveis;
* deployment;
* testes;
* quality gates;
* observabilidade;
* lacunas de padrão .NET;
* questões ainda abertas.

### Regra

Quando houver conflito entre uma preferência arquitetural e uma constraint corporativa comprovada, a **constraint corporativa prevalece**.

---

## FONTE B — FINTRACK

Arquivo:

`fintrack-reference-architecture.md`

Localize-o no workspace na área de referências.

### Papel do FinTrack

FinTrack é:

> **uma reference implementation moderna parcial.**

Ele NÃO é:

* golden path;
* arquitetura ideal;
* padrão corporativo;
* especificação normativa;
* template a ser copiado 1:1.

A presença de uma prática no FinTrack **não significa que ela deva entrar na baseline**.

A ausência de uma capacidade no FinTrack **não significa que ela deva ser excluída da baseline**.

Use-o para estudar implementações e decisões como, por exemplo:

* separação de responsabilidades;
* Clean Architecture;
* SOLID;
* DI;
* CQRS/MediatR;
* EF Core;
* Repository/UoW;
* FluentValidation;
* error handling;
* testes;
* Testcontainers;
* Health Checks;
* configuração;
* Serilog;
* organização de projetos.

Questione cada uma delas.

---

## FONTE C — BOLETRON

Localize no workspace o discovery:

`2026-07-30-levantamento-estrutural-boletron.md`

Preferencialmente em seu repositório original.

### Papel do Boletron

Boletron é:

> **contexto do legado, fonte de restrições de modernização, riscos e anti-patterns observados.**

Ele NÃO é referência arquitetural para novos projetos.

O discovery apresenta características compatíveis com um **Big Ball of Mud**, incluindo sintomas como:

* boundaries permeáveis;
* UI acessando dados diretamente;
* negócio dependente de WinForms;
* grandes helpers;
* duplicação;
* estado global mutável;
* singletons;
* code-behind volumoso;
* SQL concatenado;
* ADO.NET manual;
* dependências binárias;
* configuração/secrets históricos problemáticos;
* componentes instalados na máquina;
* ausência de testes automatizados identificados;
* fragmentação histórica.

Use esses fatos para perguntar:

> **Que propriedade da nova baseline impediria ou reduziria a recorrência deste problema?**

Não replique convenções históricas apenas porque existem no legado.

---

# QUARTA FONTE — ENGENHARIA .NET MODERNA

Você pode utilizar seu conhecimento técnico de engenharia de software e .NET moderno para avaliar soluções **que não aparecem no FinTrack e que não são padrões corporativos existentes**.

Exemplos:

* `ProblemDetails`;
* OpenTelemetry;
* Polly;
* `Microsoft.Extensions.Http.Resilience`;
* Circuit Breaker;
* retry;
* timeout;
* rate limiting;
* idempotência;
* architecture tests;
* Central Package Management;
* analyzers;
* `.editorconfig`;
* structured logging;
* tracing distribuído;
* modular monolith;
* vertical slices;
* entre outros.

Porém qualquer conclusão oriunda desse conhecimento deve ser classificada como:

`ENGINEERING RECOMMENDATION`

e nunca como:

`POLÍTICA CORPORATIVA`.

Tecnologias cuja homologação corporativa não esteja comprovada devem ser marcadas como:

`REQUIRES CORPORATE VALIDATION`.

---

# HIERARQUIA DE EVIDÊNCIA

Ao decidir, respeite esta ordem:

1. **constraint/política corporativa comprovada**;
2. **restrição real observada na plataforma/esteira**;
3. **necessidade concreta do domínio/operação**;
4. **problema comprovado no legado**;
5. **evidência do FinTrack**;
6. **prática moderna de engenharia / conhecimento técnico geral**;
7. **preferência tecnológica**.

Preferência nunca deve vencer evidência.

---

# MODELO DE CLASSIFICAÇÃO DAS DECISÕES

Cada capacidade analisada deverá receber uma das seguintes classificações:

### MANDATORY

Deve existir em todos os projetos aos quais a regra seja aplicável.

### DEFAULT

Deve ser a escolha normal, mas pode ser substituída mediante justificativa técnica.

### CONDITIONAL

Obrigatória apenas quando determinada característica ou cenário existir.

### OPT-IN

Disponível como capability, mas adicionada apenas quando solicitada/necessária.

### EXCLUDED

Não deve fazer parte da baseline ou dos templates oficiais.

### REQUIRES CORPORATE VALIDATION

Tecnicamente candidata, mas depende de homologação/validação corporativa.

### OPEN DECISION

Ainda não existe informação suficiente para decidir com segurança.

---

# NÃO ACEITE PREMISSAS SEM QUESTIONAR

Há inicialmente a ideia de possuir três níveis:

* Essential;
* Standard;
* Advanced.

Isso é apenas uma **hipótese de design**.

Avalie se o melhor modelo realmente é:

### Modelo A — três templates físicos separados

ou:

### Modelo B — uma baseline comum + três profiles

ou:

### Modelo C — arquétipos + profiles + capabilities

ou outro modelo que considere superior.

Considere explicitamente:

* manutenção;
* drift entre templates;
* versionamento;
* DevEx;
* governança;
* complexidade;
* facilidade de adoção;
* capacidade de evolução;
* compatibilidade com `dotnet new`;
* capacidade de composição.

Não assuma previamente que três codebases independentes sejam a melhor solução.

---

# EIXOS DE VARIAÇÃO A SEREM ANALISADOS

As evidências corporativas sugerem que **complexidade da aplicação e tipo de artefato são dimensões diferentes**.

Analise pelo menos estes eixos.

## Eixo 1 — Arquétipo

Exemplos:

* Web API;
* Library/NuGet;
* Worker/Consumer;
* Scheduled Job;
* eventualmente BFF/Gateway, se justificável.

Considere especialmente o impacto de `ARTIFACT_TYPE` e da esteira:

* `app`;
* `lib`;
* outros cenários comprovados.

Não force todos os arquétipos a terem a mesma estrutura.

---

## Eixo 2 — Complexidade

Avalie perfis como:

* Essential;
* Standard;
* Advanced.

Defina critérios objetivos de entrada em cada perfil.

Exemplos de fatores:

* quantidade/complexidade de regras de negócio;
* integrações;
* persistência;
* transações;
* eventos;
* consistência;
* volume;
* criticidade;
* número de equipes;
* vida útil esperada;
* necessidade de evolução;
* domínio financeiro;
* requisitos operacionais.

Não defina profile pela quantidade de patterns.

---

## Eixo 3 — Capabilities

Avalie capabilities adicionáveis, por exemplo:

### Persistência

* EF Core;
* Dapper;
* MongoDB.

### Cache

* `IMemoryCache`;
* Redis;
* Azure Cache for Redis.

### Mensageria

* Kafka;
* RabbitMQ.

### Background processing

* `BackgroundService`;
* Windows Service;
* Hangfire;
* scheduler;
* mecanismos de plataforma.

### Resiliência

* timeout;
* retry;
* circuit breaker;
* rate limiting;
* bulkhead;
* fallback quando realmente apropriado.

### Observabilidade

* structured logging;
* metrics;
* tracing;
* OpenTelemetry;
* Dynatrace;
* Elastic.

### API

* OpenAPI;
* versioning;
* ProblemDetails;
* authentication;
* authorization;
* gateways;
* correlation.

A existência de uma capability não significa que ela deva entrar em todos os projetos.

---

# QUESTÕES ARQUITETURAIS OBRIGATÓRIAS

Analise e tome posição justificada sobre pelo menos:

1. arquitetura base;
2. estrutura da solution;
3. project boundaries;
4. dependency direction;
5. Controllers vs Minimal APIs;
6. organização por camada vs feature vs combinação;
7. DI;
8. tratamento de erros;
9. contrato de erro;
10. validação;
11. DTOs/contracts;
12. mapping;
13. persistência;
14. quando usar EF Core;
15. quando usar Dapper;
16. quando usar MongoDB;
17. Repository Pattern;
18. Unit of Work;
19. migrations/schema evolution;
20. transactions;
21. idempotência;
22. caching;
23. mensageria;
24. Kafka vs RabbitMQ;
25. background processing;
26. resilience;
27. API documentation;
28. API versioning;
29. authentication;
30. authorization;
31. API Gateway;
32. rate limiting;
33. structured logging;
34. correlation;
35. tracing;
36. metrics;
37. OpenTelemetry;
38. Dynatrace/Elastic compatibility;
39. Health Checks;
40. readiness/liveness;
41. configuration;
42. Key Vault integration;
43. cloud portability;
44. IIS;
45. AKS;
46. Azure;
47. AWS/hybrid cloud;
48. unit tests;
49. integration tests;
50. architecture tests;
51. framework de testes;
52. Testcontainers;
53. coverage ≥90%;
54. Sonar constraints;
55. analyzers;
56. nullable;
57. warnings-as-errors;
58. `.editorconfig`;
59. Central Package Management;
60. lock files;
61. security defaults;
62. secrets;
63. dependency governance;
64. Clean Code;
65. SOLID;
66. Design Patterns;
67. code smells;
68. anti-patterns;
69. refactoring;
70. AI coding-agent instructions;
71. financial-domain engineering.

---

# DOMÍNIO FINANCEIRO

Considere explicitamente se a Engineering Baseline para Tesouraria/DAC deve definir princípios transversais relacionados a sistemas financeiros.

Avalie itens como:

* precisão monetária;
* uso de `decimal` vs floating point;
* moeda explícita;
* rounding explícito;
* datas financeiras;
* timezone;
* business day;
* idempotência;
* auditabilidade;
* reconciliação;
* rastreabilidade;
* ordenação de eventos;
* duplicidade;
* invariantes;
* consistência;
* concorrência;
* retries seguros;
* integridade;
* tratamento de falhas;
* operações irreversíveis;
* observabilidade de operações críticas.

Não transforme todos em regra sem justificativa.

---

# TESTES E QUALITY GATE

O contexto corporativo mostrou um Quality Gate particularmente exigente.

Considere corretamente a distinção entre:

### New Code

* Coverage >= 90%;
* Duplicated Lines <= 3%;
* Maintainability A;
* Reliability A;
* Security Hotspots Reviewed 100%;
* Security A.

### Overall Code

* Coverage >= 90%;
* Maintainability A;
* Reliability A;
* Security Hotspots Reviewed 100%;
* Security A.

Não assuma a condição de duplicação de 3% para Overall Code se ela não estiver comprovada.

Considere ainda que a esteira coleta cobertura usando mecanismo corporativo próprio.

Portanto:

> não adicione ferramenta de coverage ao template apenas por hábito sem demonstrar necessidade.

A baseline deve tornar **90% de cobertura sustentável**, não estimular testes artificiais apenas para atingir métrica.

---

# OBSERVABILIDADE

FinTrack utilizar Serilog não deve determinar automaticamente o padrão.

O contexto corporativo indica forte presença de:

* Dynatrace;
* Elastic.

Analise uma estratégia baseada preferencialmente em **abstrações e padrões interoperáveis**, evitando acoplamento indevido do domínio a ferramentas específicas.

Avalie:

* `ILogger<T>`;
* structured logging;
* `Activity`;
* OpenTelemetry;
* correlation;
* metrics;
* tracing;
* exporters/instrumentação;
* Dynatrace;
* Elastic.

Diferencie:

### API/abstração dentro da aplicação

de:

### coleta/exportação/operação realizada pela plataforma.

---

# API GATEWAY

APIM e Axway existem no ambiente e não são obrigatórios para toda API.

Não presuma que um serviço deva hospedar seu próprio gateway.

Avalie se:

* gateway é responsabilidade externa da plataforma;
* existe cenário para BFF;
* existe cenário para API aggregation;
* Ocelot/Kong fariam sentido;
* ou se introduzi-los criaria infraestrutura redundante.

Qualquer tecnologia não comprovadamente homologada deve receber `REQUIRES CORPORATE VALIDATION`.

---

# MENSAGERIA

Kafka é relatado como predominante no ambiente corporativo.

RabbitMQ possui boa afinidade com .NET, mas isso isoladamente não é justificativa para torná-lo padrão.

Avalie levando em conta:

* operação;
* governança;
* observabilidade;
* skill interno;
* ordering;
* replay;
* throughput;
* consumer groups;
* simplicity;
* transactional boundaries;
* developer experience.

Não transforme preferência individual em padrão.

---

# RESILIÊNCIA

Avalie explicitamente:

* `Microsoft.Extensions.Http.Resilience`;
* Polly;
* timeout;
* retry;
* circuit breaker;
* rate limiting;
* retry storms;
* jitter;
* idempotência.

Diferencie:

* políticas que deveriam ser baseline para chamadas remotas;

de:

* políticas que devem ser configuradas apenas conforme downstream.

---

# ANTI-PATTERNS TRANSVERSAIS

Derive princípios preventivos a partir dos problemas observados no legado.

Avalie se a baseline deve proibir ou desencorajar explicitamente:

* Presentation → Database direto;
* Business/Application → UI framework;
* mutable global state;
* service locator;
* giant static helpers;
* God Classes;
* SQL concatenado;
* environment switching via source code;
* secrets hardcoded;
* credenciais “criptografadas” com chave no próprio código;
* binários manuais no repositório;
* dependências instaladas implicitamente na máquina;
* exceptions silenciosamente engolidas;
* catch-all sem tratamento;
* abstrações sem propósito;
* interfaces criadas apenas por ritual;
* indiscriminate repository pattern;
* indiscriminate CQRS;
* overengineering.

---

# AI ENGINEERING INSTRUCTIONS

Avalie a criação futura de instructions reutilizáveis para agentes de desenvolvimento.

Considere módulos como:

* Clean Code;
* SOLID;
* Design Patterns;
* Architecture;
* Testing;
* APIs;
* Persistence;
* Security;
* Observability;
* Refactoring;
* Code Smells;
* Anti-patterns;
* Critical Engineering Thinking;
* Financial Domain Engineering.

Defina nesta etapa apenas:

* objetivo;
* escopo;
* separação recomendada;
* princípios que cada instruction deveria conter.

NÃO crie ainda os arquivos finais de instructions.

---

# ENTREGÁVEL

Crie exclusivamente:

`docs/architecture/dotnet-engineering-baseline-decision-dossier.md`

Se estiver sendo utilizada uma pasta/repositório neutro para arquitetura, utilize o caminho equivalente de `outputs/`.

---

# ESTRUTURA DO DOCUMENTO

## 1. Executive Summary

Apresente:

* principais conclusões;
* modelo recomendado para templates/profiles;
* decisões de maior impacto;
* principais diferenças em relação ao FinTrack;
* principais riscos evitados a partir do Boletron.

---

## 2. Sources and Decision Method

Explique o papel de:

* Corporate Context;
* FinTrack;
* Boletron;
* Modern .NET Engineering.

Registre a hierarquia de evidência.

---

## 3. Corporate Constraints

Liste somente o que a arquitetura precisa respeitar e que não está sob decisão do template.

---

## 4. Engineering Principles

Defina os princípios da futura baseline.

---

## 5. Recommended Template Model

Compare explicitamente:

* três templates físicos;
* profiles;
* arquétipos + profiles + capabilities;
* outras alternativas relevantes.

Faça uma recomendação justificada.

---

## 6. Archetypes

Avalie pelo menos:

* API;
* Library;
* Worker;
* Scheduled Job.

Inclua outros apenas se houver justificativa.

---

## 7. Complexity Profiles

Defina:

* Essential;
* Standard;
* Advanced;

ou proponha nomenclatura melhor.

Para cada perfil forneça critérios de entrada objetivos.

---

## 8. Capability Catalog

Para cada capability informe:

| Capability | Problema resolvido | Corporate evidence | Essential | Standard | Advanced | Classificação | Trade-offs |
| ---------- | ------------------ | ------------------ | --------- | -------- | -------- | ------------- | ---------- |

---

## 9. Architecture Decision Matrix

Para cada decisão:

| Decisão | Corporate Constraint | FinTrack | Boletron Evidence | Modern Engineering | Decisão proposta | Classificação | Justificativa |
| ------- | -------------------- | -------- | ----------------- | ------------------ | ---------------- | ------------- | ------------- |

---

## 10. Baseline Mandatory Across Profiles

Defina aquilo que deve existir transversalmente independentemente do nível de complexidade.

Evite inflar esta lista.

---

## 11. API Engineering

Inclua:

* API style;
* contracts;
* validation;
* errors;
* versioning;
* documentation;
* security;
* gateway;
* rate limiting.

---

## 12. Persistence and Data

Inclua:

* EF Core;
* Dapper;
* MongoDB;
* Repository;
* UoW;
* transactions;
* migrations;
* query patterns.

---

## 13. Distributed Systems Capabilities

Inclua:

* messaging;
* Kafka;
* RabbitMQ;
* cache;
* Redis;
* resilience;
* idempotency;
* background processing;
* service discovery.

---

## 14. Observability and Operations

Inclua:

* logging;
* metrics;
* tracing;
* OpenTelemetry;
* Dynatrace;
* Elastic;
* Health Checks;
* readiness/liveness.

---

## 15. Testing Strategy

Inclua:

* unit;
* integration;
* architecture;
* Testcontainers;
* framework evaluation;
* coverage;
* Sonar implications.

---

## 16. Code Quality and Governance

Inclua:

* analyzers;
* nullable;
* warnings;
* `.editorconfig`;
* dependency governance;
* package management;
* lock files;
* code conventions.

---

## 17. Financial Domain Engineering

Defina quais preocupações deveriam ser transversais e quais são contextuais.

---

## 18. Anti-pattern Prevention

Relacione problema observado → princípio preventivo.

---

## 19. AI Engineering Instructions Strategy

Defina a estrutura conceitual das futuras instructions.

---

## 20. Deployment and Portability

Considere:

* IIS hoje;
* AKS disponível;
* Azure predominante;
* AWS emergente;
* evitar acoplamento desnecessário à plataforma.

---

## 21. Decisions Requiring Corporate Validation

Liste tecnologias ou decisões tecnicamente recomendáveis que ainda dependem de homologação ou confirmação.

---

## 22. Open Decisions

Liste aquilo que continua sem informação suficiente.

---

## 23. Proposed Roadmap

Proponha a sequência das próximas etapas, por exemplo:

1. validar decision dossier;
2. produzir ADRs;
3. definir template specification;
4. implementar template engine;
5. implementar profiles;
6. implementar capabilities;
7. criar AI instructions;
8. criar reference/sample services;
9. validar contra CI/CD corporativo;
10. documentação e adoção.

Não execute essas etapas agora.

---

# AUTO-AUDITORIA OBRIGATÓRIA

Antes de finalizar, faça uma auditoria interna do documento.

Verifique:

* todas as fontes foram lidas integralmente;
* FinTrack não foi tratado como golden path;
* Boletron não foi tratado como referência arquitetural;
* nenhuma tecnologia disponível virou obrigatória sem justificativa;
* nenhuma preferência individual virou padrão;
* constraints corporativas foram preservadas;
* New Code e Overall Code do Sonar não foram confundidos;
* decisões possuem trade-offs;
* Essential não virou um “Standard menor” artificial;
* Advanced não virou “todas as tecnologias ligadas”;
* nenhum pattern foi introduzido sem problema concreto;
* IIS não foi tratado como teto futuro;
* AKS não foi tratado como obrigatório;
* Azure e AWS não vazam desnecessariamente para Core/Application;
* candidates sem homologação estão marcados adequadamente;
* não foi gerado código.

Corrija qualquer inconsistência antes de considerar a tarefa concluída.

---

# ALTERAÇÃO PERMITIDA

A única alteração permitida nesta execução é criar:

`docs/architecture/dotnet-engineering-baseline-decision-dossier.md`

Nenhum outro arquivo deverá ser criado ou modificado.

---

# RESPOSTA FINAL

Depois de concluir o documento, responda apenas com:

1. caminho do artefato;
2. quantidade aproximada de linhas;
3. fontes efetivamente lidas;
4. modelo de templates/profiles recomendado;
5. quantidade de decisões por classificação:

   * MANDATORY;
   * DEFAULT;
   * CONDITIONAL;
   * OPT-IN;
   * EXCLUDED;
   * REQUIRES CORPORATE VALIDATION;
   * OPEN DECISION;
6. principais decisões que exigem validação humana;
7. confirmação de que nenhum código/template foi implementado nesta etapa.
