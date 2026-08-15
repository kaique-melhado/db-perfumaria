# CONTEXTO DE CONTINUIDADE — DS/DAC .NET ENGINEERING BASELINE

Quero que você assuma o papel de **revisor/arquiteto de software sênior independente** nesta iniciativa.

Estamos definindo, de forma pioneira, uma referência de engenharia .NET para o **DS (Departamento de Sistemas) / DAC (Departamento de Ações e Custódia) do Bradesco, Tesouraria**.

Não quero que você recomece o trabalho do zero. Já passamos por uma fase longa de discovery, coleta de evidências corporativas e análise arquitetural.

O trabalho está neste ponto:

Corporate Discovery
        +
FinTrack Reference Architecture
        +
Boletron Legacy Discovery
        ↓
Corporate Context
        ↓
Engineering Baseline Decision Dossier   ← ESTAMOS AQUI
        ↓
Revisão humana/independente
        ↓
ADRs / decisões aprovadas
        ↓
Template Specification
        ↓
Implementação dos templates
        ↓
AI Engineering Instructions
        ↓
Reference implementations / piloto
        ↓
Validação na esteira corporativa

Neste momento NÃO quero implementação de templates.

O próximo objetivo é realizar uma **revisão crítica e independente do `dotnet-engineering-baseline-decision-dossier.md`** antes que suas recomendações virem padrão departamental.

---

# 1. OBJETIVO DA INICIATIVA

Inicialmente pensei em três templates .NET:

- Essential;
- Standard;
- Advanced.

A intenção sempre foi evitar que todos os projetos fossem obrigados a usar Clean Architecture completa, CQRS, MediatR, mensageria, múltiplos projetos etc.

Um projeto pequeno não deve receber uma arquitetura de sistema distribuído apenas porque o template permite.

O princípio central definido durante a análise foi:

> **Complexidade arquitetural deve ser proporcional à complexidade do problema.**

Maior quantidade de projects, abstrações, layers ou patterns NÃO representa automaticamente maior qualidade.

Toda abstração/pattern/dependência deve responder:

> Que problema concreto isto resolve e quando seu custo é justificável?

Ao longo do trabalho surgiu uma hipótese possivelmente melhor que simplesmente manter três codebases de templates:

Baseline comum
    +
Archetypes
    +
Complexity Profiles
    +
Capabilities opt-in

Exemplo conceitual:

Archetype:
- API
- Library
- Worker
- Scheduled Job

Profile:
- Essential
- Standard
- Advanced

Capabilities:
- EF Core
- Dapper
- MongoDB
- Redis
- Kafka
- Resilience
- Worker/background processing
- Observability etc.

Essa composição AINDA NÃO deve ser considerada decisão definitiva.

O dossier deve ter avaliado modelos alternativos.

---

# 2. IMPORTANTE — FINTRACK NÃO É GOLDEN PATH

O projeto pessoal:

`kaique-melhado/fintrack-asset-monitoring-api`

foi usado como uma das referências técnicas.

Foi criado do zero e gosto particularmente de várias decisões dele:

- organização arquitetural;
- separação de camadas;
- SOLID;
- Clean Architecture;
- CQRS/MediatR;
- EF Core;
- Repository/UoW;
- FluentValidation;
- tratamento de erros;
- testes;
- Testcontainers;
- Health Checks;
- configuração;
- Serilog;
- DI etc.

Foi produzido um arquivo:

`fintrack-reference-architecture.md`

com aproximadamente 891 linhas, fazendo um raio-X técnico do projeto.

PORÉM:

> **FinTrack NÃO é um projeto modelo perfeito, uma arquitetura ideal ou uma especificação normativa.**

Ele é somente uma:

> **reference implementation moderna parcial.**

Regra fundamental:

- presença de algo no FinTrack ≠ obrigatório na baseline;
- ausência no FinTrack ≠ capacidade inválida para a baseline.

