# OBJETIVO

Antes de desenharmos qualquer template .NET, quero entender com precisão **qual contexto corporativo e técnico você já possui ou consegue consultar neste ambiente**.

Nesta etapa, NÃO proponha arquitetura, NÃO crie templates, NÃO escreva código e NÃO altere arquivos.

O objetivo é exclusivamente construir um **mapa factual do contexto disponível** que poderá orientar uma etapa posterior de definição de templates .NET.

---

# PRINCÍPIO FUNDAMENTAL

Não responda com boas práticas genéricas de mercado.

Para cada informação, diferencie explicitamente:

* **POLÍTICA CORPORATIVA** — regra formal ou requisito obrigatório;
* **RESTRIÇÃO DE PLATAFORMA** — comportamento imposto por portal, esteira, infraestrutura ou tooling;
* **PADRÃO/DEFAULT DE PLATAFORMA** — configuração oferecida ou adotada por padrão, mas não necessariamente obrigatória;
* **PRÁTICA LOCAL** — convenção observada no departamento/time, sem evidência de obrigatoriedade corporativa;
* **FATO DO LEGADO** — característica observada em sistemas existentes, especialmente Boletron;
* **NÃO ENCONTRADO** — informação que você não consegue comprovar com o contexto atualmente disponível.

Não transforme prática observada em política.

Não assuma obrigatoriedade sem evidência.

---

# FONTES

Utilize somente fontes às quais você realmente tenha acesso no ambiente atual, por exemplo:

* documentação interna;
* arquivos do workspace;
* instructions;
* repositórios;
* documentação de plataforma;
* configurações;
* pipelines;
* templates corporativos;
* portais/documentos acessíveis;
* discoveries existentes;
* outros contextos corporativos disponibilizados ao Agent.

Para cada conclusão relevante, indique:

1. fonte;
2. caminho/documento/recurso, quando identificável;
3. grau de confiança:

   * ALTA
   * MÉDIA
   * BAIXA

Não exponha:

* secrets;
* tokens;
* credenciais;
* connection strings;
* informações sensíveis.

---

# 1. CRIAÇÃO E GOVERNANÇA DE REPOSITÓRIOS

Informe o que você consegue comprovar sobre o processo corporativo de criação de novos repositórios/aplicações.

Investigue especialmente:

* portal Bex;
* solicitação/criação de repositório;
* projeto Jira;
* centro de custo;
* Artifact Type;
* Deployment Type;
* linguagem;
* versão da linguagem/runtime;
* naming;
* ownership;
* permissões;
* branch inicial;
* políticas aplicadas automaticamente;
* arquivos ou configurações gerados pelo processo.

Há indicação de que novos repositórios são solicitados/criados via **Bex** e que parâmetros como Jira, centro de custo, Artifact Type, Deployment Type e Language Version fazem parte desse processo.

Valide isso pelas fontes disponíveis em vez de assumir como fato.

---

# 2. POLÍTICA .NET

Informe especificamente o que existe para .NET/.NET Core:

* versões permitidas;
* versões obrigatórias;
* versão atualmente suportada;
* política de atualização;
* SDK;
* runtime;
* imagens base;
* containers, se aplicável;
* restrições de frameworks;
* pacotes/NuGet;
* feeds corporativos;
* processo de aprovação de dependências.

Há indicação de que a política atual exige **.NET 8.0.x**.

Confirme ou refute com evidência.

IMPORTANTE:

Se não existir padrão corporativo para:

* arquitetura;
* organização de solution;
* Clean Architecture;
* DDD;
* CQRS;
* MediatR;
* repositories;
* validação;
* testes;
* Health Checks;
* observabilidade;
* tratamento de erros;
* convenções de código;

registre explicitamente:

`NÃO EXISTE PADRÃO .NET CORPORATIVO IDENTIFICADO PARA ESTE ITEM`

Não preencha a lacuna com boas práticas externas.

---

# 3. ESTEIRA / CI/CD

Mapeie o que você consegue comprovar sobre a esteira corporativa utilizada por novos serviços.

Investigue:

