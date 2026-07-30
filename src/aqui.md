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