Há várias capacidades mais avançadas que o FinTrack não possui.

Exemplos:

- API Gateway;
- Redis;
- MongoDB;
- Kafka;
- observabilidade corporativa;
- cloud/hybrid cloud;
- resiliência mais sofisticada;
- service discovery;
- background processing mais completo;
- etc.

Portanto, NÃO use FinTrack como fonte de verdade arquitetural.

---

# 3. CONTEXTO CORPORATIVO LEVANTADO

Foi realizado um discovery corporativo bastante extenso dentro do workspace do banco.

O resultado foi persistido em:

`corporate-dotnet-context.md`

com aproximadamente 1.590 linhas.

Este documento NÃO propõe arquitetura.

Ele registra:

- políticas;
- restrições de plataforma;
- defaults;
- tecnologias disponíveis;
- práticas locais;
- contexto do legado;
- informações fornecidas por mim;
- lacunas;
- graus de confiança;
- fontes consultadas.

Ele deve ser entendido como resposta para:

> “O que precisamos respeitar ou considerar antes de definir uma Engineering Baseline .NET no DS/DAC?”

---

# 4. CRIAÇÃO DE REPOSITÓRIOS / BEX

Repos .NET corporativos são normalmente criados/solicitados através do Bex:

Bex
→ Solicitações
→ GitHub
→ Repositório/Pipeline

O processo coleta informações como:

- projeto Jira / VS Key;
- centro de custo;
- arquitetura;
- deployment target;
- artifact type;
- tecnologia;
- versão;
- canal;
- paths;
- servidores etc.

Existe automação/Terraform para criação do repository/pipeline.

A plataforma também gera/gerencia diversos componentes.

CODEOWNERS e workflows pertencem majoritariamente a times centrais.

---

# 5. .NET VERSION

Existe `LANGUAGE_VERSION` obrigatório na esteira.

A documentação corporativa atualmente recomenda:

`.NET 8.0.x`

Mas isto NÃO é um teto arquitetural permanente.

O Bex disponibiliza outras versões, inclusive .NET 10.

Também foram observadas versões como 6.0.x.

Portanto:

> 8.0.x deve ser tratado como versão vigente/recomendada atualmente, não como única versão corporativa possível para sempre.

Isso é importante para não construir uma baseline arquiteturalmente presa ao .NET 8.

---

# 6. CI/CD CORPORATIVO

Os repositories usam callers finos chamando reusable workflows centrais, aproximadamente:

`Bradesco-Core/reusable-workflows/...@latest`

O time do produto NÃO edita a implementação desses workflows.

Foram identificados fluxos como:

- release;
- sandbox;
- PR check;
- rollback;
- repository self-update.

Há runners self-hosted Windows.

A plataforma cuida de grande parte de:

- SDK/tooling;
- build;
- quality gates;
- packaging;
- artifact publication;
- deployment;
- Key Vault;
- token replacement;
- rollback;
- atualização dos próprios workflows.

O projeto/template precisa se adequar a esse contrato.

---

# 7. SONAR — DESCOBERTA MUITO IMPORTANTE

Foi identificado o Quality Gate corporativo default:

`bbdc-leap-way-incubating`

Para **New Code**, foram comprovadas condições aproximadamente:

- Coverage >= 90%;
- Duplicated Lines <= 3%;
- Maintainability Rating = A;
- Reliability Rating = A;
- Security Hotspots Reviewed = 100%;
- Security Rating = A.

Para **Overall Code**:

- Coverage >= 90%;
- Maintainability Rating = A;
- Reliability Rating = A;
- Security Hotspots Reviewed = 100%;
- Security Rating = A.

IMPORTANTE:

> a condição de duplicação <= 3% foi identificada para **New Code**, NÃO assumir automaticamente a mesma regra para Overall Code.

A coleta de coverage é feita pela própria esteira usando:

`dotnet-coverage`

