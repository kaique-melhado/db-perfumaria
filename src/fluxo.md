Cenário 1 — Investigar e corrigir um incidente em uma tela WinForms
Situação

Chega um incidente como:

“Ao confirmar determinada operação, a tela apresenta erro ou não conclui o processamento.”

Você conhece a tela ou consegue reproduzir o problema, mas ainda não sabe:

onde está a regra;
quais camadas são percorridas;
qual classe de acesso a dados é chamada;
qual stored procedure participa;
quais outras telas ou processos podem ser afetados.

O objetivo inicial não é pedir ao Copilot para “corrigir o bug”. Primeiro, use a estrutura criada para mapear, avaliar impacto e só então alterar.

Etapa 1 — Criar o work item

Use o prompt registrar-progresso para criar o contexto isolado da demanda.

No Copilot Chat:

#prompt:registrar-progresso

Crie um novo work item para o incidente INC-12345.

Título: Erro ao confirmar operação na tela <NOME_DA_TELA>

Contexto conhecido:
- O erro ocorre ao acionar <BOTÃO_OU_AÇÃO>.
- O comportamento esperado é <COMPORTAMENTO_ESPERADO>.
- O comportamento observado é <COMPORTAMENTO_ATUAL>.
- Ainda não sabemos em qual camada está a causa.
- Nenhum código deve ser alterado nesta etapa.

Registre apenas as informações fornecidas. Marque o restante como “não foi possível confirmar”.

O resultado deve ser algo como:

docs/workitems/INC-12345-erro-confirmar-operacao.md
Benefício

O Copilot passa a ter um local específico para registrar:

fatos;
hipóteses;
decisões;
tentativas;
arquivos alterados;
pendências.

Sem misturar esse incidente com outras frentes.

Etapa 2 — Identificar o ponto de partida exato

Antes de mapear, localize:

nome do Form;
evento do botão;
método chamado;
mensagem ou stack trace;
condição necessária para reproduzir.

Caso você só saiba o nome visível da tela, diga isso claramente:

Localize no projeto a tela cuja interface exibe o título "<TÍTULO_VISÍVEL>".

Não altere código.

Retorne:
- arquivo provável;
- classe do Form;
- evidências usadas;
- nível de confiança;
- outras telas com nome semelhante.

Não prossiga automaticamente com a primeira correspondência se houver mais de uma tela parecida.

Etapa 3 — Mapear o fluxo de execução

Depois de confirmar o Form e o evento, execute:

#prompt:mapear-fluxo

Ponto de partida:
- Form: <FORM>
- Evento ou método: <MÉTODO>
- Ação funcional: confirmar a operação

Rastreie somente o fluxo relacionado a essa ação.

Não altere código.

Registre:
- Form e evento inicial;
- chamadas à camada de Negócio;
- chamadas à camada Db;
- classe AD envolvida;
- stored procedures invocadas;
- parâmetros observáveis no C#;
- integrações externas atingidas;
- desvios da convenção de camadas;
- fatos, hipóteses e itens não confirmados.

Não analise a pasta scripts/ nesta etapa.
Resultado esperado

Algo semelhante a:

FrmOperacao.btnConfirmar_Click
    ↓
NEOperacao.Confirmar
    ↓
ADOperacao.Gravar
    ↓
SP_OPERACAO_CONFIRMAR
    ↓
Integração externa X

Cada passo deve vir acompanhado de arquivo e símbolo concreto.

Etapa 4 — Relacionar o fluxo ao erro

Agora forneça ao Copilot o erro real:

Com base no fluxo mapeado, investigue onde este erro pode ser originado:

Mensagem:
<ERRO>

Stack trace:
<STACK_TRACE, SEM DADOS SENSÍVEIS>

Condição de reprodução:
<CONDIÇÃO>

Não corrija ainda.

Para cada possível origem, informe:
- arquivo e símbolo;
- evidência observada;
- por que pode produzir esse erro;
- confiança baixa, média ou alta;
- o que ainda precisa ser confirmado.

Aqui o Copilot deve produzir hipóteses testáveis, não uma correção automática.

Exemplo:

Hipótese 1
Arquivo: ADOperacao.cs
Símbolo: Gravar(...)
Evidência: parâmetro X pode ser enviado como null.
Confiança: média.

Confirmação necessária:
Verificar o valor do parâmetro antes da chamada.
Etapa 5 — Analisar o impacto antes de alterar

Quando houver um provável alvo, use:

#prompt:mapear-impacto

