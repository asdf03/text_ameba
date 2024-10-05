# Text Ameba

複数の文字列をコード内に埋め込めるよう、フォーマットをしてくれる効率化CLIツール

## 使用例

1. Text_Amebaを起動
    ```bash
    $ text_ameba
    ```

2. メニューから矢印キーで項目を選択してエンター
    ```bash
    ===========================
    =   t e x t - a m e b a   =
    ===========================
    >  テキスト入力
    ファイル読み込み
    終了
    ```

    - テキスト入力 ... フォーマットするテキストを直接入力する（文字列が少量の場合に推奨）
    - ファイル読み込み ... ファイルからフォーマットする文字列を入力する（文字列が大量の場合に推奨）
    - 終了 ... 何もせずに終了する

3. テキスト入力
    ```
    ===========================
    =   t e x t - a m e b a   =
    ===========================

    テキストを入力してください (終了の場合は'end'と入力しEnterキーを押してください。)

    aaa
    bbb
    ccc
    end

    ( ´･ω･)⊃ ｽｯ

    'aaa',
    'bbb',
    'ccc'

    クリップボードにコピーされました
    ```

## インストール方法

1. gitレポジトリをクローン
    ```bash
    git clone git@github.com:asdf03/text_ameba.git
    ```

2. .bashrcにソースコードまでのパスを指定
    ```bash
    # text_amebaをcloneした場所が ~/source 直下だった場合
    $ vim ~/.bashrc

    ~~~~~~~~~~~~~~~~~~~~~~~~
    ## text_ameba
    if [ -f ~/source/text_ameba/text_ameba.sh ]; then
        source ~/source/text_ameba/text_ameba.sh
    fi
    ~~~~~~~~~~~~~~~~~~~~~~~~
    ```

3. .bashrcを再読み込みする
    ```bash
    $ source ~/.bashrc
    ```

4. text_amebaコマンドが利用できたら完了
    ```bash
    $ text_ameba
    ```
