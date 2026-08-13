A execução anterior foi interrompida por `net::ERR_HTTP2_PROTOCOL_ERROR`
durante a criação do artefato.

NÃO repita a geração integral e NÃO reinicie a análise.

As fontes obrigatórias já foram carregadas integralmente nesta sessão.
Reabra alguma fonte somente se precisar confirmar uma evidência específica.

O arquivo de saída já existe:

outputs/dotnet-engineering-baseline-decision-dossier.md

A partir de agora, construiremos o dossier incrementalmente para evitar uma
operação de escrita excessivamente grande.

Nesta etapa escreva APENAS as seções 1 a 5 definidas em:

prompts/dotnet-engineering-baseline.prompt.md

Ou seja:

1. Executive Summary
2. Sources and Decision Method
3. Corporate Constraints
4. Engineering Principles
5. Recommended Template Model

Regras:

- preserve integralmente todas as regras e critérios do prompt principal;
- não reduza profundidade por estarmos dividindo a escrita;
- não escreva antecipadamente as seções 6–23;
- não altere nenhuma fonte de entrada;
- não altere o prompt;
- não crie outros arquivos;
- não gere código;
- não reescreva conteúdo já persistido, caso exista;
- use as evidências já carregadas nesta sessão;
- marque claramente recomendações de engenharia versus constraints corporativas.

Ao concluir a seção 5, PARE.

Responda apenas:
1. seções persistidas;
2. intervalo aproximado de linhas escrito;
3. confirmação de que o arquivo ficou íntegro até a seção 5.



----------------------------DPS DPS DPS----------------------------

Continue o mesmo artefato.

NÃO reescreva, resuma ou reorganize as seções 1–5 já concluídas.

Agora escreva APENAS as seções 6 a 10 do prompt principal:

6. Archetypes
7. Complexity Profiles
8. Capability Catalog
9. Architecture Decision Matrix
10. Baseline Mandatory Across Profiles

Mantenha exatamente o mesmo rigor de evidência, classificação, trade-offs
e distinção entre Corporate Constraint e Engineering Recommendation.

Ao concluir a seção 10, PARE.



----------------------------DPS DPS DPS----------------------------

11–15:
API Engineering
Persistence and Data
Distributed Systems Capabilities
Observability and Operations
Testing Strategy


----------------------------DPS DPS DPS----------------------------

16–20:
Code Quality and Governance
Financial Domain Engineering
Anti-pattern Prevention
AI Engineering Instructions Strategy
Deployment and Portability



---------------------------DPS DPS DPS----------------------------

21–23:
Decisions Requiring Corporate Validation
Open Decisions
Proposed Roadmap



---------------------------DPS DPS DPS----------------------------

Agora NÃO altere o arquivo.

Leia integralmente:
outputs/dotnet-engineering-baseline-decision-dossier.md

Execute a auto-auditoria definida no prompt principal.

Retorne somente:

- se todas as 23 seções estão presentes;
- se alguma seção parece truncada;
- inconsistências encontradas;
- decisões sem classificação;
- eventual confusão entre Corporate Constraint e Engineering Recommendation;
- eventual tratamento indevido do FinTrack como golden path;
- eventual tratamento indevido do Boletron como referência;
- divergências entre New Code e Overall Code do Sonar;
- tecnologias não homologadas apresentadas indevidamente como padrão;
- demais violações das regras do prompt.

NÃO faça alterações ainda.
