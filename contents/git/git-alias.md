# 索引
<!-- TOC -->
- [git lables -- 列举标签](#扩展命令git-lables)
- [git lines -- 统计提交行数](#扩展命令git-lines)
- [git plog -- 适合宽屏显示的日志命令](#扩展命令git-plog)
- [git conflicts -- 列举冲突的文件](#扩展命令git-conflicts)
<!-- /TOC -->

<a id="markdown-扩展命令git-lables" name="扩展命令git-lables"></a>
# 扩展命令：git lables

通过此命令，可以快速检索到 commit message 中被 `[]` `【】` `<>` 括住的关键字（即标签）。  
我们在提交代码时，通常会在commit message中用以上标签标注此次提交所属的功能，方便以后筛选。  
而此命令，将可以方便的列举出仓库中已有的标签。

## 示例
列出仓库中所有的标签：
```console
$ git lables
[GamePlay]
[Motion]
[Audio]
$
```

和其它git子命令一样，lables命令也可以使用 `author/grep/since` 等参数来限定范围，且可以使用Tab键补全：
```console
$ git lables --author=honglei --grep=Mot
[Motion]
$
```

## 配置方法
拷贝以下命令，在终端中进行配置：
```sh
E='!'; git config --global alias.lables "${E}f(){ git log --pretty=format:'%B' \$@ | grep -oE '\\[[^]]+\\]|【[^】]+】|<[^>]+>' | sort | uniq; }; f"
```

或编辑 ~/.gitconfig ，手动添加：
```ini
[alias]
    lables = "!f(){ git log --pretty=format:'%B' $@ | grep -oE '\\[[^]]+\\]|【[^】]+】|<[^>]+>' | sort | uniq; }; f"
```

---

<a id="markdown-扩展命令git-lines" name="扩展命令git-lines"></a>
# 扩展命令：git lines
用于计算仓库中已提交的行数。

## 示例
计算整个仓库的提交行数：
```console
$ git lines
8992 insertions
355 deletions
$
```

计算指定作者，自指定日期以来的提交行数：
```console
$ git lines --author=honglei --since="2020-01-01"
2560 insertions
114 deletions
$
```

## 配置方法
拷贝以下命令，在终端中进行配置：
```sh
E='!'; git config --global alias.lines "${E}f(){ git log --pretty=oneline --numstat \$@ | sed '/[a-f0-9]\\{40\\}/d' | awk '{i+=\$1; d+=\$2} END {printf \"%d insertions\\n%d deletions\\n\", i, d}'; }; f"
```

或编辑 ~/.gitconfig ，手动添加：
```ini
[alias]
    lines = "!f(){ git log --pretty=oneline --numstat $@ | sed '/[a-f0-9]\\{40\\}/d' | awk '{i+=$1; d+=$2} END {printf \"%d insertions\\n%d deletions\\n\", i, d}'; }; f"
```

---

<a id="markdown-扩展命令git-plog" name="扩展命令git-plog"></a>
# 扩展命令：git plog
适合宽屏显示的log命令。  
每行显示一条commit message，包括 `hash/日期/作者/分支指针/message` 等信息。

## 示例
与 git log 的用法完全一致：
```console
$ git plog
0a8e60e 2020-08-03 02:33:23 honglei          (HEAD -> master) Add .gitignore
a000708 2020-08-03 02:32:04 honglei          Init repos
$
```

## 配置方法
拷贝以下命令，在终端中进行配置：
```sh
git config --global alias.plog "log --pretty=format:'%C(auto)%h %C(green)%ad %C(blue)%<(15)%an %C(auto)%d %Creset%<(120,trunc)%s' --date=format:'%Y-%m-%d %H:%M:%S'"
```

或编辑 ~/.gitconfig ，手动添加：
```ini
[alias]
    plog = log --pretty=format:'%C(auto)%h %C(green)%ad %C(blue)%<(15)%an %C(auto)%d %Creset%<(120,trunc)%s' --date=format:'%Y-%m-%d %H:%M:%S'
```

---

<a id="markdown-扩展命令git-conflicts" name="扩展命令git-conflicts"></a>
# 扩展命令：git conflicts
用于在合并时列出冲突的文件。  
在合并大量文件、出现较多冲突时，比直接用 git status 要看的更清爽些，  
不至于文件列表过长，导致一屏显示不下。

## 示例
```console
$ git conflicts
main.c
config.c
$
```

## 配置方法
拷贝以下命令，在终端中进行配置：
```sh
git config --global alias.conflicts "diff --name-only --diff-filter=U"
```

或编辑 ~/.gitconfig ，手动添加：
```ini
[alias]
    conflicts = diff --name-only --diff-filter=U
```
