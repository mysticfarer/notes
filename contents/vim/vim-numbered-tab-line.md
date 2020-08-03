# 显示编号的vim Tab栏

默认的vim Tab栏不显示页编号，这在打开的Tab页较多时，很难快速用 gt 快捷键进行跳转。  
采用此自定义的Tab栏显示方案后，将会对Tab页从1开始编号，方便进行跳转。

> 此函数的主体，来自曾经在论坛上摘得的一段代码，具体出处已经记不清了，  
> 如有知道出处的朋友，请联系我标注上原始来源，感谢。  
> 我在其基础上，又做了一些关于编号、文件修改状态等展示内容的修改，使其效果更友好。

将以下代码拷贝至 `~/.vimrc` 后即可应用新的Tab栏显示：

```vim
set tabline=%!NumberedTabLine()  " custom tab pages line
function NumberedTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ' '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '


                " loop through each buffer in a tab
                let winnr = tabpagewinnr(t + 1)
                let buflist = tabpagebuflist(t + 1)
                let n = fnamemodify(bufname(buflist[winnr - 1]), ':p:t')
                for b in buflist
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                endfor


                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
endfunction
```
