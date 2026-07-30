A pasta scripts/ contém um backup recente de objetos de banco (~6-7 mil arquivos), adicionada fora do escopo deste levantamento. Não leia, não enumere e não analise o conteúdo desta pasta nesta etapa. Apenas reconheça sua existência como fonte futura de evidência para mapeamento de regras de negócio em stored procedures, a ser explorada em uma frente separada.



Segue uma versão mais refinada, objetiva e alinhada ao restante das decisões já tomadas:

> Concordo com a proposta, com alguns ajustes e esclarecimentos:

O "file changed (+429/-1)" refere-se ao arquivo de levantamento estrutural (docs/discovery/...), não ao copilot-instructions.md.

Prefiro manter os arquivos de work item em docs/workitems/ e versionados no repositório.

As regras existentes relacionadas à Azure devem ser preservadas. Embora não tenham sido encontradas evidências de Azure neste repositório, elas fazem parte das esteiras e da infraestrutura mantidas por outro time. Portanto, não devem ser removidas nem alteradas nesta etapa; apenas identifique claramente que sua origem não foi verificada durante o levantamento estrutural.


Há apenas mais um ajuste importante.

Sobre a convenção de identificação dos work items (//Id-1212 - Fulano - ..., //RTN: <...> etc.), não quero que ela seja tratada como padrão obrigatório apenas porque foi encontrada no código.

O levantamento demonstrou apenas que essa convenção existe em parte do legado. Isso é uma evidência histórica, não uma recomendação de governança.

Para o docs/workitems/README.md, prefiro que seja definida uma convenção nova, simples e independente desse padrão legado, por exemplo:

<yyyy-mm-dd>-<slug>.md

<ticket>-<slug>.md, quando existir um identificador oficial (Azure DevOps, Jira ou equivalente).


Se julgar útil, registre a convenção antiga apenas em uma seção "Convenções legadas observadas", deixando explícito que ela foi identificada durante o levantamento estrutural e que poderá ser utilizada apenas quando houver necessidade de manter rastreabilidade com demandas históricas.

Como princípio geral, sempre diferencie claramente:

Estado atual observado (o que existe hoje no legado).

Padrão recomendado daqui em diante (o que passa a orientar novos desenvolvimentos).


Não quero que novos documentos perpetuem uma convenção que aparenta ser apenas um padrão histórico do sistema legado. Ela deve ser documentada como contexto, mas não adotada automaticamente como boa prática futura.


-----------------------------


Revise criticamente toda a estrutura criada (copilot-instructions.md, *.instructions.md, prompts, docs/workitems/README.md e TEMPLATE.md), preservando a arquitetura atual e aplicando apenas melhorias que aumentem consistência, clareza e manutenibilidade.

Objetivos desta revisão:

1. Não alterar a filosofia do projeto
- Manter a separação entre:
  - fatos observados;
  - hipóteses;
  - padrão recomendado;
  - regras herdadas;
  - escopo não coberto.
- Não transformar observações em afirmações absolutas.
- Continuar privilegiando evidências verificáveis no código.

2. Tornar o copilot-instructions.md mais navegável
- Adicionar um índice no início do documento.
- Destacar explicitamente um princípio geral, por exemplo:

  "Em caso de divergência entre esta documentação e o código-fonte atual, o código prevalece. Esta documentação registra fatos observados durante o levantamento estrutural e pode ficar desatualizada conforme o sistema evolui."

Sem alterar o restante da estrutura.

3. Padronizar os níveis de confiança
Onde houver referência a confiança baixa/média/alta, documentar claramente o significado.

Exemplo:

- baixa:
  apenas nomenclatura, convenção ou indício observado.

- média:
  múltiplas referências cruzadas no código, porém sem confirmação completa do fluxo.

- alta:
  fluxo completo confirmado por chamadas, referências e evidências observadas.

Utilizar exatamente a mesma definição em todos os prompts e templates.

4. Criar um novo prompt especializado
Adicionar um novo arquivo:

.github/prompts/descobrir-regra-negocio.prompt.md

Objetivo:

Levantar evidências relacionadas a uma regra de negócio específica.

Esse prompt deve:

- localizar classes, formulários, métodos e stored procedures relacionados;
- separar fatos observados de hipóteses;
- identificar integrações externas;
- listar dependências;
- registrar claramente o que não foi possível confirmar;
- nunca inferir comportamento apenas pelo nome.

Ele deve complementar os prompts existentes:
- mapear-fluxo;
- mapear-impacto;
- registrar-progresso.

Não substituir nenhum deles.

5. Pequenas melhorias editoriais
Padronizar títulos, listas e terminologia entre todos os arquivos.

Eliminar duplicações de texto quando possível.

Melhorar a legibilidade sem alterar o significado.

6. Não alterar estas decisões
Preservar exatamente:

- work items em docs/workitems;
- convenção moderna de work items (INC/PROJ/TECH/TMP);
- convenções legadas apenas como contexto histórico;
- seção "Regras herdadas — origem não verificada";
- regras referentes ao Azure, pipelines e esteiras exatamente como estão;
- separação entre documentação estrutural e documentação de progresso;
- filosofia baseada em fatos observados.

7. Evitar overengineering
Não criar novos agentes, skills ou instruções extras além do prompt "descobrir-regra-negocio".

Não aumentar a complexidade da estrutura.

A prioridade é tornar a documentação mais clara, consistente e sustentável, mantendo sua simplicidade.

Ao final, apresente um resumo objetivo contendo:

- alterações realizadas;
- justificativa de cada alteração;
- arquivos modificados;
- impacto esperado para o uso com GitHub Copilot/Copilot Chat.
