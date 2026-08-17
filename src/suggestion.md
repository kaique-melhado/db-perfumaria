1. Executive Summary

Minha recomendação é não implementar três templates fisicamente independentes.

O modelo que considero mais sustentável é:
DS/DAC .NET Engineering Baseline
                │
                ▼
            Archetype
                │
        ┌───────┼────────┐
        ▼       ▼        ▼
       API    Worker   Library ...
                │
                ▼
             Profile
       ┌────────┼────────┐
       ▼        ▼        ▼
   Essential Standard Advanced
                │
                ▼
           Capabilities
       EF / Dapper / Mongo
       Redis
       Kafka
       Resilience
       etc.


Ou seja:

Archetype × Profile × Capabilities, compartilhando uma única Engineering Baseline.

Os três nomes Essential, Standard e Advanced continuam úteis, mas devem representar profiles de complexidade, e não três codebases que evoluem separadamente.

Minha proposta conceitual é:

Essential: uma unidade deployável pequena, profissional e testável, com um único projeto de produção na maioria dos casos, sem CQRS/MediatR/Repository/UoW por ritual.
Standard: separação explícita entre host, core e infraestrutura, adequada à maioria dos sistemas relevantes do DAC. Minha proposta é 3 projetos de produção (Api, Core, Infrastructure) em vez de copiar automaticamente os quatro projetos clássicos do FinTrack.
Advanced: boundaries mais fortes e independentes, normalmente Api, Application, Domain e Infrastructure, adicionando hosts/contracts somente quando necessários. Não significa Kafka + Redis + Mongo + CQRS ligados simultaneamente.

A principal diferença em relação ao FinTrack é deliberada: eu não copiaria como baseline geral seu projeto Configuration, CQRS/MediatR, Repository/UoW, EF Core, Serilog ou estrutura completa de camadas. Todos continuam válidos como soluções para problemas específicos, mas não como requisitos universais.

Do Boletron eu derivaria principalmente propriedades negativas da baseline: não permitir dependência oculta entre UI e dados, estado global mutável, God Helpers, configuração por código, secrets próximos ao source, SQL concatenado, binários manuais, dependências implícitas da máquina e ausência estrutural de testes.

A baseline transversal seria pequena, mas forte: testabilidade, configuração segura, DI, logging estruturado via abstrações, erros previsíveis, validação de boundary, nullable, convenções, async/cancellation, quality gates, package locking, ausência de global state e separação entre código da aplicação e infraestrutura corporativa.

2. Recommended Template Model
Recomendação

Modelo recomendado: Archetype × Profile × Capabilities sobre uma baseline única.

CONFIDENCE: High.

Por que não três templates físicos independentes?

Porque rapidamente surgiria:
Essential ── implementação própria de logging
Standard  ── implementação quase igual
Advanced  ── outra implementação

Essential ── error handling v1
Standard  ── error handling v2
Advanced  ── error handling v3

Depois de dois anos:
3 templates
×
4 archetypes
×
10 capabilities
×
diferentes versões .NET
= drift significativo
O custo de manutenção tenderia a crescer exponencialmente.

Modelo proposto

A arquitetura conceitual deveria separar três dimensões.

Archetype

Define o que o artefato é operacionalmente.

Inicialmente eu consideraria:

Archetype	Papel
Web API	Serviço HTTP
Worker	Processamento contínuo/consumer
Library	Pacote reutilizável/NuGet
Scheduled Job	Execução periódica/batch

BFF/Gateway não entraria inicialmente. Pode virar um archetype futuro se houver demanda real.

Profile

Define quanto isolamento arquitetural o problema justifica:

Essential
Standard
Advanced
Capability

Define infraestrutura ou comportamento opcional:

persistence-ef;
persistence-dapper;
persistence-mongodb;
cache-redis;
messaging-kafka;
resilience;
background processing;
telemetry;
etc.

Assim:

API + Standard + EF Core

é diferente de:

API + Standard + Dapper + Redis

sem exigir novos templates físicos.

Uma consequência importante

O profile não deve definir necessariamente o deployment.

Por exemplo:

API / Standard

pode hoje ser:

IIS

e amanhã:

AKS

sem alterar Application/Core.

Deployment pertence principalmente ao archetype + plataforma, não ao nível de sofisticação arquitetural.

3. Common Engineering Baseline

Esta é provavelmente a parte mais importante da proposta, porque é onde se evita tanto um Essential irresponsável quanto um Advanced inflado.

