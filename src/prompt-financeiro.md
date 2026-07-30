A abordagem está certa e é melhor do que tentar desenhar toda a governança antecipadamente. Você transforma o Copilot em uma ferramenta de descoberta antes de transformá-lo em uma ferramenta de execução.

A lógica ideal fica:

Projeto real → evidências → riscos e padrões encontrados → governança mínima → expansão conforme necessidade.

Isso evita criar agentes, skills e documentos baseados apenas no que imaginamos que exista no Boletron.

O que está muito bom na sua proposta

Os dois prompts resolvem bem os principais problemas anteriores:

A primeira leitura é estrutural, não uma tentativa de compreender todo o negócio.
A IA fica proibida de criar arquivos durante o diagnóstico.
Os módulos recebem nível de confiança.
A governança é proposta apenas depois da análise.
O PROGRESS.md global já está explicitamente proibido.
O sistema corporativo continua sendo a fonte oficial de status.
A estrutura começa pequena.
As convenções utilizadas são as nativas do Copilot.

As convenções que você colocou estão corretas para as versões atuais do Visual Studio:

.github/copilot-instructions.md para instruções gerais do repositório.
.github/agents/*.agent.md para custom agents no Visual Studio.
.github/skills/<nome>/SKILL.md para skills reutilizáveis.
.github/instructions/*.instructions.md para instruções específicas por caminho ou tipo de arquivo.
.github/prompts/*.prompt.md para prompts reutilizáveis.
Quatro ajustes que eu faria
1. Exigir evidência com caminho de arquivo

Eu acrescentaria ao primeiro prompt:

Para cada conclusão relevante, informe os arquivos, projetos, namespaces ou símbolos que sustentam a conclusão. Não apresente como fato algo baseado somente em nomenclatura.

Isso é importante porque uma resposta como:

“O projeto Boletron.Business contém as regras de negócio”

pode parecer confiável, mas ter sido inferida apenas pelo nome.

Melhor:

Conclusão: parte das regras de reservas está no projeto X.
Evidências:
- X/Reservas/ReservaService.cs
- Referenciado por Y/Forms/FrmReserva.cs
- Chama Z/Repositories/ReservaRepository.cs
Confiança: média.
2. Não pedir uma “análise detalhada de todo o projeto”

Sua versão corrigida, pedindo primeiro o raio-X estrutural, está muito melhor.

Uma solution legada grande não cabe integralmente no contexto ativo de uma única resposta. Mesmo em agent mode, o Copilot navega e recupera partes relevantes; isso não significa que todo o repositório foi absorvido de uma vez. O agent mode consegue ler código, editar arquivos, executar comandos e iterar sobre erros, mas ainda é importante delimitar o trabalho.

Por isso, evite concluir depois da primeira resposta:

“O Copilot analisou o Boletron inteiro.”

O correto seria:

“O Copilot realizou um levantamento estrutural inicial.”

3. Inserir uma etapa intermediária opcional

Eu não iria necessariamente direto do raio-X estrutural para a governança definitiva.

Depois do Prompt 1, observe o resultado. Caso ele encontre áreas muito diferentes, faça uma análise focalizada antes da governança:

Agora aprofunde somente estes três pontos:

1. Organização das telas WinForms e localização aparente das regras de negócio.
2. Padrão de acesso a dados e uso de stored procedures.
3. Organização das integrações externas.

Continue sem modificar arquivos. Para cada conclusão, mostre evidências e nível de confiança.

Essa etapa é particularmente útil se o primeiro relatório disser coisas como:

“Há vários mecanismos de acesso a dados.”
“As regras parecem estar divididas entre Forms e bibliotecas.”
“Não foi possível identificar claramente os limites dos módulos.”

Nesse caso, sugerir agentes imediatamente ainda seria prematuro.

4. Não tratar agents e skills como obrigatórios

Eu ajustaria este trecho do segundo prompt:

Use as convenções nativas do GitHub Copilot...

Para:

Quando esses artefatos forem justificados, use as convenções nativas do GitHub Copilot...

Porque talvez o primeiro estágio precise apenas de:

.github/
├── copilot-instructions.md
├── instructions/
│   ├── winforms.instructions.md
│   └── data-access.instructions.md
└── prompts/
    ├── analyze-legacy-flow.prompt.md
    └── safe-refactoring.prompt.md

E ainda não precise de nenhum custom agent.

As instruções específicas em .github/instructions/*.instructions.md podem ser aplicadas por glob, enquanto prompts em .github/prompts/*.prompt.md servem para tarefas reutilizáveis. Em muitos casos, isso é mais simples e previsível do que começar criando personas.

Além disso, há requisitos de versão diferentes:

Custom agents no Visual Studio exigem atualmente Visual Studio 2026 18.4 ou posterior.
Agent Skills exigem Visual Studio 2026 18.5 ou posterior.

Portanto, vale confirmar a versão instalada antes de depender desses recursos.

Fluxo que eu recomendaria
Etapa 1 — Raio-X estrutural

Usar seu primeiro prompt revisado.

Resultado esperado:

Mapa da solution.
Tecnologias realmente encontradas.
Dependências.
Módulos aparentes.
Riscos iniciais.
Lacunas.
Etapa 2 — Aprofundamento seletivo

Somente nas áreas que realmente influenciam a governança:

WinForms e code-behind.
Acesso a banco.
Integrações.
Build e testes.
Distribuição das regras de negócio.
Etapa 3 — Proposta de governança

Usar seu segundo prompt com as restrições fixas.

O Copilot deve apresentar:

Estrutura mínima.
Justificativa para cada arquivo.
Evidências do projeto que justificam cada agente ou skill.
O que será versionado.
O que ficará local.
O que deliberadamente ainda não será criado.
Etapa 4 — Criação dos arquivos

Somente depois da sua revisão:

Crie somente os arquivos aprovados na proposta anterior.

Não crie artefatos adicionais.
Não altere código da aplicação.
Não altere configurações de build.
Não preencha lacunas com hipóteses.
Ao final, liste os arquivos criados e resuma o conteúdo de cada um.
Pequena melhoria no Prompt 2

Eu acrescentaria este critério:

Para cada agente, skill, instruction file ou prompt file proposto, informe:

- Qual problema real encontrado no repositório ele resolve.
- Quais evidências sustentam sua criação.
- Quando será utilizado.
- Por que uma instrução geral não seria suficiente.
- Qual o custo esperado de manutenção.

Não proponha um agente ou skill apenas porque a categoria existe no sistema.

Isso obriga o Copilot a justificar, por exemplo, por que precisa de um database-engineer.agent.md em vez de apenas uma data-access.instructions.md.

Veredito

Eu seguiria essa estratégia. Ela é mais segura, econômica e adequada ao Boletron do que qualquer prompt universal muito detalhado.

Minha única mudança conceitual seria não formular como:

“Analise e gere o prompt ideal.”

Eu formularia como:

“Analise, apresente evidências e proponha a governança mínima adequada.”

O prompt final será apenas um dos artefatos. Dependendo do que o Copilot encontrar, a solução correta pode ser uma combinação de:

copilot-instructions.md
instructions/*.instructions.md
prompts/*.prompt.md
agents/*.agent.md
skills/*/SKILL.md
work-items/

