@echo off
:: =======================================================
:: 🔧 update-github.bat - Atualiza repositório GitHub antigo
:: Projeto: Transfer Regional (corrigido com MySQL)
:: Autor: Edson + ChatGPT
:: =======================================================

setlocal
set REPO_NAME=transfer-regional
set ZIP_FILE=transfer-regional-fixed.zip
set EXTRACT_DIR=transfer-regional-fixed

echo.
echo 🧩 Verificando dependências...
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Git não encontrado! Instale em https://git-scm.com/download/win
    pause
    exit /b
)
where gh >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ GitHub CLI não encontrada! Instale em https://cli.github.com/
    pause
    exit /b
)

echo.
echo 🔐 Fazendo login no GitHub (se necessário)...
gh auth login

echo.
echo 📦 Verificando arquivo ZIP...
if not exist "%ZIP_FILE%" (
    echo ❌ Arquivo %ZIP_FILE% não encontrado!
    echo 💡 Coloque este .bat e o arquivo transfer-regional-fixed.zip na MESMA pasta.
    pause
    exit /b
)

echo.
echo 📂 Limpando pasta antiga...
rmdir /s /q "%EXTRACT_DIR%" 2>nul

echo.
echo 🔧 Extraindo %ZIP_FILE%...
powershell -command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%EXTRACT_DIR%' -Force"

cd "%EXTRACT_DIR%\transfer-regional" || (
    echo ❌ Erro: pasta extraída não encontrada.
    pause
    exit /b
)

echo.
echo 🚀 Inicializando Git...
git init
git add .
git commit -m "Atualização do repositório com versão corrigida"

echo.
echo 🌐 Subindo para o repositório antigo (%REPO_NAME%)...
git remote add origin https://github.com/edsondeveloperfull2-cell/%REPO_NAME%.git
git branch -M main
git push -f origin main

echo.
echo ✅ Repositório atualizado com sucesso!
echo 👉 https://github.com/edsondeveloperfull2-cell/%REPO_NAME%
pause
