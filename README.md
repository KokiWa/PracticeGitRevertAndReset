# Git練習用リポジトリ

このリポジトリはGitとGitHubの練習用です。

## セットアップ

### 1. GitHubでリポジトリを作成

1. [GitHub](https://github.com)にログイン
2. 右上の「+」ボタンから「New repository」を選択
3. リポジトリ名を入力（例: `git-practice`）
4. 「Create repository」をクリック

### 2. ローカルリポジトリとGitHubを連携

```bash
# リモートリポジトリを追加（YOUR_USERNAMEとYOUR_REPO_NAMEを置き換えてください）
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# またはSSHを使用する場合
git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO_NAME.git
```

### 3. 初回コミットとプッシュ

```bash
# ファイルをステージング
git add .

# コミット
git commit -m "Initial commit"

# メインブランチにプッシュ
git push -u origin master
# または（ブランチ名がmainの場合）
git push -u origin main
```

## 基本的なGitコマンド

### 状態確認
```bash
git status          # 現在の状態を確認
git log             # コミット履歴を確認
git log --oneline   # 簡潔な履歴表示
```

### ファイル操作
```bash
git add <file>      # 特定のファイルをステージング
git add .           # すべての変更をステージング
git commit -m "メッセージ"  # コミット
```

### ブランチ操作
```bash
git branch                    # ブランチ一覧
git branch <branch-name>     # 新しいブランチを作成
git checkout <branch-name>    # ブランチを切り替え
git checkout -b <branch-name> # ブランチを作成して切り替え
```

### リモート操作
```bash
git remote -v                 # リモートリポジトリを確認
git push                      # リモートにプッシュ
git pull                      # リモートから取得
git fetch                     # リモートの変更を取得（マージしない）
```

## 練習用ファイル

- `practice.txt`: 練習用のテキストファイル
- `example.js`: 練習用のJavaScriptファイル

これらのファイルを編集して、Gitの操作を練習してください。

## よくある操作の流れ

1. ファイルを編集
2. `git status` で変更を確認
3. `git add .` でステージング
4. `git commit -m "変更内容"` でコミット
5. `git push` でGitHubにアップロード

## 上級練習: Git Revert と Git Reset

複数のコミットを作成した後、特定のコミットまで戻す練習を行います。

詳細は **[PRACTICE_GUIDE.md](./PRACTICE_GUIDE.md)** を参照してください。

### クイックスタート: 複数コミットの作成とプッシュ

この手順では、**6つのコミット（AからF）を一度に作成して、GitHubにプッシュ**します。

#### ステップ1: スクリプトに実行権限を付与

```bash
chmod +x create-commits.sh
```

**説明**: このコマンドで、`create-commits.sh`を実行可能にします。

#### ステップ2: スクリプトを実行して複数のコミットを作成

```bash
./create-commits.sh
```

**説明**: このスクリプトは以下の6つのコミットを**ローカルに**作成します：
- コミットA: 初期機能追加
- コミットB: 機能改善
- コミットC: バグ修正
- コミットD: 新機能追加
- コミットE: パフォーマンス改善
- コミットF: UI改善

**確認方法**: スクリプト実行後、以下のコマンドでコミット履歴を確認できます：
```bash
git log --oneline
```
6つのコミット（AからF）が表示されれば成功です。

#### ステップ3: GitHubにプッシュ

```bash
git push origin master
```

**説明**: ステップ2で作成した**6つのコミットすべて**がGitHubにアップロードされます。

**重要**: 
- この時点で、**複数のコミット（A〜F）が一度にプッシュ**されます
- 1つずつではなく、**まとめて6つすべて**がプッシュされます

**確認方法**: プッシュ後、GitHubのリポジトリページでコミット履歴を確認してください。6つのコミットが表示されているはずです。

#### ステップ4: 練習を開始

`PRACTICE_GUIDE.md`を読んで、Revert/Resetの練習を開始してください。

---

#### よくある質問

**Q: スクリプトを実行しただけでは、GitHubに反映されないのですか？**  
A: はい、その通りです。スクリプトはローカルにコミットを作成するだけです。`git push`を実行して初めてGitHubに反映されます。

**Q: プッシュする前に、コミットを確認できますか？**  
A: はい、`git log --oneline`で確認できます。プッシュされていないコミットがある場合、`git status`で「Your branch is ahead of 'origin/master' by X commits」と表示されます。

