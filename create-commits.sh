#!/bin/bash

# 複数のコミットを作成するスクリプト
# 使用方法: ./create-commits.sh

echo "複数のコミットを作成します..."

# コミットA
echo "コミットA: 初期機能追加" >> practice.txt
git add practice.txt
git commit -m "A: 初期機能追加"

# コミットB
echo "コミットB: 機能改善" >> practice.txt
git add practice.txt
git commit -m "B: 機能改善"

# コミットC
echo "コミットC: バグ修正" >> practice.txt
git add practice.txt
git commit -m "C: バグ修正"

# コミットD
echo "コミットD: 新機能追加" >> practice.txt
git add practice.txt
git commit -m "D: 新機能追加"

# コミットE
echo "コミットE: パフォーマンス改善" >> practice.txt
git add practice.txt
git commit -m "E: パフォーマンス改善"

# コミットF
echo "コミットF: UI改善" >> practice.txt
git add practice.txt
git commit -m "F: UI改善"

echo ""
echo "コミット履歴を確認:"
git log --oneline

echo ""
echo "完了！AからFまでのコミットが作成されました。"
echo ""
echo "【重要】"
echo "このスクリプトはローカルにコミットを作成しただけです。"
echo "GitHubにプッシュするには、以下のコマンドを実行してください："
echo ""
echo "  git push"
echo ""
echo "【プッシュ状況の確認方法】"
echo "リモートリポジトリが設定されているか確認:"
echo "  git remote -v"
echo ""
echo "ローカルとリモートの差分を確認:"
echo "  git log origin/master..HEAD  # プッシュされていないコミットを表示"
echo ""
echo "すべてのコミットがプッシュ済みか確認:"
echo "  git status"