Mandatory for all
Build e linguagem
projeto SDK-style;
Target Framework parametrizável pela versão corporativa/Bex;
atualmente compatível com .NET 8.0.x;
solution na estrutura esperada pela esteira;
packages.lock.json, tratando sua presença como restrição operacional observada;
dependências restauráveis pelo Nexus corporativo;
sem binários manualmente commitados para substituir package management.
Qualidade
Nullable habilitado;
.editorconfig;
async real para I/O;
não utilizar Task.Result, .Wait() ou sync-over-async;
CancellationToken propagado nos boundaries assíncronos relevantes;
nenhum mutable global state como mecanismo de compartilhamento;
nenhuma dependência por Service Locator;
nenhuma credencial hardcoded;
nenhuma configuração de ambiente controlada por comentário/source code;
acesso SQL sempre parametrizado.
Dependency Injection

Microsoft.Extensions.DependencyInjection e abstrações nativas são o baseline.

DI é MANDATORY para componentes com dependência real.

Isso não significa criar interface para toda classe.

Uma classe pode ser concreta e registrada diretamente.

Configuration
IConfiguration no composition root;
Options Pattern para configurações estruturadas relevantes;
separação de configuração por ambiente compatível com o mecanismo corporativo;
secrets resolvidos pela plataforma;
nenhum domínio conhecendo Key Vault.
Logging
ILogger<T> como abstração;
structured logging;
nenhuma chamada direta de código de negócio para Dynatrace/Elastic;
dados sensíveis/PII nunca logados indiscriminadamente.
Testability

Todos os templates devem nascer testáveis.

A baseline deve pressupor que o sistema precisará satisfazer:

Coverage ≥ 90%.

Mas o objetivo não é cobrir linha por ritual.

Código com baixa testabilidade é sinal de design ruim, não justificativa para testes artificiais.

Security
nenhuma secret no source;
dependency governance;
input não confiável validado;
autorização executada no boundary adequado;
nenhuma implementação própria de criptografia/autenticação sem necessidade comprovada.
Default for most projects
organização feature-first dentro de cada boundary;
Controllers para APIs empresariais;
explicit mapping entre contracts externos e modelo interno;
integration tests para hosts executáveis;
OpenAPI para APIs;
Health Checks para aplicações executáveis;
TimeProvider para lógica sensível a relógio/data;
structured tracing através de abstrações nativas.
Conditional
Domain project;
FluentValidation;
architecture tests;
EF Core;
Dapper;
MongoDB;
Repository;
CQRS;
MediatR;
Redis;
Kafka;
idempotency;
retries;
circuit breaker;
API versioning;
distributed tracing completo;
contract tests.
Opt-in
Outbox/Inbox;
multi-database;
read models separados;
Hangfire;
RabbitMQ;
Ocelot;
Kong;
Consul;
advanced caching;
custom schedulers;
hedging.
Excluded

Eu excluiria da baseline oficial:

Service Locator;
mutable static/global state;
SQL concatenado;
secrets no source;
environment switching via source code;
DLLs manuais quando package management é possível;
Repository que apenas replica DbSet;
Unit of Work redundante sobre EF sem necessidade adicional;
CQRS por convenção;
MediatR como requisito arquitetural;
catch-all silencioso;
custom crypto para secrets corporativos;
migration automática indiscriminada em produção multi-instância.
Corporate/platform-owned

Não devem ser reinventados pelo template:

GitHub workflow corporativo;
reusable workflows;
runners;
Sonar collection;
dotnet-coverage;
Fortify;
Mend;
Gitleaks;
Nexus;
release;
rollback;
WinRM deployment;
Key Vault authentication;
token replacement;
infraestrutura de IIS;
provisionamento de AKS;
API Gateway corporativo;
Dynatrace agent quando fornecido pela plataforma.

4. Essential Template
Identity

Nome: Essential

Objetivo: entregar a menor arquitetura que ainda seja profissional, segura, testável e sustentável.

Público-alvo: serviços pequenos, APIs de baixa complexidade, integrações simples e componentes internos.

Cenários indicados
CRUD com poucas regras;
1 persistência simples;
poucas integrações;
lifecycle relativamente previsível;
baixo grau de concorrência;
domínio simples;
equipe pequena;
baixa necessidade de coordenação distribuída.
Não usar quando
regras de domínio passam a ser o principal problema;
múltiplas integrações possuem comportamento complexo;
mensageria passa a ser central;
consistência distribuída aparece;
múltiplos modelos de dados;
workflow financeiro complexo;
diferentes partes precisam evoluir independentemente.
Complexity profile
Dimensão	Essential
Domain complexity	Baixa
Integration complexity	Baixa
Data complexity	Baixa–média
Operational complexity	Baixa
Scalability	Convencional
Reliability	Profissional, não distribuída
Observability	Baseline
Testing	Alta exigência, baixa complexidade
Architecture
RECOMMENDED

