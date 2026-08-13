# OBJETIVO

Com base no levantamento corporativo realizado nesta sessão, crie um documento consolidado de contexto para servir como **fonte de entrada para uma etapa posterior de definição da Engineering Baseline e dos templates .NET do DS/DAC**.

Crie exclusivamente o arquivo:

`docs/architecture/corporate-dotnet-context.md`

Nesta etapa:

* NÃO desenhe os templates;
* NÃO proponha arquitetura;
* NÃO defina Clean Architecture, DDD, CQRS, MediatR ou qualquer outro padrão como obrigatório;
* NÃO escreva código;
* NÃO altere nenhum outro arquivo;
* NÃO tente preencher lacunas com boas práticas genéricas;
* NÃO trate o FinTrack como padrão corporativo;
* NÃO trate o Boletron como referência arquitetural a ser replicada.

O objetivo é **persistir e normalizar o contexto corporativo já conhecido**, separando fatos, restrições, práticas observadas, informações fornecidas pelo responsável pela iniciativa e lacunas ainda existentes.

---

# PAPEL DO DOCUMENTO

O arquivo `corporate-dotnet-context.md` deverá responder:

> **“Quais constraints, capacidades de plataforma, tecnologias disponíveis, políticas, práticas e lacunas corporativas precisam ser consideradas antes de definirmos um padrão arquitetural .NET para o DS/DAC?”**

Ele será posteriormente utilizado em conjunto com outras fontes, como:

* uma reference implementation .NET moderna;
* o discovery do Boletron;
* capacidades modernas do ecossistema .NET;
* contexto adicional do ambiente corporativo.

Portanto, este documento **não deve tomar as decisões arquiteturais finais**.

---

# FONTES

Utilize prioritariamente as fontes já inspecionadas durante o discovery desta sessão, incluindo, quando disponíveis:

* `shared-docs/`;
* documentação corporativa exportada do Confluence;
* workflows existentes;
* `config/`;
* `global.json`;
* `app-project-path`;
* `CODEOWNERS`;
* READMEs;
* `POC-GITHUB-DOTNET.md`;
* documentação de Key Vault;
* `Variáveis+DotNet+Core.txt`;
* `Workflow+para+Aplicações+.NET+Core.txt`;
* `Guia+para+Desenvolvedores+...Net+Core.txt`;
* exemplos reais de repositórios .NET acessíveis no workspace;
* discovery estrutural do Boletron, apenas quando relevante como contexto do legado.

Não exponha valores de:

* secrets;
* tokens;
* credentials;
* connection strings;
* informações sensíveis.

---

# CLASSIFICAÇÃO DAS INFORMAÇÕES

Para cada conclusão relevante, utilize uma das seguintes classificações:

### POLÍTICA CORPORATIVA

Regra formal comprovada por documentação ou processo corporativo.

### RESTRIÇÃO DE PLATAFORMA

Comportamento imposto pelo Bex, pipeline, reusable workflow, tooling, infraestrutura ou processo operacional.

### DEFAULT DE PLATAFORMA

Comportamento/configuração fornecido por padrão, mas sem evidência de obrigatoriedade universal.

### TECNOLOGIA CORPORATIVA DISPONÍVEL

Tecnologia comprovadamente utilizada ou disponível dentro do ecossistema corporativo, mas não necessariamente obrigatória.

### PRÁTICA LOCAL

Prática observada em um ou mais projetos/times sem evidência de que seja política corporativa.

### CONTEXTO DO LEGADO

Informação proveniente do Boletron ou outros legados que seja útil para orientar futuras decisões, mas que não represente padrão corporativo.

### INFORMAÇÃO DO RESPONSÁVEL PELA INICIATIVA

Informação fornecida explicitamente pelo responsável por esta iniciativa, porém não necessariamente comprovada nas fontes que você consegue acessar.

### NÃO ENCONTRADO

Informação que não pôde ser comprovada.

---

# GRAU DE CONFIANÇA

Quando aplicável, atribua:

* `ALTA`
* `MÉDIA`
* `BAIXA`

