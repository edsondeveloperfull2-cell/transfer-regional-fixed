# =======================================================
# 🟢 update-github.ps1 - Atualiza repositório antigo
# Projeto: Transfer Regional (corrigido com MySQL)
# Autor: Edson + ChatGPT
# =======================================================

# === CONFIGURAÇÕES ===
$repoName = "transfer-regional"
$zipFile = ".\transfer-regional-fixed.zip"     # arquivo ZIP local
$extractPath = ".\transfer-regional-fixed"

# === VERIFICAÇÕES ===
Write-Host "🧩 Verificando dependências..." -ForegroundColor Cyan
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git não encontrado. Instale o Git antes de continuar." -ForegroundColor Red
    exit
}
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "❌ GitHub CLI (gh) não encontrado. Instale em: https://cli.github.com/" -ForegroundColor Red
    exit
}

# === LOGIN NO GITHUB ===
Write-Host "`n🔐 Fazendo login no GitHub (se necessário)..."
gh auth login

# === EXTRAIR ZIP ===
Write-Host "`n📦 Extraindo $zipFile ..."
if (-not (Test-Path $zipFile)) {
    Write-Host "❌ Arquivo $zipFile não encontrado!" -ForegroundColor Red
    Write-Host "💡 Dica: coloque o arquivo transfer-regional-fixed.zip na mesma pasta deste script." -ForegroundColor Yellow
    exit
}

if (Test-Path $extractPath) { Remove-Item $extractPath -Recurse -Force }
Expand-Archive -Path $zipFile -DestinationPath $extractPath -Force

# === ENTRAR NA PASTA EXTRAÍDA ===
Set-Location "$extractPath\transfer-regional"

# === INICIALIZAR GIT ===
Write-Host "`n🚀 Inicializando repositório Git..."
git init
git add .
git commit -m "Atualização do repositório antigo com versão corrigida"

# === SUBSTITUIR REPOSITÓRIO ANTIGO ===
Write-Host "`n🌐 Subindo para repositório antigo ($repoName)..."
git remote add origin https://github.com/edsondeveloperfull2-cell/$repoName.git
git branch -M main
git push -f origin main

# === FINALIZAÇÃO ===
Write-Host "`n✅ Repositório atualizado com sucesso!"
Write-Host "👉 URL: https://github.com/edsondeveloperfull2-cell/$repoName"