Para API:

Service.Api
Service.UnitTests
Service.IntegrationTests

Ou seja:

1 projeto de produção + testes separados.

Isso é deliberado.

Não vejo benefício suficiente em criar quatro assemblies para um serviço simples.

Dentro do projeto:

Features/
Infrastructure/
Contracts/
Common/

Boundaries são primeiro conceituais e de namespace, não necessariamente assemblies.

Regra importante

Controller/endpoint não acessa banco diretamente.

Mesmo em um único assembly:

HTTP
 ↓
Feature / Use Case
 ↓
Persistence / External adapter

é preferível a:

Controller → DbContext

Isso reduz o risco de reproduzir justamente o tipo de atravessamento observado no legado.

Application structure
Mecanismo	Essential
Use cases	MANDATORY conceitualmente
Application service	DEFAULT
Handler	CONDITIONAL
Command/Query	EXCLUDED por padrão
MediatR	EXCLUDED por padrão
Domain service	CONDITIONAL
Validator	MANDATORY como conceito
FluentValidation	OPT-IN / REQUIRES CORPORATE VALIDATION
DTO	DEFAULT nos boundaries
Mapper explícito	DEFAULT
Mapping library	OPT-IN
Domain Events	EXCLUDED por padrão

Um use case pode ser simplesmente:

CreatePositionService

Não precisamos chamá-lo de:

CreatePositionCommandHandler

se nenhum benefício arquitetural surgir daí.

Persistence

EF Core, Dapper e MongoDB são capabilities, não componentes do Essential.

EF Core

CONDITIONAL

Bom quando:

CRUD/modelo relacional;
tracking é útil;
produtividade importa;
consultas são moderadas.
Dapper

CONDITIONAL

Bom quando:

SQL é parte importante da solução;
queries específicas;
performance previsível;
domínio fortemente relacional/legado.
Repository

EXCLUDED como default.

Se EF Core estiver sendo usado em um Essential, criar:

IPositionRepository
PositionRepository

apenas para chamar:

DbSet<Position>

não adiciona valor.

Unit of Work

EXCLUDED como default.

DbContext já possui comportamento de unidade de trabalho.

API
Controllers: DEFAULT;
Minimal APIs: OPT-IN;
ProblemDetails: MANDATORY;
tratamento centralizado de exceptions: MANDATORY;
validação de request: MANDATORY;
OpenAPI: DEFAULT;
API versioning: CONDITIONAL;
idempotency: CONDITIONAL;
auth/authz: concern MANDATORY, mecanismo específico OPEN DECISION.

Para .NET 8, eu preferiria estudar IExceptionHandler + ProblemDetails ao invés de replicar automaticamente o middleware customizado do FinTrack.

Testing
unit tests: MANDATORY onde existe regra;
API integration tests: DEFAULT;
architecture tests: EXCLUDED;
contract tests: CONDITIONAL;
Testcontainers: OPT-IN;
test framework: OPEN DECISION.

Cobertura deve vir de testes úteis.

O Essential precisa ser mais fácil, e não mais difícil, de cobrir em 90%.

Observability
ILogger<T>: MANDATORY;
structured logs: MANDATORY;
Activity/TraceId propagation: DEFAULT;
metrics customizadas: CONDITIONAL;
OpenTelemetry: REQUIRES CORPORATE VALIDATION;
Dynatrace/Elastic direct SDK: EXCLUDED.
Configuration and secrets
Options/configuration: baseline;
config DEV/HOM/PRD compatível com plataforma;
tokenização corporativa;
nenhum acesso direto obrigatório ao Key Vault;
nenhum Managed Identity assumido.
Resilience

Se Essential não chama downstream remoto:

nenhuma policy de resilience necessária.

Se chama HTTP:

timeout explícito: MANDATORY;
retry: CONDITIONAL;
circuit breaker: CONDITIONAL;
hedging: EXCLUDED por padrão;
Microsoft.Extensions.Http.Resilience: REQUIRES CORPORATE VALIDATION.
Messaging/background processing

Kafka, RabbitMQ e long-running consumers normalmente são um sinal de que talvez Essential não seja mais o profile correto.

Mas não automaticamente.

Um worker muito simples pode ser Essential.

Security

Boundary validation, auth/authz apropriada, secrets fora do código, parameterized queries e dependency governance.

Financial domain

Baseline:

não usar floating point para valores monetários;
rounding explícito quando relevante;
currency não deve ser inferida silenciosamente;
timezone/data precisam de semântica explícita.

Idempotência/auditabilidade/reconciliação são CONDITIONAL, não devem transformar todo CRUD em ledger financeiro.

5. Standard Template
Identity

Objetivo: provável golden path para a maioria dos novos sistemas relevantes do DAC.

O Standard começa quando:

a simplicidade de um único assembly passa a dificultar isolamento, testabilidade e evolução.

Complexity profile
Dimensão	Standard
Domain	Média
Integrations	Média
Data	Média
Operational	Média
Scalability	Média
Reliability	Elevada
Observability	Estruturada
Testing	Unit + integration
Architecture

Minha recomendação é não copiar automaticamente Api + Application + Domain + Infrastructure.

Proponho inicialmente:

Service.Api
Service.Core
Service.Infrastructure

mais:

Service.UnitTests
Service.IntegrationTests
Por que Core?

Porque um sistema moderadamente complexo precisa separar:

business/use cases

de:

framework/infrastructure

mas ainda pode não justificar dois assemblies diferentes para Domain e Application.

Dentro de Core:

Features/
Domain/
Abstractions/
Dependências
Api ─────────► Core
 │
 └──────────► Infrastructure


Infrastructure ─► Core


Core ───────────► nenhuma Infrastructure

Api é composition root.

Infrastructure nunca deve ser consumida pelo Core.

Application structure
use cases: MANDATORY;
feature-first: DEFAULT;
domain model: DEFAULT;
domain service: CONDITIONAL;
CQRS: CONDITIONAL;
MediatR: OPT-IN;
FluentValidation: DEFAULT conceitualmente, package sujeito a validação;
pipeline behaviors: OPT-IN;
domain events: CONDITIONAL.
CQRS no Standard

CQRS não significa necessariamente MediatR.

Pode ser simplesmente:

Commands/
Queries/

quando reads e writes realmente possuem necessidades distintas.

Não crie duas estruturas se:

CreateFoo
GetFoo

são triviais.

Persistence
EF Core

CONDITIONAL / provável DEFAULT para CRUD relacional, caso aprovado no contexto corporativo.

Dapper

CONDITIONAL.

Especialmente adequado a:

queries complexas;
integrações com schemas existentes;
SPs;
leitura de alto controle.
MongoDB

CONDITIONAL.

Não deve ser selecionado porque “é mais moderno”.

Repository

CONDITIONAL.

Justificado quando:

aggregate boundary é importante;
infraestrutura precisa ficar escondida do Core;
persistence semantics são relevantes.

Não justificado como wrapper 1:1 de EF.

UoW

CONDITIONAL.

Não precisa existir explicitamente apenas porque Repository existe.

API

Mesma baseline do Essential, com:

contract stability maior;
versioning CONDITIONAL;
explicit request/response DTOs DEFAULT;
authorization policies DEFAULT;
API lifecycle mais disciplinado;
contract testing CONDITIONAL.
Testing
unit: MANDATORY;
integration: MANDATORY para paths relevantes;
architecture tests: DEFAULT;
Testcontainers: CONDITIONAL;
contract tests: CONDITIONAL.

No Standard, architecture tests começam a ter retorno porque existem boundaries reais a proteger.

Observability
ILogger structured: MANDATORY;
Activity/tracing: DEFAULT;
métricas de negócio/operação: CONDITIONAL;
OpenTelemetry: DEFAULT tecnicamente, porém REQUIRES CORPORATE VALIDATION;
integração Dynatrace/Elastic: por adapter/plataforma.
Resilience

Para integrações remotas:

timeout: MANDATORY;
retry: DEFAULT quando operação for segura;
jitter: DEFAULT em retry distribuído;
circuit breaker: CONDITIONAL;
fallback: raro;
hedging: OPT-IN.

Retry em operação financeira não idempotente sem análise específica deve ser considerado erro de design.

Messaging/background processing
Kafka: CONDITIONAL;
RabbitMQ: REQUIRES CORPORATE VALIDATION;
consumer: capability;
worker host: archetype/capability;
scheduled jobs: capability.

Mensageria não promove automaticamente um serviço para Advanced.

6. Advanced Template
Identity

Advanced existe quando a complexidade não pode mais ser gerenciada adequadamente apenas por disciplina interna de Core.

Exemplos:

domínio financeiro rico;
workflows complexos;
concorrência relevante;
coordenação de múltiplas integrações;
mensageria central;
consistência/eventual consistency;
múltiplos stores;
alto volume;
elevada auditabilidade;
componentes com ritmos de evolução distintos.
Architecture