Informações classificadas como `INFORMAÇÃO DO RESPONSÁVEL PELA INICIATIVA` podem ter confiança alta quanto ao relato fornecido, mas isso **não as transforma automaticamente em política corporativa formal**.

---

# 1. CRIAÇÃO E GOVERNANÇA DE REPOSITÓRIOS

Documente o que foi comprovado sobre:

* Bex;
* fluxo de solicitação de repositório;
* GitHub;
* criação de repository/pipeline;
* Jira / VS KEY;
* centro de custo;
* Artifact Type;
* Deployment Type;
* deployment target;
* tecnologia;
* versão;
* arquitetura selecionada no wizard;
* naming;
* ownership;
* CODEOWNERS;
* branch inicial;
* arquivos gerados;
* self-update do repositório;
* automações Terraform;
* restrições de alteração de variáveis/secrets.

Deixe claro:

### O que é responsabilidade do Bex/plataforma

versus

### O que deverá ser fornecido pelo projeto/template

---

# 2. POLÍTICA E RUNTIME .NET

Registre:

* `LANGUAGE_VERSION`;
* versões suportadas pela esteira;
* versão documentada/recomendada;
* `global.json`;
* SDK pinning;
* builder;
* feed NuGet;
* Nexus;
* lock file;
* `packages.lock.json`;
* `app-project-path`;
* processo de restore/build.

Considere a seguinte clarificação fornecida pelo responsável pela iniciativa:

> **8.0.x é atualmente a versão vigente/recomendada pela documentação oficial. O Bex disponibiliza outras versões, inclusive .NET 10. Portanto, 8.0.x não deve ser apresentado como uma limitação arquitetural permanente ou como única versão disponível.**

Registre essa nuance explicitamente.

Sobre `packages.lock.json`:

> Houve falha real de execução da esteira na ausência do arquivo. Na falta de documentação adicional que prove o contrário, tratá-lo como **constraint operacional observada**, sinalizando que a obrigatoriedade formal ainda pode precisar de confirmação documental.

---

# 3. ESTEIRA / CI/CD

Documente:

* reusable workflows;
* impossibilidade de edição pelo time;
* callers;
* branches;
* PR checks;
* release;
* sandbox;
* rollback;
* self-update;
* runners;
* build;
* `dotnet test`;
* artifacts;
* Nexus;
* deployment;
* change velocity;
* approvals;
* responsabilidade da plataforma;
* responsabilidade do projeto.

Inclua explicitamente os gates corporativos identificados:

### SonarQube

O Quality Gate informado pelo responsável pela iniciativa é:

* Coverage **não pode ser menor que 90%**;
* Duplicated Lines (%) **não pode ser maior que 3%**;
* Maintainability Rating deve ser **A**

  * Technical Debt Ratio < 5%;
* Reliability Rating deve ser **A**

  * sem bugs;
* Security Hotspots Reviewed deve ser **100%**;
* Security Rating deve ser **A**

  * sem vulnerabilities.

### Demais gates

Documente também, conforme evidência existente:

* Fortify;
* Mend;
* Gitleaks;
* testes;
* aprovação de PR.

Diferencie:

`GATE CORPORATIVO`

de:

`DECISÃO QUE AINDA PRECISAMOS TOMAR NO TEMPLATE`.

---

# 4. DEPLOYMENT, AZURE E CLOUD

Documente separadamente:

### Deployment comprovado nesta esteira

* Windows Server;
* IIS;
* WinRM;
* hosts/paths por ambiente;
* deployment strategy;
* rollback.

### Azure

Documente o que foi comprovado sobre:

* Azure Login;
* Key Vault;
* secrets;
* integração durante deployment.

### AKS

Clarificação fornecida pelo responsável pela iniciativa:

> **AKS é um caminho corporativo disponível, porém não obrigatório para todos os projetos .NET.**

Portanto:

* não trate IIS como único destino futuro;
* não trate AKS como deployment target obrigatório;
* registre ambos como cenários que a futura arquitetura poderá precisar suportar.

### AWS