* geração/configuração da pipeline;
* build;
* restore;
* testes;
* quality gates;
* security scanning;
* SAST;
* SCA;
* análise de vulnerabilidades;
* artifacts;
* publicação;
* deployment;
* approvals;
* ambientes;
* promoção entre ambientes;
* rollback;
* versionamento;
* branch/tag utilizada para release;
* configuração obrigatória no repositório;
* parâmetros fornecidos pelo Bex.

Quero saber especialmente:

> O que um novo projeto .NET precisa fornecer para conseguir entrar corretamente na esteira existente?

Separe claramente:

### Responsabilidade do projeto

versus

### Responsabilidade da plataforma/esteira

---

# 4. AZURE E DEPLOYMENT

Mapeie o contexto disponível sobre integração/deployment em Azure.

Investigue, quando aplicável:

* plataforma de execução;
* AKS;
* ARO;
* App Service;
* containers;
* registries;
* subscriptions;
* resource groups;
* environments;
* configuração;
* networking;
* identidade;
* secrets;
* logging;
* monitoring;
* deployment strategy.

Não assuma que AKS, ARO ou App Service sejam obrigatórios.

Informe o que existe e em quais cenários cada opção aparece.

---

# 5. KEY VAULT, SECRETS E IDENTIDADE

Detalhe as regras que você consegue comprovar sobre:

* Azure Key Vault;
* criação/provisionamento de secrets;
* acesso da aplicação;
* Managed Identity;
* Service Principal, caso utilizado;
* rotação;
* connection strings;
* certificados;
* credenciais;
* variáveis de ambiente;
* configuração local;
* CI/CD;
* segregação por ambiente.

Quero especialmente entender:

> Que responsabilidade fica dentro do código/template .NET e que responsabilidade é fornecida pela plataforma corporativa?

Não exponha valores reais.

---

# 6. APIs E INTEGRAÇÕES CORPORATIVAS

Mapeie contexto existente para:

* API Gateway;
* Axway, caso aplicável;
* autenticação;
* autorização;
* certificados;
* APIs internas;
* exposição externa;
* service-to-service;
* padrões de integração;
* contratos;
* segurança;
* protocolos obrigatórios;
* headers/correlation IDs eventualmente impostos pela plataforma.

Não proponha um padrão novo.

Documente apenas o que consegue comprovar.

---

# 7. OBSERVABILIDADE E OPERAÇÃO

Informe o que a plataforma corporativa já fornece ou exige para:

* logs;
* métricas;
* tracing;
* correlation;
* dashboards;
* alertas;
* health checks;
* readiness;
* liveness;
* monitoramento;
* APM;
* retenção;
* troubleshooting.

Diferencie especialmente:

### capacidade fornecida pela plataforma

de:

### responsabilidade que precisa existir dentro da aplicação

Se não houver um padrão .NET definido para Health Checks, logging estruturado, OpenTelemetry ou similares, registre isso explicitamente.

---

# 8. SEGURANÇA E COMPLIANCE

Mapeie requisitos disponíveis relacionados a:

* security scanning;
* dependências;
* secrets;
* certificados;
* autenticação;
* autorização;
* segregação de ambientes;
* dados sensíveis;
* vulnerabilidades;
* approvals;
* auditoria;
* controles aplicados automaticamente pela esteira/plataforma.

Informe o que impactaria diretamente um template .NET.

---

# 9. TESTES E QUALITY GATES

Informe se existem requisitos corporativos comprováveis para:

* testes unitários;
* testes de integração;
* cobertura mínima;
* Sonar ou ferramenta equivalente;
* quality gates;
* warnings;
* análise estática;
* lint;
* build sem warnings;
* testes de segurança.

Se não houver política específica, registre `NÃO ENCONTRADO`.

---

# 10. BOLETRON / CONTEXTO DO LEGADO

Verifique qual contexto você possui ou consegue consultar sobre o **Boletron**.

Existe um discovery anterior do sistema. Caso esteja disponível no workspace ou em alguma fonte acessível, procure especialmente por:

`docs/discovery/2026-07-30-levantamento-estrutural-boletron.md`

e materiais relacionados em:

`docs/workitems/`

Não assuma que esses caminhos existam; apenas utilize-os se estiverem realmente disponíveis.