Baseline:

Service.Api
Service.Application
Service.Domain
Service.Infrastructure

Possíveis adicionais:

Service.Contracts       CONDITIONAL
Service.Worker          CONDITIONAL
Service.ArchitectureTests

Ainda assim:

não criar Messages, Workers, Caching, Shared, Common, Services etc. apenas porque é Advanced.

Boundaries
Api
 ↓
Application
 ↓
Domain


Infrastructure
 └────► Application/Domain

Domain:

não conhece ASP.NET;
não conhece banco;
não conhece Kafka;
não conhece Redis;
não conhece Azure;
não conhece Dynatrace.

Application coordena use cases.

Infrastructure implementa adapters.

CQRS

CONDITIONAL.

Advanced não torna CQRS obrigatório.

É justificado quando:

reads e writes possuem modelos distintos;
throughput é assimétrico;
regras de command são substanciais;
pipelines distintos agregam valor.
MediatR

OPT-IN / REQUIRES CORPORATE VALIDATION.

MediatR é mecanismo de dispatch, não arquitetura.

Se injeção direta de use-case services for mais clara, prefira simplicidade.

DDD

CONDITIONAL / DEFAULT para domínios realmente ricos.

Possíveis conceitos:

Aggregate;
Value Object;
Domain Service;
Domain Event.

Mas não crie:

aggregate
factory
specification
domain event
repository

para uma tabela de parametrização com quatro campos.

Persistence

Pode possuir:

EF Core;
Dapper;
MongoDB;
mais de um store.

Mesmo aqui:

polyglot persistence precisa de problema real.

Outbox/Inbox

CONDITIONAL.

Excelente quando:

DB transaction
+
message publication

precisam de consistência.

Desnecessário sem esse problema.

API

Inclui concerns anteriores e maior disciplina de contratos.

API versioning passa a ser mais provável, mas continua CONDITIONAL.

Idempotency:

DEFAULT para comandos financeiros/retryable boundaries quando duplicidade produz impacto relevante.

Testing
unit: mandatory;
integration: mandatory;
architecture: mandatory;
contract: default quando existem consumidores externos;
Testcontainers: default quando dependência real precisa ser testada;
performance/load: conditional;
resilience tests: conditional.
Observability

Aqui distributed tracing passa a ser muito mais relevante.

ILogger: mandatory;
Activity: mandatory;
correlation: mandatory;
métricas técnicas e de negócio críticas: default;
OpenTelemetry: tecnicamente default, corp validation;
Dynatrace compatibility: mandatory;
Elastic compatibility: conditional/platform.
Resilience

Timeout sempre definido em chamadas remotas.

Retry condicionado à semântica.

Circuit Breaker para downstream instável/impactante.

Bulkhead apenas quando isolamento de recursos é necessário.

Hedging excepcional.

Messaging/background

Kafka pode ser uma capability natural nesse profile, mas ainda CONDITIONAL.

RabbitMQ não ganha preferência apenas por ergonomia .NET.

Consumer precisa considerar:

at-least-once;
duplicate processing;
ordering;
retry;
DLQ;
poison messages;
idempotency;
observability.
Financial domain

Advanced é onde entram com maior frequência:

explicit monetary model;
idempotency;
reconciliation;
immutable audit records;
temporal semantics;
event ordering;
duplicate detection;
concurrency control;
domain invariants;
failure recovery.