Clarificação fornecida pelo responsável pela iniciativa:

> **AWS está começando a ser adotada no banco como parte de uma estratégia de cloud híbrida. Azure permanece atualmente como cloud principal e mais madura no ambiente.**

Classifique AWS como:

`TECNOLOGIA/CLOUD CORPORATIVA EM ADOÇÃO`

e não como padrão obrigatório.

---

# 5. KEY VAULT, SECRETS E IDENTIDADE

Documente:

* RITM;
* Track/ServiceNow;
* DITI — Acessos Cloud;
* aprovação;
* Service Principal;
* Key Vault por ambiente;
* tokenização;
* substituição durante deploy;
* arquivos de configuração;
* responsabilidade da aplicação;
* responsabilidade da plataforma;
* configuração local;
* rotação, caso exista evidência.

Deixe clara a divisão:

### Aplicação/template

Deve expor/configurar corretamente as chaves e placeholders necessários.

### Plataforma/esteira

Autentica, acessa Key Vault e resolve/substitui secrets no processo de deployment.

Não assuma Managed Identity se não houver evidência.

---

# 6. TECNOLOGIAS E CAPACIDADES CORPORATIVAS DISPONÍVEIS

Crie uma seção específica para tecnologias conhecidas no ecossistema corporativo, separando:

* comprovadamente utilizadas;
* disponíveis;
* predominantes;
* opcionais;
* sem comprovação suficiente.

Inclua as seguintes informações fornecidas pelo responsável pela iniciativa:

### API Gateway

* APIM é utilizado em projetos do banco;
* Axway é utilizado em projetos do banco;
* seu uso NÃO é obrigatório para todas as APIs.

Não defina ainda quando utilizar cada um.

### Cache

São utilizadas no ambiente:

* Redis;
* Azure Cache for Redis.

Não determine ainda se cache deverá fazer parte de algum template.

### Banco NoSQL

MongoDB faz parte das stacks utilizadas no banco.

Não o transforme em banco padrão.

### Mensageria

Kafka é amplamente utilizado/predominante no ambiente corporativo.

RabbitMQ é tecnicamente conhecido e comum no ecossistema .NET, mas **não deve ser tratado como padrão corporativo apenas por sua simplicidade ou afinidade com .NET**.

### Observabilidade

Dynatrace possui forte presença no banco.

Elastic também é utilizado.

Ainda não existe confiança suficiente para afirmar quais requisitos específicos de instrumentação precisam existir dentro da aplicação .NET.

Classifique essa informação adequadamente.

---

# 7. APIs, AUTENTICAÇÃO E INTEGRAÇÃO

Documente o que existe para:

* API Gateway;
* APIM;
* Axway;
* autenticação;
* autorização;
* JWT;
* headers;
* correlation IDs;
* contratos;
* versionamento;
* integrações com mainframe;
* APIs internas.

Clarificação fornecida pelo responsável:

> JWT é utilizado em projetos do banco, porém não há evidência suficiente para tratá-lo como o único mecanismo ou como padrão corporativo universal.

Portanto classifique como:

`TECNOLOGIA/PRÁTICA CORPORATIVA UTILIZADA`

e não:

`POLÍTICA CORPORATIVA OBRIGATÓRIA`.

---

# 8. OBSERVABILIDADE

Documente o que é conhecido sobre:

* Dynatrace;
* Elastic;
* logs;
* tracing;
* métricas;
* dashboards;
* health checks;
* readiness;
* liveness;
* OpenTelemetry;
* correlation IDs.

Clarificação fornecida:

> Há percepção de que a aplicação pode definir parte da estratégia de instrumentação, porém essa conclusão possui confiança MÉDIA-BAIXA e deve permanecer como questão aberta.

Não preencha a lacuna com uma arquitetura proposta.

---

# 9. TESTES E QUALITY GATES

Separe claramente:

### O que a esteira exige

* execução de testes quando habilitada;
* Quality Gate do Sonar;
* gates de segurança/qualidade.

### O que NÃO possui padrão .NET identificado