Caso tenha acesso ao discovery, resuma somente os pontos relevantes para a futura definição de templates e modernização:

* arquitetura atual;
* .NET Framework;
* WinForms;
* projetos/camadas;
* dependências;
* acesso a dados;
* SQL;
* integrações;
* acoplamento;
* testes;
* configuração;
* componentes globais;
* problemas estruturais;
* riscos;
* convenções históricas;
* pontos que uma futura arquitetura .NET deve evitar reproduzir.

Não tente redesenhar o Boletron nesta etapa.

---

# 11. MODERNIZAÇÃO E DIRECIONADORES JÁ DEFINIDOS

Informe se existe contexto corporativo ou do DAC já registrado sobre:

* modernização do Boletron;
* decomposição;
* APIs;
* microsserviços;
* front-end;
* BFF;
* Azure;
* mensageria;
* API Gateway;
* estratégia de migração;
* coexistência com legado;
* strangler pattern ou equivalente;
* padrões de integração durante a transição.

Diferencie:

* decisão formal;
* direcionamento;
* estudo;
* hipótese;
* item ainda em aberto.

---

# 12. LACUNAS DE PADRONIZAÇÃO .NET

Esta seção é especialmente importante.

Com base exclusivamente no contexto corporativo disponível, produza uma lista do que **já está determinado pela empresa/plataforma** e do que **ainda precisa ser definido por nós para .NET**.

Use a tabela:

| Capacidade | Já existe regra/padrão? | Origem | Obrigatório? | O que ainda precisa ser definido |
| ---------- | ----------------------- | ------ | ------------ | -------------------------------- |

Inclua pelo menos:

* versão .NET;
* estrutura de solution;
* arquitetura;
* DI;
* controllers;
* tratamento de erros;
* validação;
* persistência;
* EF Core;
* Dapper;
* migrations;
* health checks;
* logging;
* tracing;
* métricas;
* testes;
* coverage;
* API documentation;
* API versioning;
* autenticação;
* autorização;
* Key Vault;
* configuration;
* CI/CD;
* deployment;
* containers;
* mensageria;
* background workers;
* caching;
* resilience;
* coding conventions.

O objetivo não é preencher essas lacunas agora.

O objetivo é saber **onde termina a política corporativa existente e onde começa o trabalho de definição dos nossos templates**.

---

# FORMATO DA RESPOSTA

Quero uma resposta resumida e factual.

Comece com:

## Resumo executivo

Em no máximo 15 bullets, diga quais contextos corporativos relevantes você efetivamente possui.

Depois produza:

## Matriz de contexto disponível

| Área | O que você consegue comprovar | Classificação | Fonte | Confiança |
| ---- | ----------------------------- | ------------- | ----- | --------- |

Em `Classificação`, utilize apenas:

* POLÍTICA CORPORATIVA
* RESTRIÇÃO DE PLATAFORMA
* DEFAULT DE PLATAFORMA
* PRÁTICA LOCAL
* FATO DO LEGADO
* NÃO ENCONTRADO

Depois:

## Lacunas para definição dos templates .NET

Liste somente aquilo que aparentemente precisaremos decidir porque não existe padrão corporativo encontrado.

Depois:

## Fontes disponíveis para uma segunda análise

Liste documentos, diretórios, instructions, repositórios ou outros recursos que você considera relevantes para uma próxima etapa mais aprofundada.

Por fim:

## Perguntas que ainda precisam ser respondidas

Liste lacunas que não podem ser resolvidas com as fontes atualmente disponíveis.

---

# RESTRIÇÕES

Nesta etapa:

* NÃO crie templates;
* NÃO proponha estrutura de solution;
* NÃO escolha arquitetura;
* NÃO recomende Clean Architecture, DDD ou CQRS;
* NÃO escreva código;
* NÃO altere arquivos;
* NÃO crie documentação;
* NÃO complete lacunas com conhecimento genérico;
* NÃO trate práticas do Boletron como padrão corporativo;
* NÃO trate padrões do FinTrack como padrão corporativo;
* NÃO exponha informações sensíveis.

O resultado desta execução será utilizado para construir um segundo prompt, muito mais específico, para definição dos templates .NET.