com formato Visual Studio Coverage XML.

Portanto:

> não adicionar Coverlet ou outra ferramenta de coverage ao template apenas por hábito se a esteira já resolve isso.

Também foi identificada uma assimetria importante:

Java possui várias exclusões corporativas de coverage.

Para C#, praticamente toda a base é considerada.

O padrão encontrado referente a `Program.cs` estava relacionado à exclusão de duplicação, e não como exclusão geral de coverage.

Consequência:

> tornar cobertura >=90% sustentável deve influenciar fortemente testability, composition root e organização da futura baseline.

---

# 8. TESTES E ESTEIRA

A esteira executa `dotnet test`.

Foram observados comportamentos específicos de descoberta de testes.

Existe caminho relacionado a MSTest/MSTest.Sdk/MTP e caminho VSTest tradicional.

A esteira NÃO determina formalmente:

- xUnit;
- NUnit;
- MSTest;
- organização de testes;
- fixtures;
- mocks;
- Testcontainers;
- architecture tests etc.

Portanto:

> o framework e a estratégia de testes ainda são decisão da Engineering Baseline.

Não copiar xUnit do FinTrack automaticamente.

---

# 9. PACKAGES.LOCK.JSON

A ausência de:

`packages.lock.json`

já causou falha real na execução da esteira.

Não foi localizada uma norma escrita absolutamente inequívoca dizendo “todo repo deve possuir packages.lock.json”.

Por isso o documento tratou corretamente como:

> constraint operacional observada / restrição de plataforma

e não inventou uma “política corporativa formal”.

Na prática, qualquer template novo deve considerar seriamente essa compatibilidade.

---

# 10. NEXUS / ARTIFACT TYPE

Existe Nexus corporativo.

Uma descoberta importante foi que `ARTIFACT_TYPE` muda profundamente o comportamento do pipeline.

Exemplo conceitual:

`lib`
→ dotnet pack
→ .nupkg
→ Nexus/NuGet
→ não gera web.config
→ não sofre deploy como aplicação

`app`
→ dotnet publish
→ artefato/zip
→ Nexus Raw
→ web.config quando aplicável
→ deployment

Isso é um dos motivos para questionarmos se “Essential / Standard / Advanced” é a única dimensão correta.

Talvez tenhamos:

ARQUÉTIPO
×
COMPLEXIDADE
×
CAPABILITIES

em vez de simplesmente três templates físicos independentes.

---

# 11. DEPLOYMENT ATUAL

Na esteira analisada foi comprovado:

Windows Server
+
IIS on-premises
+
WinRM
+
Nexus

Há stop/start de IIS, cópia remota, paths por ambiente e rollback.

Porém:

> IIS NÃO deve ser tratado como teto arquitetural permanente.

Também existe caminho corporativo para:

AKS

mas ele:

> NÃO é obrigatório para todos os projetos.

Logo a futura baseline deve provavelmente funcionar bem hoje no modelo IIS sem criar acoplamento que impeça containers/AKS amanhã.

---

# 12. AZURE / AWS

Azure é hoje a cloud mais madura/predominante no banco.

Na esteira analisada, o uso de Azure comprovado diretamente está principalmente ligado a:

Azure Login
→ Key Vault
→ secrets durante deployment.

Não devemos concluir automaticamente que toda aplicação .NET roda no Azure.

AKS está disponível como caminho corporativo.

AWS está começando a ser adotada no banco como parte da estratégia de cloud híbrida.

Azure permanece atualmente como cloud principal.

A futura arquitetura não deve fazer Core/Application conhecer Azure ou AWS desnecessariamente.

---

# 13. KEY VAULT / SECRETS

Existe processo formal para criação de secrets:

RITM
→ Track/ServiceNow
→ aprovação
→ DITI / Acessos Cloud
→ Key Vault

Foi comprovada segregação por ambiente.

O mecanismo atual observado é aproximadamente:

App/template
→ config/{DEV,HOM,PRD}/appsettings.json
→ placeholders/tokenização
→ pipeline
→ Azure Login
→ Key Vault
→ substituição de tokens durante deployment
→ artefato configurado

Importante:

Não foi comprovado como padrão atual:

App
→ leitura direta do Azure Key Vault em runtime

Também NÃO presumir Managed Identity.

A futura baseline poderá avaliar portabilidade/futuro AKS, mas o documento corporativo não tomou essa decisão.

---

# 14. TECNOLOGIAS CORPORATIVAS DISPONÍVEIS

Foram relatadas/observadas como parte do ecossistema corporativo, em diferentes graus de comprovação:

- APIM;
- Axway;
- Redis;
- Azure Cache for Redis;
- MongoDB;
- Kafka;
- Dynatrace;
- Elastic;
- JWT;
- AKS;
- Azure;
- AWS em adoção.

Disponível ≠ obrigatório.

O documento corporativo foi intencionalmente cuidadoso para não transformar tecnologia existente em padrão da baseline.

---

# 15. API GATEWAY

APIM é utilizado em projetos do banco.

Axway também é utilizado.

Nenhum dos dois é obrigatório para toda API.

Não existe evidência suficiente de um padrão .NET obrigatório neste aspecto.

Ocelot/Kong foram levantados apenas como possíveis Engineering Candidates.

Não queremos criar gateway dentro de todo serviço por hábito.

Precisamos decidir futuramente se gateway é:

- responsabilidade da plataforma;
- capability;
- BFF específico;
- API aggregation;
- ou outro arquétipo.

---

# 16. MENSAGERIA

Kafka é muito utilizado/predominante no ambiente corporativo.

RabbitMQ é tecnicamente conhecido, aberto, simples e muito natural no ecossistema .NET.

Porém:

> afinidade com .NET não é justificativa suficiente para torná-lo padrão corporativo.

Uma futura decisão deve considerar:

- operação;
- governança;
- skill interno;
- observabilidade;
- throughput;
- ordering;
- replay;
- consumer groups;
- simplicidade;
- developer experience etc.

---

# 17. CACHE

Redis e Azure Cache for Redis fazem parte das tecnologias utilizadas no banco.

Isto NÃO significa que todo template terá Redis.

Devemos avaliar posteriormente:

- IMemoryCache;
- distributed cache;
- Redis;
- Azure Cache for Redis;
- cache no gateway;

conforme cenário.

---

# 18. MONGODB / DADOS

MongoDB faz parte das stacks utilizadas no banco.

SQL Server é extremamente presente no domínio/legado.

Dapper também é utilizado em contextos existentes.

FinTrack usa EF Core.

Não há padrão .NET corporativo definido dizendo:

“EF Core é default”
ou
“Dapper é default”.

Precisamos decidir por cenário.

Isso também significa que Infrastructure não deve ser conceitualmente sinônimo de EF Core.

---

# 19. OBSERVABILIDADE

Dynatrace possui presença muito forte no banco.

Elastic também é utilizado.

Porém ainda NÃO está comprovado:

- quanto da instrumentação precisa estar dentro da aplicação;
- quanto é agent/infrastructure;
- padrões obrigatórios de tracing;
- metrics;
- naming;
- correlation IDs;
- OpenTelemetry etc.

FinTrack usa Serilog.

Isto NÃO significa que Serilog será automaticamente o padrão corporativo.

A hipótese técnica é preferir abstrações interoperáveis como:

`ILogger<T>`
`Activity`
OpenTelemetry quando justificável

e integrar com Dynatrace/Elastic sem acoplar business code à ferramenta.

Mas isso ainda deve ser revisado.

---

# 20. ENGINEERING CANDIDATES

Foram levantados como candidatos técnicos, NÃO como padrões corporativos:

- Polly;
- `Microsoft.Extensions.Http.Resilience`;
- circuit breaker;
- retry;
- timeout;
- Hangfire;
- Consul;
- Ocelot;
- Kong;
- OpenTelemetry;
- EF Core;
- Dapper;
- frameworks de teste;
- analyzers;
- Central Package Management;
- `.editorconfig`;
- architecture tests;
- etc.

Qualquer tecnologia não comprovadamente homologada deve permanecer como:

`REQUIRES CORPORATE VALIDATION`

ou equivalente.

---

# 21. BOLETRON

O principal legado é o Boletron, enorme sistema monolítico WinForms/.NET Framework.

Foi produzido um discovery estrutural:

`2026-07-30-levantamento-estrutural-boletron.md`

O Boletron NÃO é referência arquitetural.

Ele é:

> contexto do legado / fonte de anti-patterns e riscos.

O levantamento encontrou características compatíveis com Big Ball of Mud, incluindo:

- boundaries permeáveis;
- UI acessando Data diretamente;
- negócio conhecendo WinForms;
- grandes God Helpers;
- helpers duplicados;
- estado global mutável;
- singleton;
- code-behind enorme;
- ADO.NET manual;
- stored procedures;
- SQL concatenado;
- configuração historicamente acoplada ao código;
- secrets/crypto históricos problemáticos;
- DLLs e dependências manuais;
- dependências instaladas na máquina;
- ausência de testes automatizados identificados;
- fragmentação de projetos;
- múltiplas gerações tecnológicas coexistindo.

A nova baseline deve utilizar os SINTOMAS como aprendizado.

Exemplo:

Não basta dizer:
“Boletron é Big Ball of Mud”.

É melhor dizer:
“Mutable global state produziu acoplamento e dificuldade de isolamento → baseline deve desencorajar/proibir esse mecanismo”.

---

# 22. ANTI-PATTERNS QUE QUEREMOS ANALISAR

Entre outros:

- Presentation → DB direto;
- Business/Application → UI framework;
- mutable global state;
- Service Locator;
- giant static helpers;
- God Classes;
- SQL concatenado;
- environment switching via código;
- secrets hardcoded;
- crypto com chave junto ao código;
- binários manuais no repository;
- dependência implícita de componentes instalados na máquina;
- exceptions silenciosamente engolidas;
- catch-all irresponsável;
- abstrações sem propósito;
- interfaces criadas por ritual;
- Repository indiscriminado;
- CQRS indiscriminado;
- overengineering.

---

# 23. FINANCIAL DOMAIN ENGINEERING

Como os templates serão voltados para Tesouraria/DAC, queremos considerar preocupações de sistemas financeiros, por exemplo:

- precisão monetária;
- decimal vs floating point;
- currency explícita;
- rounding explícito;
- datas financeiras;
- timezone;
- business day;
- idempotência;
- auditabilidade;
- reconciliação;
- rastreabilidade;
- ordering;
- duplicidade de eventos;
- invariantes;
- consistência;
- concorrência;
- retries seguros;
- operações irreversíveis;
- observabilidade de operações críticas.

Nem tudo precisa ser `MANDATORY`.

Queremos distinguir baseline transversal de preocupação contextual.

---

# 24. AI ENGINEERING INSTRUCTIONS

Existe interesse em, posteriormente, gerar `.github/instructions` ou mecanismo equivalente para orientar coding agents.

Temas pretendidos:

- Clean Code;
- SOLID;
- Design Patterns;
- Architecture;
- Testing;
- APIs;
- Persistence;
- Security;
- Observability;
- Refactoring;
- Code Smells;
- Anti-patterns;
- Critical Engineering Thinking;
- Financial Domain Engineering.

Uma regra desejada é:

> não introduzir abstração, library ou pattern sem explicar o problema concreto que resolve.

As instructions devem derivar da Engineering Baseline aprovada.

Não queremos uma baseline para humanos e outra divergente para IA.

