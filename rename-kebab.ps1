Write-Host "🔍 Iniciando a padronização de nomenclatura para kebab-case..." -ForegroundColor Cyan

# 1. Renomeação de arquivos em banco-de-dados
Write-Host "1. Renomeando arquivos SQL em banco-de-dados..." -ForegroundColor Yellow
git mv "banco-de-dados/Aula_View_sexta.sql" "banco-de-dados/aula-view-sexta.sql"
git mv "banco-de-dados/BDTransporteJoao_mysql.sql" "banco-de-dados/bd-transporte-joao-mysql.sql"
git mv "banco-de-dados/Correcao_Sexta.sql" "banco-de-dados/correcao-sexta.sql"
git mv "banco-de-dados/DDLAula02_Alter.sql" "banco-de-dados/ddl-aula-02-alter.sql"
git mv "banco-de-dados/Datas_Join_subselect_conjunto_sexta.sql" "banco-de-dados/datas-join-subselect-conjunto-sexta.sql"
git mv "banco-de-dados/Procedure_seg.sql" "banco-de-dados/procedure-seg.sql"
git mv "banco-de-dados/Procedure_sexta.sql" "banco-de-dados/procedure-sexta.sql"
git mv "banco-de-dados/RH_mysql.sql" "banco-de-dados/rh-mysql.sql"
git mv "banco-de-dados/TransporteSex.sql" "banco-de-dados/transporte-sex.sql"
git mv "banco-de-dados/VendasED_v2_com_dados.sql" "banco-de-dados/vendas-ed-v2-com-dados.sql"
git mv "banco-de-dados/aulaSexta_select_simples.sql" "banco-de-dados/aula-sexta-select-simples.sql"
git mv "banco-de-dados/correcao_lista_update_insert_delete_select_sexta.sql" "banco-de-dados/correcao-lista-update-insert-delete-select-sexta.sql"
git mv "banco-de-dados/exemploapi.sql" "banco-de-dados/exemplo-api.sql"
git mv "banco-de-dados/function_transacao.sql" "banco-de-dados/function-transacao.sql"
git mv "banco-de-dados/join_sexta.sql" "banco-de-dados/join-sexta.sql"

# 2. Renomeação de pastas em linguagens-de-programacao/exercicios
Write-Host "`n2. Renomeando pastas em linguagens-de-programacao/exercicios..." -ForegroundColor Yellow
git mv "linguagens-de-programacao/exercicios/AJAX - Previsão do Tempo" "linguagens-de-programacao/exercicios/ajax-previsao-do-tempo"
git mv "linguagens-de-programacao/exercicios/Bootstrap" "linguagens-de-programacao/exercicios/bootstrap"
git mv "linguagens-de-programacao/exercicios/CSS - FlexBox" "linguagens-de-programacao/exercicios/css-flexbox"
git mv "linguagens-de-programacao/exercicios/CSS - Float - Position" "linguagens-de-programacao/exercicios/css-float-position"
git mv "linguagens-de-programacao/exercicios/CSS Fundamentos" "linguagens-de-programacao/exercicios/css-fundamentos"
git mv "linguagens-de-programacao/exercicios/Exercício 1 – Conceitos de JavaScript" "linguagens-de-programacao/exercicios/exercicio-1-conceitos-de-javascript"
git mv "linguagens-de-programacao/exercicios/Lista 02 - Conceitos de JavaScript" "linguagens-de-programacao/exercicios/lista-02-conceitos-de-javascript"
git mv "linguagens-de-programacao/exercicios/Tags Html" "linguagens-de-programacao/exercicios/tags-html"

# 3. Renomeação de pastas em lógica-algoritmos-e-programação-orientada-a-objetos/exercicios
Write-Host "`n3. Renomeando pastas em lógica-algoritmos-e-programação-orientada-a-objetos/exercicios..." -ForegroundColor Yellow
git mv "lógica-algoritmos-e-programação-orientada-a-objetos/exercicios/Aula_2" "lógica-algoritmos-e-programação-orientada-a-objetos/exercicios/aula-02"
git mv "lógica-algoritmos-e-programação-orientada-a-objetos/exercicios/Aula_7" "lógica-algoritmos-e-programação-orientada-a-objetos/exercicios/aula-07"

Write-Host "`n🎉 Concluído com sucesso!" -ForegroundColor Green
