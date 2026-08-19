Instructions não podem transformar sugestões em religião.
Exemplo ruim:
“Toda classe deve ter interface.”
Exemplo bom:
“Crie abstrações somente quando houver substituição, boundary, testability ou policy real.”

.github/instructions/
├── dotnet-engineering.instructions.md
├── dotnet-architecture.instructions.md
├── dotnet-clean-code.instructions.md
├── dotnet-testing.instructions.md
├── dotnet-api.instructions.md
├── dotnet-data.instructions.md
├── dotnet-observability.instructions.md
├── dotnet-refactoring.instructions.md
└── financial-domain.instructions.md

Poderíamos acabar com um pacote de governança tipo:

.github/instructions/
├── dotnet-clean-code.instructions.md
├── dotnet-architecture.instructions.md
├── dotnet-testing.instructions.md
├── dotnet-persistence.instructions.md
├── dotnet-api.instructions.md
├── dotnet-observability.instructions.md
├── dotnet-security.instructions.md
├── dotnet-refactoring.instructions.md
└── financial-domain.instructions.md

Eu incluiria temas como:
Clean Code
intenção;
nomes;
small methods;
coesão;
side effects;
complexity.
SOLID
Mas com pragmatismo. Nada de criar interface para cada classe só para “cumprir DIP”.
Design Patterns
Usar quando resolvem um problema, não para colecionar patterns.
Code Smells
God Class;
Long Method;
Feature Envy;
Shotgun Surgery;
Primitive Obsession;
Duplicate Code;
Global State;
Anemic abstractions;
Service Locator;
indiscriminate static helpers.
Anti-patterns
E aqui o Boletron dá exemplos reais que podem inspirar regras sem citar nominalmente o legado:
UI → DB;
business → UI framework;
static mutable state;
giant helpers;
environment config in source;
secrets near code.
Refactoring
comportamento preservado;
testes antes de mudança estrutural;
incremental;
evitar big-bang.
Pensamento crítico
Essa é uma excelente ⁠instruction para AI Agent:
Não introduzir abstração, biblioteca ou pattern sem explicar o problema concreto que resolve.
Pensamento financeiro
Eu refinaria para “Financial Domain Engineering”.
Por exemplo:
precisão monetária;
evitar double para valores financeiros;
currency explícita;
rounding explícito;
timezone/data de negociação;
idempotência;
auditabilidade;
reconciliação;
rastreabilidade;
ordenação;
consistência;
duplicidade de eventos;
invariantes;
não mascarar falhas silenciosamente.
Isso pode ser extremamente valioso para Tesouraria/DAC.

DS/DAC .NET Engineering Platform
Com quatro componentes:

1. Engineering Baseline
   └── princípios e decisões

2. Service Templates
   ├── Essential
   ├── Standard
   └── Advanced

3. Capability Modules
   ├── EF Core
   ├── Dapper
   ├── MongoDB
   ├── Redis
   ├── Kafka
   ├── Resilience
   ├── Worker
   ├── Observability
   └── ...

4. AI Engineering Instructions
   ├── Clean Code
   ├── SOLID
   ├── Testing
   ├── Architecture
   ├── Refactoring
   ├── Security
   └── Financial Domain

Isso é muito mais poderoso.
E, principalmente:
Essential / Standard / Advanced não precisam ser três mundos isolados.
Eles podem ser três composições oficiais de uma mesma baseline + capability modules.
Essa ideia agora me parece ainda mais apropriada do que quando começamos.