---

# 25. PRODUTO MAIOR DA INICIATIVA

A visão evoluiu de “três templates .NET” para algo conceitualmente mais próximo de:

DS/DAC .NET Engineering Platform

1. Engineering Baseline
2. Service Templates
3. Capability Modules
4. AI Engineering Instructions

Possivelmente:

Engineering Baseline
        ↓
Archetypes
  ├─ API
  ├─ Library
  ├─ Worker
  └─ Scheduled Job
        ↓
Profiles
  ├─ Essential
  ├─ Standard
  └─ Advanced
        ↓
Capabilities
  ├─ EF Core
  ├─ Dapper
  ├─ MongoDB
  ├─ Redis
  ├─ Kafka
  ├─ Resilience
  ├─ Observability
  └─ etc.

Mas isso ainda precisa passar pela revisão do dossier.

---

# 26. ARTEFATO ATUAL

O Agent corporativo produziu:

`dotnet-engineering-baseline-decision-dossier.md`

Esse dossier foi construído cruzando:

1. `corporate-dotnet-context.md`
2. `fintrack-reference-architecture.md`
3. discovery do Boletron
4. conhecimento moderno de engenharia .NET

O dossier já foi FINALIZADO.

PORÉM:

> ainda NÃO o considero decisão oficial.

Ele é uma proposta técnica consolidada.

Agora precisamos fazer uma revisão crítica independente antes de transformar suas recomendações em ADRs, specification ou código.

---

# 27. SEU PAPEL AGORA

Quando eu anexar o:

`dotnet-engineering-baseline-decision-dossier.md`

quero que você atue como uma **segunda perspectiva arquitetural independente**.

NÃO presuma que as decisões do Agent corporativo estão corretas apenas porque foram produzidas por um modelo avançado.

Quero que você procure:

### Decisões sólidas

Aquilo que faz sentido manter.

### Overengineering

Patterns/camadas/capabilities que estejam sendo impostos sem benefício proporcional.

### Underengineering

Aspectos importantes ausentes ou tratados superficialmente.

### Contradições

Entre diferentes partes do dossier ou com constraints corporativas já identificadas.

### FinTrack bias

Qualquer decisão aparentemente tomada apenas porque FinTrack faz daquele jeito.

### Legacy overreaction

Decisões exageradas tomadas apenas como reação aos problemas do Boletron.

### Technology bias

Preferência por determinada biblioteca ou tecnologia sem razão operacional/arquitetural suficiente.

### Corporate mismatches

Recomendação incompatível com pipeline/plataforma/quality gates existentes.

### Portability problems

Acoplamento desnecessário a IIS, Azure, AWS, Dynatrace etc.

### Testability problems

Especialmente considerando coverage >=90% praticamente sobre toda a base C#.

### Classification problems

Algo marcado como MANDATORY que deveria ser DEFAULT/CONDITIONAL/OPT-IN, ou o inverso.

---

# 28. CLASSIFICAÇÕES UTILIZADAS

O dossier trabalha aproximadamente com:

- MANDATORY;
- DEFAULT;
- CONDITIONAL;
- OPT-IN;
- EXCLUDED;
- REQUIRES CORPORATE VALIDATION;
- OPEN DECISION.

Quero que você questione essas classificações quando necessário.

---

# 29. O QUE EU QUERO DA SUA REVISÃO

Depois de ler integralmente o dossier, produza uma revisão organizada em:

## A. Avaliação geral

Qualidade, coerência e maturidade da proposta.

## B. Decisões que você manteria

Com justificativa.

## C. Decisões que você alteraria

Mostre:
- decisão atual;
- problema;
- decisão sugerida;
- motivo.

## D. Possível overengineering

Especialmente Essential/Standard.

## E. Possível underengineering

Especialmente Advanced e concerns transversais.

## F. Mandatory vs Default vs Conditional vs Opt-in

