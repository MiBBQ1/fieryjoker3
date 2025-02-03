#!/bin/bash

# Название приложения
APP_NAME="FieryJoker"
REPO_NAME=$(echo $APP_NAME | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

# Ваш GitHub-аккаунт
GITHUB_USERNAME="MiBBQ1"

# Путь к проекту (укажите свой)
PROJECT_PATH="/Users/m.shtupun/Downloads/FieryJoker"

# Проверяем, установлен ли GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) не установлен! Установите его: https://cli.github.com/"
    exit 1
fi

# Проверяем, авторизован ли GitHub CLI
if ! gh auth status &> /dev/null; then
    echo "❌ GitHub CLI не авторизован. Запустите:"
    echo "gh auth login"
    exit 1
fi

# Проверяем, существует ли репозиторий
if ! gh repo view $GITHUB_USERNAME/$REPO_NAME &> /dev/null; then
    echo "📌 Репозиторий не найден, создаю..."
    gh repo create $REPO_NAME --public --source=$PROJECT_PATH --remote=origin
else
    echo "✅ Репозиторий уже существует!"
fi

# Переход в папку проекта
cd "$PROJECT_PATH" || { echo "❌ Ошибка: Папка проекта не найдена!"; exit 1; }

# Инициализация Git, если ещё не создан
if [ ! -d ".git" ]; then
    git init
    git branch -M main
    git remote add origin git@github.com:$GITHUB_USERNAME/$REPO_NAME.git
fi

# Добавляем файлы и пушим
git add .
git commit -m "Initial commit"
git push -u origin main

echo "✅ Репозиторий успешно загружен: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
