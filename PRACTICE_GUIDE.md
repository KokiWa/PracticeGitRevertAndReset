# Git Revert と Git Reset の練習ガイド

このガイドでは、複数のコミットを作成した後、特定のコミットまで戻す練習を行います。

## シナリオ

以下のようなコミット履歴があるとします：
```
A → B → C → D → E → F
```

この状態から、**Cまでのコミットのみ**に戻したい場合の練習です。

---

## 準備：複数のコミットを作成

### 方法1: スクリプトを使用（推奨）

```bash
# スクリプトに実行権限を付与
chmod +x create-commits.sh

# スクリプトを実行（AからFまでのコミットを作成）
./create-commits.sh
```

### 方法2: 手動で作成

```bash
# コミットA
echo "コミットA" >> practice.txt
git add practice.txt
git commit -m "A: 初期機能追加"

# コミットB
echo "コミットB" >> practice.txt
git add practice.txt
git commit -m "B: 機能改善"

# コミットC
echo "コミットC" >> practice.txt
git add practice.txt
git commit -m "C: バグ修正"

# コミットD
echo "コミットD" >> practice.txt
git add practice.txt
git commit -m "D: 新機能追加"

# コミットE
echo "コミットE" >> practice.txt
git add practice.txt
git commit -m "E: パフォーマンス改善"

# コミットF
echo "コミットF" >> practice.txt
git add practice.txt
git commit -m "F: UI改善"
```

### GitHubにプッシュ

```bash
git push origin master
# または
git push origin main
```

---

## 練習1: Git Revert を使用する方法

**Git Revert**は、コミットを取り消す新しいコミットを作成します。履歴を保持したい場合に適しています。

### 手順

1. **現在の状態を確認**
```bash
git log --oneline
# 出力例:
# F: UI改善
# E: パフォーマンス改善
# D: 新機能追加
# C: バグ修正
# B: 機能改善
# A: 初期機能追加
```

2. **D, E, Fのコミットを順番にRevert**
```bash
# FをRevert（最新から順番に）
git revert HEAD --no-edit
# または
git revert <Fのコミットハッシュ> --no-edit

# EをRevert
git revert HEAD~1 --no-edit
# または
git revert <Eのコミットハッシュ> --no-edit

# DをRevert
git revert HEAD~2 --no-edit
# または
git revert <Dのコミットハッシュ> --no-edit
```

3. **結果を確認**
```bash
git log --oneline
# 出力例:
# Revert "F: UI改善"
# Revert "E: パフォーマンス改善"
# Revert "D: 新機能追加"
# C: バグ修正
# B: 機能改善
# A: 初期機能追加
```

4. **GitHubにプッシュ**
```bash
git push origin master
```

### 特徴
- ✅ 履歴が保持される（安全）
- ✅ 既にプッシュ済みのコミットでも使用可能
- ❌ 履歴が長くなる（Revertコミットが追加される）

---

## 練習2: Git Reset を使用する方法（バックアップ付き）

**Git Reset**は、コミット履歴を直接書き換えます。**必ずバックアップブランチを作成してから実行**してください。

### 手順

1. **現在の状態を確認**
```bash
git log --oneline
```

2. **バックアップブランチを作成（重要！）**
```bash
# 現在のブランチをバックアップ
git branch backup-before-reset

# バックアップブランチを確認
git branch
```

3. **CのコミットまでReset（Soft Reset）**
```bash
# Cのコミットハッシュを確認
git log --oneline

# CまでReset（変更はステージングエリアに残る）
git reset --soft <Cのコミットハッシュ>
# または
git reset --soft HEAD~3  # D, E, Fの3つを戻す
```

4. **結果を確認**
```bash
git log --oneline
# 出力例:
# C: バグ修正
# B: 機能改善
# A: 初期機能追加

git status
# D, E, Fの変更がステージングエリアにあることを確認
```

5. **変更を破棄する場合**
```bash
# ステージングエリアの変更を破棄
git reset --hard HEAD
```

6. **GitHubにプッシュ（Force Pushが必要）**
```bash
# ⚠️ 注意: Force Pushは危険です。チームで共有しているブランチでは使用しないでください
git push --force origin master
```

### Resetの種類

- `--soft`: コミットのみ取り消し、変更はステージングエリアに残る
- `--mixed`（デフォルト）: コミットとステージングを取り消し、変更はワーキングディレクトリに残る
- `--hard`: コミット、ステージング、変更をすべて取り消す（⚠️ 注意：変更が失われます）

### バックアップブランチから復元する場合

```bash
# バックアップブランチを確認
git branch

# バックアップブランチに切り替え
git checkout backup-before-reset

# または、現在のブランチをバックアップの状態に戻す
git reset --hard backup-before-reset
```

### 特徴
- ✅ 履歴がクリーンになる
- ✅ 柔軟な操作が可能
- ❌ 履歴を書き換えるため、既にプッシュ済みの場合はForce Pushが必要
- ❌ チームで共有しているブランチでは問題を起こす可能性がある

---

## 比較表

| 項目 | Git Revert | Git Reset |
|------|-----------|-----------|
| 履歴の保持 | ✅ 保持される | ❌ 書き換えられる |
| 安全性 | ✅ 安全 | ⚠️ 注意が必要 |
| 既にプッシュ済み | ✅ 問題なし | ⚠️ Force Push必要 |
| 履歴の見た目 | ❌ Revertコミットが追加 | ✅ クリーン |
| 推奨される場面 | 共有ブランチ | 個人ブランチ、バックアップあり |

---

## 練習の流れ（まとめ）

### 1. 初期セットアップ
```bash
./create-commits.sh
git push origin master
```

### 2. Git Revertの練習
```bash
# 現在の状態を確認
git log --oneline

# D, E, FをRevert
git revert HEAD --no-edit
git revert HEAD~1 --no-edit
git revert HEAD~2 --no-edit

# 確認してプッシュ
git log --oneline
git push origin master
```

### 3. リセットしてGit Resetの練習
```bash
# バックアップブランチを作成
git branch backup-before-reset

# CまでReset
git reset --soft HEAD~3

# 確認
git log --oneline
git status

# 必要に応じてForce Push
git push --force origin master
```

---

## トラブルシューティング

### 間違えてResetしてしまった場合
```bash
# reflogで履歴を確認
git reflog

# 元の状態に戻す
git reset --hard <元のコミットハッシュ>
```

### バックアップブランチから復元
```bash
git reset --hard backup-before-reset
```

### リモートとローカルの状態を確認
```bash
git log --oneline --all --graph
```

