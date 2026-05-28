# Script para corrigir pastas com ícones de seta (Git submodules/gitlinks)
# Este script remove repositórios Git aninhados (.git) e reconverte as pastas em diretórios normais.

Write-Host "🔍 Iniciando a correção das pastas..." -ForegroundColor Cyan

# 1. Caminho do repositório
$repoPath = "C:\Dev\faculdade"

# 2. Buscar e deletar todos os diretórios .git aninhados (exceto o da raiz)
Write-Host "1. Removendo pastas '.git' internas..." -ForegroundColor Yellow
Get-ChildItem -Path $repoPath -Filter ".git" -Recurse -Force -ErrorAction SilentlyContinue | 
    Where-Object { $_.FullName -ne "$repoPath\.git" } | 
    ForEach-Object {
        Write-Host "Deletando: $_.FullName" -ForegroundColor Gray
        Remove-Item -Path $_.FullName -Recurse -Force
    }

# 3. Limpar o cache do Git e re-adicionar os arquivos como pastas normais
Write-Host "`n2. Atualizando o índice do Git para remover referências antigas..." -ForegroundColor Yellow
Set-Location -Path $repoPath
git rm -r --cached .
git add .

Write-Host "`n🎉 Sucesso! As pastas foram convertidas para diretórios comuns." -ForegroundColor Green
Write-Host "Para concluir, execute no terminal do VS Code:" -ForegroundColor Green
Write-Host "git commit -m 'chore: convert nested submodules to normal folders'" -ForegroundColor Cyan
Write-Host "git push" -ForegroundColor Cyan