Por exemplo:

* framework de testes;
* organização dos testes;
* testes unitários vs integração;
* Testcontainers;
* arquitetura de fixtures;
* naming;
* mocks;
* coverage tooling;
* architecture tests.

A meta de coverage do Sonar deve ser tratada como constraint corporativa, mas **não deve ser usada nesta etapa para escolher framework ou estratégia de testes**.

---

# 10. CONTEXTO DO BOLETRON

Inclua somente um resumo do contexto relevante do legado, sem duplicar todo o discovery.

Registre que o discovery aponta características compatíveis com um **Big Ball of Mud**, como:

* boundaries permeáveis;
* UI acessando camada de dados;
* lógica de negócio acoplada a WinForms;
* grandes helpers;
* duplicação;
* estado global mutável;
* singletons;
* code-behind volumoso;
* ADO.NET manual;
* stored procedures;
* configuração fortemente acoplada;
* secrets/configuração histórica problemática;
* DLLs e dependências manuais;
* ausência de testes automatizados identificados;
* dependência de componentes instalados na máquina;
* fragmentação histórica de projetos.

IMPORTANTE:

O Boletron deve ser tratado como:

`CONTEXTO DO LEGADO / FONTE DE ANTI-PATTERNS E RISCOS`

e não como referência arquitetural para os novos templates.

Registre também que a estratégia formal de modernização ainda está amadurecendo.

---

# 11. MODERNIZAÇÃO E CLOUD HÍBRIDA

Registre:

* processo de modernização em andamento/amadurencendo;
* migração de aplicações .NET Framework para .NET moderno;
* Bex como parte do processo;
* AKS como opção corporativa;
* Azure como cloud predominante;
* AWS em adoção crescente;
* coexistência com IIS/on-premises.

Não proponha estratégia de decomposição, strangler, microsserviços ou BFF nesta etapa.

---

# 12. O QUE JÁ ESTÁ DEFINIDO VS. O QUE PRECISA SER DEFINIDO POR NÓS

Esta é uma das seções mais importantes.

Produza:

| Capacidade | Situação atual | Classificação | Obrigatório hoje? | Ainda precisa de decisão arquitetural nossa? |
| ---------- | -------------- | ------------- | ----------------- | -------------------------------------------- |

Inclua no mínimo:

* criação do repositório;
* .NET version;
* Nexus;
* `packages.lock.json`;
* CI/CD;
* Sonar;
* Fortify;
* Mend;
* Gitleaks;
* Key Vault;
* configuration/tokenização;
* deployment IIS;
* AKS;
* Azure;
* AWS;
* solution structure;
* arquitetura;
* DI;
* API style;
* error handling;
* validation;
* persistence;
* EF Core;
* Dapper;
* MongoDB;
* migrations;
* cache;
* Redis;
* messaging;
* Kafka;
* RabbitMQ;
* workers;
* health checks;
* logging;
* Dynatrace;
* Elastic;
* tracing;
* metrics;
* resilience;
* API Gateway;
* APIM;
* Axway;
* authentication;
* authorization;
* API documentation;
* API versioning;
* testing conventions;
* coding conventions;
* analyzers;
* nullable;
* warnings-as-errors.

Esta tabela deverá deixar extremamente clara a fronteira entre:

> **plataforma corporativa existente**

e:

> **Engineering Baseline que ainda precisaremos definir.**

---

# 13. TECNOLOGIAS CANDIDATAS AINDA NÃO VALIDADAS CORPORATIVAMENTE

Crie uma seção separada para tecnologias ou abordagens que poderão ser avaliadas futuramente, mas que **não devem ser confundidas com padrão corporativo existente**.

Inclua, quando aplicável:

* Polly;
* `Microsoft.Extensions.Http.Resilience`;
* Circuit Breaker;
* retry/timeout policies;
* Hangfire;
* Consul;
* Ocelot;
* Kong;
* OpenTelemetry;
* outras capacidades modernas que tenham surgido no contexto da iniciativa.

Classifique-as como:

`ENGINEERING CANDIDATE — REQUIRES EVALUATION`