E não necessariamente um grande “prompt mestre”.


Prompt 1 — Raio-X estrutural (revisado)
Você vai fazer um levantamento estrutural inicial do repositório atual (Boletron), uma aplicação monolítica em .NET Framework 4.8 e WinForms que centraliza operações de Renda Fixa, Derivativos, COE, Integrações, Reservas, Tabelas Parametrizáveis, Conciliações, Contratos e integração com a B3.

Isso é um levantamento inicial, não uma análise completa do sistema. Uma solution legada grande não cabe integralmente em uma única resposta, mesmo em agent mode. Não afirme que "analisou o Boletron inteiro" — descreva como "levantamento estrutural inicial" e informe explicitamente quais partes não foram exploradas.

Não analise regra de negócio ainda. Não crie, edite ou sugira criar nenhum arquivo.

Investigue e relate:

1. Estrutura da solution: projetos existentes, tipo de cada projeto (WinForms, Class Library, etc.), referências entre eles.
2. Principais namespaces e diretórios, e o que cada um aparenta ser responsável por fazer.
3. Stack técnica confirmada por evidência real: acesso a dados (ADO.NET, Dapper, EF), forma de acesso ao SQL Server, uso de stored procedures, chamadas HTTP/SOAP, filas, arquivos de configuração relevantes (app.config, transformações, packages.config).
4. Módulos funcionais que você consegue identificar apenas pela estrutura de pastas/projetos/namespaces.
5. Sinais de risco estrutural que já saltam aos olhos nesta primeira leitura (ex: lógica de negócio em code-behind de Form, classes estáticas com estado, SQL dinâmico embutido, ausência de testes) — sem aprofundar, só sinalizar.
6. Lacunas: o que você não conseguiu entender só com esta leitura estrutural, e o que ficou de fora por limitação de escopo desta primeira passada.