7. Comparative Matrix
| Concern                | Essential                        | Standard                       | Advanced                               |
| ---------------------- | -------------------------------- | ------------------------------ | -------------------------------------- |
| Production projects    | 1                                | ~3                             | 4+ conditional                         |
| Architecture           | Feature-oriented single assembly | Core + Infrastructure boundary | Explicit Application/Domain boundaries |
| Domain model           | Simple                           | DEFAULT                        | Rich when justified                    |
| Application layer      | In-process feature/use cases     | Core                           | Dedicated Application                  |
| CQRS                   | EXCLUDED default                 | CONDITIONAL                    | CONDITIONAL                            |
| MediatR                | EXCLUDED default                 | OPT-IN                         | OPT-IN                                 |
| Validation             | MANDATORY concept                | MANDATORY                      | MANDATORY                              |
| FluentValidation       | OPT-IN                           | DEFAULT candidate              | DEFAULT candidate                      |
| EF Core                | CONDITIONAL                      | CONDITIONAL/likely common      | CONDITIONAL                            |
| Dapper                 | CONDITIONAL                      | CONDITIONAL                    | CONDITIONAL                            |
| MongoDB                | OPT-IN                           | CONDITIONAL                    | CONDITIONAL                            |
| Repository             | EXCLUDED default                 | CONDITIONAL                    | CONDITIONAL                            |
| UoW                    | EXCLUDED default                 | CONDITIONAL                    | CONDITIONAL                            |
| ProblemDetails         | MANDATORY API                    | MANDATORY                      | MANDATORY                              |
| Unit tests             | MANDATORY                        | MANDATORY                      | MANDATORY                              |
| Integration tests      | DEFAULT                          | MANDATORY                      | MANDATORY                              |
| Architecture tests     | EXCLUDED                         | DEFAULT                        | MANDATORY                              |
| Testcontainers         | OPT-IN                           | CONDITIONAL                    | DEFAULT where useful                   |
| Structured logging     | MANDATORY                        | MANDATORY                      | MANDATORY                              |
| Distributed tracing    | Basic                            | DEFAULT                        | Strong DEFAULT                         |
| Resilience             | CONDITIONAL                      | DEFAULT for remote boundaries  | Structured/CONDITIONAL                 |
| Messaging              | Usually absent                   | CONDITIONAL                    | CONDITIONAL                            |
| Background             | CONDITIONAL                      | CONDITIONAL                    | CONDITIONAL                            |
| Redis                  | OPT-IN                           | CONDITIONAL                    | CONDITIONAL                            |
| Kafka                  | OPT-IN                           | CONDITIONAL                    | CONDITIONAL                            |
| API Gateway            | PLATFORM                         | PLATFORM/CONDITIONAL           | PLATFORM/CONDITIONAL                   |
| Security               | MANDATORY principles             | MANDATORY                      | MANDATORY                              |
| Financial concerns     | contextual                       | stronger                       | often central                          |
| IIS compatibility      | MANDATORY today                  | MANDATORY                      | MANDATORY                              |
| AKS portability        | DEFAULT                          | DEFAULT                        | MANDATORY architectural property       |
| Cloud coupling in Core | EXCLUDED                         | EXCLUDED                       | EXCLUDED                               |


8. Capability Model
Baseline

Shared engineering properties:

DI;
configuration;
package governance;
tests;
logging abstraction;
security;
errors;
validation;
async/cancellation;
nullable;
no hidden global state.
Default

Depending on archetype:

API:

Controllers;
ProblemDetails;
OpenAPI;
Health Checks;
integration testing.

Worker:

graceful cancellation;
health/operational status;
structured logging.

Library:

no hosting assumptions;
API compatibility discipline.
Conditional
persistence;
versioning;
domain layer;
tracing;
resilience;
architecture testing;
idempotency.
Opt-in
Redis;
Kafka;
MongoDB;
RabbitMQ;
Hangfire;
Outbox;
distributed cache;
special gateways.
Excluded from generic service template
embedded Ocelot gateway by default;
embedded Kong;
Consul by default;
custom CI/CD;
custom secrets infrastructure;
custom artifact publishing.
Corporate/platform-owned
Bex;
reusable workflows;
Sonar;
Fortify;
Mend;
Gitleaks;
Nexus;
coverage collection;
deployment;
Key Vault interaction/tokenization;
infrastructure provisioning.
9. Promotion Criteria
Essential → Standard

Promote when at least one architectural boundary begins to carry independent complexity.

Strong signals:

domain rules spread across features;
persistence details begin contaminating use cases;
multiple external integrations;
significant lifecycle;
different teams contribute;
growing test setup;
business invariants need isolation;
frequent changes produce cross-feature impact.

A single Kafka topic or Redis cache is not sufficient sozinho.

Standard → Advanced

Promote when isolation between Application and Domain becomes materially valuable.

Strong signals:

complex invariants;
multiple aggregates/workflows;
significant concurrency;
multiple persistence technologies;
distributed consistency;
events become core architecture;
independent worker hosts;
strict auditability;
complex retry/idempotency;
high operational criticality;
many external boundaries;
architecture drift needs compile-time enforcement.

Não use:

> 10 controllers = Advanced

ou qualquer threshold artificial semelhante.

10. Corporate Compatibility Review
Bex

CORPORATE CONSTRAINT

Template deve ser gerável dentro dos parâmetros fornecidos pelo Bex.

Não hardcode .NET 8 como verdade arquitetural eterna.

GitHub / reusable workflows

CORPORATE CONSTRAINT

Template não deve criar pipeline alternativo.

Sonar

CORPORATE CONSTRAINT

New Code:

coverage ≥90%;
duplication ≤3%;
Maintainability A;
Reliability A;
Hotspots 100%;
Security A.

Overall:

coverage ≥90%;
ratings correspondentes;
não assumir 3% de duplication Overall.

A instrução original exige justamente considerar fortemente essa cobertura sem criar testes artificiais.

packages.lock.json

OBSERVED PLATFORM BEHAVIOR

Tratar como requisito do template até validação contrária.

Nexus

CORPORATE CONSTRAINT

Dependências precisam ser consumíveis/publicáveis conforme feeds corporativos.

ARTIFACT_TYPE

CORPORATE CONSTRAINT

Reforça a separação Archetype/Profile.

lib e app são preocupações diferentes.

IIS / WinRM

CURRENT PLATFORM CONSTRAINT

Host atual precisa funcionar.

Não vazar isso para Core.

AKS

CORPORATE CAPABILITY

Arquitetura deve permitir evolução sem reescrita.

Key Vault

PLATFORM-OWNED

Template deve expor configuração, não reinventar secret retrieval.

Dynatrace / Elastic

CORPORATE CAPABILITY

Aplicação precisa ser observável sem depender diretamente de SDK específico no business code.

APIM / Axway

CORPORATE CAPABILITY

Não embedar gateway dentro de todo serviço.

11. FinTrack Bias Review

O FinTrack é útil, mas eu deliberadamente não herdaria automaticamente:

CQRS/MediatR

Boa organização no FinTrack.

Não justifica Standard obrigatório.

Repository/UoW

Úteis em determinados models.

Não devem existir apenas porque o FinTrack possui.

Configuration como projeto separado

Eu não colocaria na baseline.

Composition root deveria normalmente continuar no host e cada assembly registrar suas próprias dependências.

Serilog

FinTrack prova structured logging.

Não prova que Serilog seja a resposta corporativa.

EF Core

É uma excelente opção.

Não é argumento contra Dapper/Mongo.

Automatic migrations no startup

Conveniente em desenvolvimento.

Eu evitaria tornar isso padrão de produção.

Messages / BackgroundJobs

O próprio FinTrack ainda possui partes scaffolded.

Não devem virar estrutura obrigatória.

Clean Architecture completa

Seria excessiva para Essential.

O prompt explicitamente determina que a presença de boas práticas conhecidas não deve justificar introduzi-las sem necessidade.

12. Boletron Lessons Review
| Legacy symptom            | Root cause                 | Princípio                                 |
| ------------------------- | -------------------------- | ----------------------------------------- |
| UI acessando DB           | boundaries permeáveis      | I/O não parte da presentation             |
| Business conhece WinForms | framework coupling         | Core independente do host                 |
| God Helpers               | baixa coesão               | componentes pequenos por responsabilidade |
| mutable globals           | hidden coupling            | explicit dependencies/scopes              |
| SQL concatenado           | segurança/manutenção       | parameterized SQL                         |
| config comentada          | environment coupling       | externalized configuration                |
| secrets históricos        | secret handling inadequado | platform secret management                |
| DLL manual                | dependency drift           | package management/Nexus                  |
| ausência de testes        | pouca testabilidade        | testing baseline                          |
| code-behind gigante       | responsabilidade misturada | thin boundary + use cases                 |


Mas eu não concluiria:

“static é proibido”;
“stored procedure é proibida”;
“ADO.NET é proibido”;
“WinForms implica código ruim”;
“todo sistema precisa Clean Architecture”.

O problema é o uso e o acoplamento, não a existência da tecnologia.

13. Corporate Validation Required

Eu separaria explicitamente adoção arquitetural de homologação de package.

Prioridade alta de validação
framework de testes;
FluentValidation;
EF Core packages, se ainda não catalogados;
MongoDB driver;
Kafka client recomendado;
Redis client;
Microsoft.Extensions.Http.Resilience;
OpenTelemetry packages;
architecture testing library.
Validação antes de qualquer uso oficial
RabbitMQ client/ecossistema;
Hangfire;
Consul;
Ocelot;
Kong;
Polly standalone quando Microsoft resilience abstraction for suficiente.

Particularmente:

eu não colocaria Consul, Ocelot, Kong ou Hangfire no primeiro release da baseline apenas para mostrar sofisticação.

14. Risks
R1 — Advanced by Default

É provavelmente o maior risco.

Se Advanced possuir:
DDD
CQRS
MediatR
Kafka
Redis
Outbox
OpenTelemetry
Polly
Mongo
Architecture tests

a tendência será:

“vamos usar o completo”.

Isso produz exatamente o overengineering que a iniciativa nasceu para evitar.