Alvo:
- Arquivo: <ARQUIVO>
- Símbolo: <MÉTODO_OU_CLASSE>

Objetivo:
Avaliar o impacto potencial de uma alteração para corrigir o incidente INC-12345.

Não altere código.

Identifique:
- quem chama diretamente esse símbolo;
- dependentes indiretos;
- Forms afetados;
- classes de Negócio e Db relacionadas;
- stored procedures relacionadas;
- projetos externos à solution que possam consumir o alvo;
- variantes OLD, NEW ou duplicadas;
- estado global envolvido;
- riscos por ausência de testes;
- fatos, hipóteses e itens não confirmados.
Benefício

Você evita corrigir um problema em um método compartilhado e quebrar:

outro módulo;
uma rotina batch;
uma tela antiga;
uma integração fora da solution;
uma variante paralela do fluxo.
Etapa 6 — Decidir se os scripts SQL precisam ser analisados

Se o problema aparentar estar no C#, continue sem abrir scripts/.

Caso a evidência aponte para o banco, faça uma solicitação explícita:

A investigação do INC-12345 chegou à stored procedure <NOME_DA_SP>.

Nesta etapa, está autorizada a análise da pasta scripts/ somente para:

- localizar o script correspondente;
- identificar tabelas, views, functions e procedures chamadas por ela;
- verificar validações e condições relacionadas ao erro;
- comparar os parâmetros esperados pela procedure com os enviados pelo C#.

Não analise outros objetos não relacionados.
Não altere scripts.
Não proponha mudança de banco ainda.
Separe fatos, hipóteses e itens não confirmados.

Isso respeita a regra criada: scripts/ não é proibida, mas só entra quando a tarefa exige explicitamente análise de banco.

Etapa 7 — Pedir um plano de correção mínimo

Depois de confirmar a causa:

A causa do INC-12345 foi confirmada em:

- Arquivo/símbolo: <ALVO>
- Evidência: <EVIDÊNCIA>
- Comportamento esperado: <ESPERADO>
- Comportamento atual: <ATUAL>

Proponha uma correção mínima e localizada.

Restrições:
- não fazer modernização paralela;
- não alterar framework ou dependências;
- não refatorar classes inteiras;
- não corrigir outros débitos encontrados;
- não modificar stored procedures sem autorização;
- preservar contratos existentes;
- não editar arquivos Designer manualmente.

Antes de alterar, apresente:
1. arquivos que serão modificados;
2. mudança proposta;
3. riscos;
4. forma de validação;
5. comportamento que deve permanecer inalterado.

Aguarde minha aprovação.

Essa trava é importante: mesmo tendo encontrado a causa, o Copilot ainda deve apresentar o plano antes de editar.

Etapa 8 — Autorizar a implementação

Depois de revisar o plano:

Plano aprovado.

Implemente somente a correção descrita.

Não realize refatorações adicionais.
Não altere arquivos fora do escopo aprovado.
Preserve o padrão já utilizado no arquivo.
Ao terminar:
- apresente o diff lógico;
- liste os arquivos alterados;
- informe o que foi validado;
- informe o que não pôde ser validado;
- não marque o incidente como concluído sem minha confirmação.
Etapa 9 — Atualizar o work item

Após testar:

#prompt:registrar-progresso

Atualize o work item INC-12345 com:

- causa confirmada;
- evidências;
- decisão tomada;
- arquivos efetivamente alterados;
- testes ou validações executados;
- resultado obtido;
- limitações da validação;
- pendências restantes.

Não apague o histórico anterior.
Caso alguma hipótese tenha sido refutada, mantenha-a no histórico e marque-a como revisada.
Status atual: <EM VALIDAÇÃO ou CONCLUÍDO>.
Fluxo resumido
Incidente
   ↓
Criar work item
   ↓
Localizar Form/evento
   ↓
#prompt:mapear-fluxo
   ↓
Investigar erro
   ↓
#prompt:mapear-impacto
   ↓
Analisar scripts/, somente se necessário
   ↓
Propor correção mínima
   ↓
Aprovação humana
   ↓
Implementar
   ↓
Validar
   ↓
#prompt:registrar-progresso
Ganho prático

Sem essa estrutura, o pedido normalmente seria:

“Corrija o erro desta tela.”

Com a governança criada, o Copilot passa a trabalhar assim:

“Localize, prove o fluxo, meça o impacto, declare lacunas, proponha uma mudança pequena e só altere depois da aprovação.”

Esse é um ótimo primeiro teste real da estrutura porque combina investigação, legado, risco de regressão e rastreabilidade.
