Vamos fazer duas coisas nesta sessão, em sequência.

## Parte 1 — Criar instruction para uso do mssql

Crie o arquivo `.github/instructions/mssql-dev.instructions.md` com o conteúdo abaixo (adapte a formatação ao padrão dos demais arquivos em `.github/instructions/`, sem alterar o sentido):

---
applyTo: "**"
---

# Uso do mssql (execução direta de SQL via extensão)

- Conexão restrita ao perfil de desenvolvimento, confirmado como ambiente seguro para leitura e escrita controlada. Ainda assim, sempre informar qual perfil será usado e aguardar confirmação antes de conectar — mesmo havendo um único perfil disponível.
- Considerar proibida, nesta e em futuras sessões de investigação/mapeamento, qualquer operação que altere estado, salvo pedido explícito e pontual: INSERT, UPDATE, DELETE, MERGE, TRUNCATE, EXEC/EXECUTE, CREATE, ALTER, DROP, GRANT, REVOKE, DENY, DBCC de alteração, chamada a procedures, comandos de controle transacional para testes.
- Não usar SELECT *, não fazer amostragens amplas, não consultar dados pessoais/financeiros identificáveis sem necessidade explícita da tarefa.
- Antes de qualquer execução no mssql, mostrar a query pretendida e aguardar aprovação — exceto consultas triviais de metadado (listar databases, schemas, views, functions).
- Nunca expor senha, token, string de conexão completa ou qualquer segredo, mesmo que a ferramenta os retorne.
- Distinguir sempre três fontes possíveis, sem tratá-las como equivalentes: (a) chamada observada no código C#; (b) definição encontrada em script versionado em scripts/; (c) definição encontrada no banco conectado. Divergência entre elas deve ser registrada, não resolvida por suposição — o banco conectado é a fonte mais confiável do estado atual.
- Ao documentar em docs/knowledge/ ou docs/workitems/, registrar definição de procedures e estrutura de tabelas livremente. Não copiar dados de linha reais para documentação versionada, mesmo em dev — descrever estrutura, não conteúdo de linha.
- Não inferir regra de negócio além do que o T-SQL mostra explicitamente.

Apresente o conteúdo do arquivo antes de criar, para minha aprovação.

## Parte 2 — Descoberta e planejamento do piloto (não executar investigação profunda ainda)

### Como funciona a extensão mssql neste ambiente

Você tem acesso a ferramentas de uma extensão SQL Server (mssql) no VS Code, que funcionam assim:

- Uma ferramenta lista os perfis de conexão já salvos (host, usuário, tipo de autenticação) — não credenciais.
- `mssql_connect`, usando um profileId ou serverName, conecta e retorna um `connectionId` (UUID). Esse `connectionId` deve ser reaproveitado em todas as chamadas seguintes dentro desta sessão — não reconecte a cada operação.
- `mssql_list_databases`, `mssql_change_database`, `mssql_list_views`, `mssql_list_schemas`, `mssql_list_functions` servem para exploração de metadados após a conexão.
- `mssql_run_query` executa qualquer SQL na conexão ativa — SELECT, INSERT, UPDATE, DELETE, DDL. Não há proteção automática contra escrita nesta ferramenta; a responsabilidade de validar cada comando antes de rodar é sua e minha, conforme as regras em mssql-dev.instructions.md.

### Contexto adicional — convenção docs/knowledge/

Existe uma convenção já decidida (fora desta sessão) para uma pasta docs/knowledge/, que vai reunir "Atlas" por módulo de negócio (ex: docs/knowledge/Renda-Fixa.md): telas → fluxo principal → classes de Negócio → AD/procedures → integrações → riscos, com evidência e nível de confiança no mesmo padrão do levantamento estrutural. Diferente de docs/discovery/ (snapshot histórico, nunca reaberto), docs/knowledge/ é vivo — atualizado ao longo do tempo — então cada seção deve futuramente carregar uma data de "verificado em" junto da evidência, para quem ler saber se o conteúdo ainda é confiável.

Nesta rodada você não vai criar nada em docs/knowledge/ ainda — é só contexto para que o plano da seção 3 ("Plano da próxima rodada") já saia compatível com esse formato, evitando que a próxima rodada tenha que reformular o que for gerado aqui.

### Objetivo desta rodada

Identificar um fluxo funcional relevante para servir de piloto de mapeamento completo:

WinForms → evento de entrada → camada de Negócio → camada de acesso a dados → stored procedure/SQL → objetos relacionados no SQL Server → estrutura funcional dos dados.

O resultado deve me permitir escolher conscientemente qual fluxo aprofundar na próxima rodada.

### Restrições desta etapa

- Não altere código, scripts, banco de dados ou documentação.
- Não crie agents, skills, prompts, work items ou documentos além do arquivo de instruction da Parte 1.
- Aplique .github/copilot-instructions.md e as instructions especializadas compatíveis com os arquivos analisados. Os prompts existentes (mapear-fluxo, mapear-impacto, registrar-progresso) servem só como referência de workflow, não para executar agora.
- Preserve a separação entre fato observado, hipótese e item não confirmado.
- Não infira comportamento pelo nome de classe, método, tela, tabela ou procedure.
- Não transforme convenções legadas em padrão recomendado.
- Não faça varredura completa de scripts/ — consulte só scripts relacionados a objetos concretamente encontrados no fluxo C#.
- Não conecte ao SQL Server sem confirmação explícita minha do perfil a usar.
- Não execute nenhuma consulta de dados nesta rodada — só metadados e definição de objetos.

### 1. Levantamento no código C#

Identifique até 5 fluxos candidatos, priorizando os que tenham: entrada WinForms clara, passagem observável por Negócio e AD/Db, chamada concreta a stored procedure/SQL, relevância funcional aparente, escopo viável (não excessivamente amplo).

Para cada candidato, apresente: nome descritivo provisório; Form e evento/método inicial (arquivo e símbolo); sequência C# confirmada até a camada de banco; classes de Negócio e AD/Db envolvidas; procedures/comandos SQL identificados; integrações externas aparentes; por que é bom candidato; riscos/limitações da investigação; nível de confiança (baixa/média/alta).

### 2. Descoberta controlada dos perfis mssql

Liste os perfis de conexão disponíveis (nome, servidor se exposto de forma segura, tipo de autenticação, database padrão) sem expor credenciais. Não conecte ainda, mesmo havendo um único perfil — informe qual pretende usar e aguarde minha confirmação.

### 3. Plano da próxima rodada

Para o candidato recomendado, proponha plano com:

**Etapa A — Código C#:** Form/evento de entrada, sequência de métodos, classes Negócio/AD, parâmetros enviados, tratamento de retorno/erro.

**Etapa B — Scripts versionados:** o que seria localizado em scripts/, o que seria comparado, limitações dessa fonte.

**Etapa C — SQL Server implantado:** database a confirmar, procedure principal, parâmetros reais, definição do objeto, views/functions/synonyms/tabelas relacionadas, dependências que podem ficar ocultas por SQL dinâmico.

**Etapa D — Amostragem de dados (ainda não executar):** quais dúvidas metadados não resolvem, quais consultas agregadas poderiam esclarecer, quais colunas seriam acessadas, risco de exposição, limites/filtros recomendados.

### Formato da resposta

1. Governança e restrições consideradas
2. Perfis mssql encontrados
3. Fluxos candidatos
4. Comparação entre os candidatos
5. Fluxo recomendado para o piloto
6. Evidências que sustentam a recomendação
7. Plano detalhado da próxima rodada
8. Confirmações necessárias antes de continuar
9. Itens não confirmados
