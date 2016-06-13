\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{gmt-docs}[2016/06/03 GMT documentation class]
\LoadClass[UTF8, a4paper, 11pt, twoside]{ctexrep}

% 超链接
\AtBeginDocument{
    \hypersetup{
        CJKbookmarks = true,
        colorlinks = true,
        linkcolor = blue,
        citecolor = blue,
        urlcolor = blue,
    }
}

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