Custos
cognitive load;
onboarding;
mais falhas possíveis;
mais dependencies;
mais configuration;
mais testing;
mais observability;
maior manutenção;
abstrações falsas.

R2 — Essential Too Simple

O oposto também é perigoso.

Essential não deve significar:

Controller
→ DbContext
→ return 200

sem:

errors;
validation;
tests;
logging;
security;
configuration.

Ele deve ser pequeno arquiteturalmente, não amador.

R3 — Capability Explosion

Se houver 30 switches:

--ef
--dapper
--mongo
--redis
--kafka
--rabbit
--cqrs
...

a própria plataforma vira um produto complexo.

Começar com um catálogo pequeno.

R4 — Template Drift

Razão principal para não manter 3 codebases independentes.

R5 — Coverage Gaming

90% pode provocar:

testes sem assertions relevantes;
getters testados;
exclusões artificiais;
mocks excessivos.

A baseline deve tratar coverage como guardrail, não objetivo de negócio.

R6 — Technology Showcase

Existe risco de querer “impressionar” usando tecnologias demais.

A melhor forma de ganhar credibilidade não é mostrar quantidade de ferramentas.

É entregar:

poucas decisões boas, justificadas e operacionais.

R7 — Cloud Premature Abstraction

Criar:

ICloudProvider
IAzureService
IAwsService

sem necessidade seria abstração fictícia.

A portabilidade deve vir principalmente de:

Core sem cloud SDK;
configuration abstraction;
standard telemetry;
externalized state.
R8 — AI Instructions dogmáticas

Instructions não podem transformar sugestões em religião.

Exemplo ruim:

“Toda classe deve ter interface.”

Exemplo bom:

“Crie abstrações somente quando houver substituição, boundary, testability ou policy real.”

15. Recommended Next Step

Minha proposta independente converge para esta direção:

Uma Engineering Baseline compartilhada + Archetypes + Profiles Essential/Standard/Advanced + um catálogo pequeno de Capabilities.

O próximo passo deveria ser confrontar esta proposta independente com o dotnet-engineering-baseline-decision-dossier.md.
Eu produziria então uma tabela de resolução:
| Decision                | Proposta independente                 | Decision Dossier | Convergência | Decisão humana |
| ----------------------- | ------------------------------------- | ---------------- | ------------ | -------------- |
| Template model          | Archetype × Profile × Capability      | ?                | ?            | ?              |
| Essential project model | 1 prod assembly                       | ?                | ?            | ?              |
| Standard                | Api/Core/Infrastructure               | ?                | ?            | ?              |
| Advanced                | Api/Application/Domain/Infrastructure | ?                | ?            | ?              |
| CQRS                    | Conditional                           | ?                | ?            | ?              |
| MediatR                 | Opt-in                                | ?                | ?            | ?              |
| Repository              | Conditional                           | ?                | ?            | ?              |
| UoW                     | Conditional                           | ?                | ?            | ?              |
| Health                  | executable baseline                   | ?                | ?            | ?              |
| Testing                 | baseline                              | ?                | ?            | ?              |
| Telemetry               | interoperable                         | ?                | ?            | ?              |

É nessa comparação que eu espero encontrar as decisões realmente importantes.

Minha maior proposta nova nesta rodada

Eu colocaria sob forte consideração esta diferenciação:
ESSENTIAL
1 ou 2 production assembly

STANDARD
Api + Core + Infrastructure + Configuration (se necessário)

ADVANCED
Api + Application + Domain + Infrastructure + Configuration (se necessário)

Isso dá significado arquitetural real aos profiles sem fazer:

Essential = arquitetura ruim
Standard = Clean Architecture
Advanced = Clean Architecture + todas as libs

O salto passa a ser:

Essential
→ disciplina sem isolamento físico extensivo


Standard
→ isolamento Core/Infrastructure


Advanced
→ isolamento Application/Domain + capacidades distribuídas quando justificadas

Essa, para mim, é uma proposta mais pragmática do que simplesmente copiar a estrutura do FinTrack para Standard e adicionar ainda mais projetos no Advanced.

Conclusão: os três profiles fazem sentido, mas como composições oficiais de uma mesma Engineering Baseline, não como três templates autônomos. Essential deve ser realmente simples; Standard deve ser o golden path provável; Advanced deve adicionar isolamento arquitetural, e não simplesmente tecnologia. Capabilities como Kafka, Redis, MongoDB, CQRS e resilience continuam condicionais em qualquer nível.

Agora o artefato mais valioso para avançarmos é o Decision Dossier: comparando-o com esta proposta independente, conseguimos transformar divergências em decisões humanas explícitas antes de escrever a primeira linha do template físico.