ou:

`REQUIRES CORPORATE VALIDATION`

Não recomende adoção nesta etapa.

---

# 14. LACUNAS PARA A FUTURA .NET ENGINEERING BASELINE

Liste objetivamente tudo que ainda precisará ser decidido por nós.

Inclua, no mínimo:

1. arquitetura e organização da solution;
2. quantidade/perfis de templates;
3. tratamento de erros;
4. validação;
5. persistência;
6. EF Core vs Dapper vs MongoDB por cenário;
7. migrations;
8. health checks;
9. logging estruturado;
10. integração com Dynatrace/Elastic;
11. tracing e métricas;
12. documentação de API;
13. API versioning;
14. autenticação/autorização;
15. estratégia de cache;
16. mensageria;
17. resilience;
18. background processing;
19. framework e organização de testes;
20. coding conventions;
21. analyzers;
22. nullable/warnings;
23. Clean Code;
24. SOLID;
25. Design Patterns;
26. refactoring;
27. Code Smells;
28. anti-patterns;
29. princípios específicos de sistemas financeiros;
30. modelo de instructions para AI coding agents.

Não tome as decisões agora.

---

# 15. QUESTÕES AINDA ABERTAS

Mantenha uma seção explícita para questões que continuam sem comprovação suficiente.

Inclua, quando ainda aplicável:

* política formal de lifecycle/upgrades de versões .NET;
* detalhes completos do Quality Gate, caso exista alguma divergência com os valores fornecidos;
* requisitos formais de API Gateway;
* requisitos de autenticação/autorização;
* instrumentação obrigatória para Dynatrace/Elastic;
* caminho recomendado entre IIS e AKS;
* governança futura do padrão .NET;
* processo formal de aprovação/homologação de novas bibliotecas;
* limites para tecnologias ainda não homologadas.

---

# FORMATO DO DOCUMENTO

Estruture `docs/architecture/corporate-dotnet-context.md` com:

1. **Resumo Executivo**
2. **Princípios de classificação**
3. **Criação e governança de repositórios**
4. **Runtime e política .NET**
5. **CI/CD e Quality Gates**
6. **Deployment, Azure e Cloud**
7. **Key Vault, secrets e identidade**
8. **Tecnologias corporativas disponíveis**
9. **APIs e integrações**
10. **Observabilidade**
11. **Testes e qualidade**
12. **Contexto do Boletron**
13. **Modernização e cloud híbrida**
14. **Definido corporativamente vs. decisão nossa**
15. **Engineering Candidates ainda não validados**
16. **Lacunas da futura .NET Engineering Baseline**
17. **Questões em aberto**
18. **Fontes consultadas**

Utilize tabelas quando melhorarem a precisão.

---

# REGRAS FINAIS

* Não invente.
* Não faça pesquisa externa.
* Não substitua informação corporativa por boas práticas de mercado.
* Não apresente informação fornecida pelo responsável como política formal sem evidência.
* Não transforme tecnologia disponível em tecnologia obrigatória.
* Não transforme ausência de padrão em recomendação.
* Não exponha dados sensíveis.
* Não altere outros arquivos.
* Não gere código.
* Não gere templates.
* Não produza ADRs ainda.
* Não defina a Engineering Baseline nesta etapa.

---

# ALTERAÇÃO PERMITIDA

A única alteração permitida nesta execução é criar:

`docs/architecture/corporate-dotnet-context.md`

Nenhum outro arquivo deve ser criado ou modificado.

---

# RESPOSTA FINAL

Depois de criar e revisar o arquivo, responda apenas com:

1. caminho do arquivo;
2. quantidade aproximada de linhas;
3. fontes principais utilizadas;
4. quantidade de itens classificados como:

   * política corporativa;
   * restrição de plataforma;
   * tecnologia corporativa disponível;
   * prática local;
   * informação do responsável;
   * não encontrado;
5. principais questões ainda abertas;
6. confirmação de que nenhuma decisão arquitetural dos futuros templates foi tomada nesta etapa.