Para cada conclusão relevante dos itens 2, 3, 4 e 5, apresente no formato:

- Conclusão:
- Evidências (arquivos, projetos, namespaces ou símbolos concretos que sustentam a conclusão):
- Confiança: baixa (só nomenclatura) / média (confirmado por referências no código) / alta (fluxo completo confirmado).

Não apresente como fato algo baseado apenas em nomenclatura de classe, método, tela ou stored procedure.

Apresente isso como um relatório curto e objetivo. Não proponha estrutura de governança, agentes, skills ou arquivos ainda. Aguarde meu retorno antes de prosseguir.

Prompt 1b — Aprofundamento seletivo (usar só se o relatório 1 vier ambíguo)
Aprofunde somente os pontos abaixo, que ficaram ambíguos ou incompletos no levantamento anterior:

1. [liste aqui os 2-3 pontos específicos que vieram confusos, ex: "organização das telas WinForms e localização aparente das regras de negócio"]
2. [...]
3. [...]

Continue sem modificar arquivos. Para cada conclusão, use o mesmo formato do levantamento anterior: conclusão, evidências concretas, nível de confiança.

Se mesmo aprofundando não for possível esclarecer algum ponto, registre isso como lacuna explícita em vez de arriscar uma conclusão pouco sustentada.

Prompt 2 — Proposta de governança mínima (revisado)
Com base no levantamento estrutural que você já fez do Boletron, proponha agora a governança mínima adequada — não gere um "prompt ideal" nem um pacote completo de antemão. O resultado pode ser tão simples quanto um copilot-instructions.md e dois instructions files, ou pode incluir mais artefatos, dependendo apenas do que as evidências já levantadas sustentam.

Aplique as seguintes restrições, que já são decisões tomadas, não sugestões em aberto:

1. Nada de arquivo único de progresso global. Progresso é registrado por work item (incidente, projeto ou chamado técnico), um arquivo por item, usando o identificador oficial do sistema de gestão quando existir, ou um nome provisório claro quando não existir.

2. Use as convenções nativas do GitHub Copilot no Visual Studio 2026, numa hierarquia de menor para maior custo de manutenção — proponha o nível mais simples que resolve o problema, só subindo de nível quando justificado:
   - `.github/copilot-instructions.md` — contexto estável e restrições permanentes do projeto.
   - `.github/instructions/*.instructions.md` — regras aplicáveis a um tipo de arquivo ou área específica (ex: acesso a dados, WinForms).
   - `.github/prompts/*.prompt.md` — prompts reutilizáveis para tarefas recorrentes (ex: mapear um fluxo, criar teste de caracterização).
   - `.github/agents/*.agent.md` e `.github/skills/<nome>/SKILL.md` — só quando uma persona especializada ou um guia extenso realmente for necessário, e não simplesmente porque a categoria existe.

3. Não crie de uma vez todos os documentos, instructions, prompts, agents ou skills possíveis. Proponha só o que o levantamento estrutural já sustenta com evidência. Se algo ficou como lacuna no levantamento, não crie estrutura de governança em cima disso ainda.

4. Para cada agent ou skill proposto (não para instructions/prompts, que são artefatos baratos), justifique:
   - Qual problema real encontrado no repositório ele resolve.
   - Quais evidências do levantamento sustentam sua criação.
   - Por que uma instruction ou prompt file não seria suficiente.

5. Todo documento deve separar fato observado de hipótese, e não deve conter regra de negócio inventada a partir de nome de classe, método, tela ou stored procedure.

6. Não altere código, não crie stored procedures fictícias, não presuma que algo não utilizado pode ser removido.

Antes de criar qualquer arquivo, apresente a estrutura proposta: quais arquivos, o que cada um conterá, o que será versionado no Git e o que ficará local/ignorado, e o que você deliberadamente decidiu não criar ainda por falta de evidência. Aguarde minha aprovação explícita.

Prompt 3 — Criação (só depois da sua aprovação)
Crie somente os arquivos aprovados na proposta anterior, exatamente como descritos.

Não crie artefatos adicionais além dos aprovados.
Não altere código da aplicação.
Não altere configurações de build.
Não preencha lacunas materiais com hipóteses. Caso falte uma evidência que altere o conteúdo, o escopo ou a validade de algum arquivo, interrompa a criação desse arquivo e informe o que precisa ser confirmado. Para detalhes menores, utilize uma marcação explícita como A confirmar, sem inventar informações.

Ao final, liste os arquivos criados e resuma o conteúdo de cada um.
