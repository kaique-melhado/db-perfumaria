Antes de qualquer análise ou alteração, leia INTEGRALMENTE o arquivo:

`docs/agent-prompts/corporate-dotnet-context.prompt.md`

Esse arquivo contém as instruções completas e obrigatórias desta tarefa.

Execute exatamente o que está definido nele, utilizando também o contexto corporativo já levantado nesta sessão e as fontes disponíveis no workspace.

Regras adicionais:

* não utilize FinTrack ou qualquer reference implementation pessoal nesta etapa;
* não trate o próprio arquivo de prompt como evidência;
* não inclua o arquivo de prompt no inventário de fontes/evidências;
* não altere o arquivo de prompt;
* não recomece o discovery do zero quando o contexto desta sessão já contiver informação validada; consulte novamente as fontes apenas quando necessário para confirmar ou complementar;
* preserve rigorosamente a distinção entre política corporativa, restrição/default de plataforma, tecnologia disponível, prática local, informação fornecida pelo responsável e informação não encontrada;
* a única alteração permitida é o artefato de saída definido no próprio prompt.

Antes de iniciar a escrita, confirme internamente que carregou integralmente as instruções do arquivo. Em seguida, execute a tarefa até a conclusão.

01 ---------------------------------------------------------01 ---------------------------------------------------------

A execução voltou a falhar com `net::ERR_HTTP2_PROTOCOL_ERROR` exatamente durante `Creating file`.

O contexto está em apenas ~14% da janela disponível, portanto não tente repetir a criação integral do documento em uma única operação.

O arquivo:

`docs/architecture/corporate-dotnet-context.md`

já existe e deve ser preenchido **incrementalmente**, preservando integralmente as instruções de:

`docs/agent-prompts/corporate-dotnet-context.prompt.md`

Nesta etapa, escreva APENAS:

1. Resumo Executivo
2. Princípios de classificação
3. Criação e governança de repositórios
4. Runtime e política .NET
5. CI/CD e Quality Gates
6. Deployment, Azure e Cloud

Regras:

* não compacte o conteúdo para compensar a divisão em etapas;
* mantenha evidências, classificações e graus de confiança;
* não escreva as seções posteriores ainda;
* não altere nenhum outro arquivo;
* não recrie o arquivo do zero se já houver conteúdo válido;
* ao concluir esta etapa, pare e informe apenas quais seções foram persistidas com sucesso.


02 ---------------------------------------------------------02 ---------------------------------------------------------

Continue o mesmo artefato sem reescrever, resumir ou modificar as seções já concluídas.

Agora acrescente APENAS as seções 7 a 12 definidas no prompt original:
7. Key Vault, secrets e identidade
8. Tecnologias corporativas disponíveis
9. APIs e integrações
10. Observabilidade
11. Testes e qualidade
12. Contexto do Boletron

Preserve integralmente o nível de evidência e classificação solicitado.
Pare após persistir essas seções.

03 ---------------------------------------------------------03 ---------------------------------------------------------

Continue o mesmo artefato sem reescrever, resumir ou modificar as seções já concluídas.

Agora acrescente todas as seções restantes definidas no prompt original, incluindo:
- Modernização e cloud híbrida;
- Definido corporativamente vs. decisão nossa;
- Engineering Candidates ainda não validados;
- Lacunas da futura .NET Engineering Baseline;
- Questões em aberto;
- Fontes consultadas.

Ao final:
1. revise o documento completo;
2. valide que nenhuma seção solicitada ficou ausente ou truncada;
3. NÃO regenere o arquivo inteiro;
4. faça somente correções pontuais se encontrar inconsistências.




Três pequenos ajustes que eu faria no documento antes de congelá-lo

Eu faria somente estes, sem revisão geral.

Primeiro, na matriz final, toda referência a:

Duplicação ≤ 3%

deveria aparecer como:

Duplicated Lines ≤ 3% — New Code

para refletir exatamente o gate observado.

Segundo, eu evitaria alguns usos de:

“Sim — integralmente”

na coluna “Ainda precisa de decisão nossa”.

Por exemplo, arquitetura interna realmente é nossa, mas não é totalmente unconstrained: ela precisa continuar obedecendo .sln na raiz, descoberta de testes, quality gates, packaging, hosting, tokenização etc.

Eu usaria algo mais rigoroso:

SIM — decisão de engenharia dentro dos constraints corporativos identificados.

Essa frase é muito melhor para quase todos esses casos.

Terceiro, no Resumo Executivo, eu substituiria:

plataforma “madura e fechada”

por algo como:

plataforma operacionalmente madura e centralmente governada no escopo observado

“Fechada” pode soar negativo e pode ser interpretado como tecnologicamente fechada, quando o que vimos é principalmente governança centralizada de pipeline/plataforma.