Revise criticamente a classificação.

## G. Archetypes / Profiles / Capabilities

Avalie se essa decomposição realmente é superior a três templates físicos separados.

## H. FinTrack influence

Identifique onde o reference implementation pode ter influenciado excessivamente.

## I. Boletron lessons

Verifique se os problemas do legado foram convertidos em princípios úteis em vez de regras dogmáticas.

## J. Corporate constraints

Identifique qualquer conflito com:
- Bex;
- pipeline;
- Nexus;
- Sonar;
- tests;
- packages.lock;
- Key Vault;
- IIS;
- AKS;
- cloud etc.

## K. Decisões que exigem validação corporativa

Separe engenharia de homologação/política.

## L. ADR candidates

Sugira quais decisões são grandes/difíceis de reverter o suficiente para merecer ADR.

NÃO criar dezenas de ADRs pequenos.

Uma hipótese inicial de agrupamento é algo como:

ADR-001 — Template composition model
ADR-002 — Architecture and boundaries
ADR-003 — Feature/project organization
ADR-004 — Persistence strategy
ADR-005 — API/error handling
ADR-006 — Testing strategy
ADR-007 — Observability
ADR-008 — Messaging/background processing
ADR-009 — Resilience
ADR-010 — Configuration/secrets/portability
ADR-011 — Code quality and governance
ADR-012 — Financial domain engineering

Mas você deve criticar inclusive essa divisão.

## M. Próxima versão recomendada

Diga exatamente o que devemos modificar ou validar antes de avançar.

---

# 30. O QUE NÃO FAZER AINDA

Não:

- implementar templates;
- gerar `.sln`;
- gerar `.csproj`;
- gerar código;
- criar NuGet template;
- criar `dotnet new`;
- criar capabilities;
- criar AI instructions finais;
- criar dezenas de ADRs;
- redesenhar tudo do zero sem necessidade.

Primeiro precisamos validar as decisões.

---

# 31. PRÓXIMA FASE DEPOIS DA REVISÃO

Depois que concordarmos com a revisão, a sequência pretendida é:

Decision Dossier
        ↓
Revisão independente
        ↓
Decisões aprovadas
        ↓
ADRs principais
        ↓
`dotnet-template-specification.md`
        ↓
implementação física
        ↓
reference implementations
        ↓
CI corporativo
        ↓
piloto/adoption

O `dotnet-template-specification.md` deverá ser a tradução de:

“deveríamos fazer X”

para:

“o template deverá gerar exatamente X”.

Somente nesse momento deveremos especificar fisicamente:

- projects;
- folders;
- references;
- NuGet packages;
- naming;
- namespaces;
- `.editorconfig`;
- Directory.Build.props;
- Directory.Packages.props caso aprovado;
- packages.lock.json;
- global.json;
- tests;
- config;
- observability;
- health;
- etc.

---

# 32. CRITÉRIO DE SUCESSO

A ambição não é criar algo tecnicamente “bonito”.

Precisamos de uma baseline que:

- seja tecnicamente sólida;
- não produza overengineering;
- funcione na plataforma corporativa;
- passe pelos quality gates;
- seja fácil para outros times adotarem;
- seja evolutiva;
- suporte diferentes níveis de complexidade;
- reduza recorrência dos problemas históricos do legado;
- seja compatível com IIS atual e evolução para AKS/cloud;
- seja convincente o suficiente para ganhar credibilidade no DS/DAC.

Somos pioneiros nessa padronização .NET dentro deste contexto.

Portanto:

> simplicidade, pragmatismo, justificativa técnica e capacidade real de adoção importam tanto quanto sofisticação arquitetural.

Na próxima mensagem vou anexar o `dotnet-engineering-baseline-decision-dossier.md`.

Leia-o integralmente antes de iniciar a revisão.

“Segue o dossier. Faça agora a revisão crítica independente conforme o contexto que enviei.”
