"colorscheme murphy
syntax on
set nocompatible
set guifont=Verdana:14
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\[HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
set cursorline
set number
"set cursorcolumn
"highlight CursorLine guibg=lightblue ctermbg=lightgray"
"highlight CursorColumn guibg=lightblue ctermbg=lightgray"
"set spelllang=en"
set undolevels=10000            "faz poder voltar 10000 undo"
set nowrap                      "faz o vim pular espacos vazios qndo as teclas sao usadas"
set incsearch                   " procura texto em tempo real, enquanto e' teclado
set ic                              "Nao diferencia mais/minusc
set magic                        " usa 'magia' ao procurar texto =)
set bs=indent,eol,start
set ruler                         " mostra a linha e coluna na statusbar
set title                          " mostra o nome do ficheiro no titulo do terminal
set smarttab                   "Tabulacao inteligente
set smartindent
set autoindent
set sm                            " mostra o ultimo par de parenteses fechados
set showcmd                     " mostra comando incomletos (marcar caracter, etc)

"====== complementa��o de palavras ====
"usa o tab em modo insert para completar palavras
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

"Vim syntax support file
" This is the startup file for syntax highlighting.
" It sets the default highlighting methods, and installs autocommands for all
" the available syntax files.

if has("syntax")

  " The default methods for highlighting.  Can be overridden later.
  " There should be only six of these, because many terminals can only use
  " six different colors (plus black and white).  It doesn't look nice with
  " too many colors too.
  " Careful with "cterm=bold", on rxvt it changes the color to bright.
  highlight Comment	term=bold ctermfg=DarkGreen guifg=DarkGreen
  highlight Constant	term=bold ctermfg=red guifg=red gui=bold
  highlight Identifier	term=bold ctermfg=DarkCyan guifg=DarkCyan
  highlight Statement	term=bold ctermfg=Yellow guifg=Yellow gui=bold 
  highlight PreProc	term=bold ctermfg=Gray guifg=Gray
  highlight Type	term=bold ctermfg=Blue guifg=Blue gui=bold  
  highlight Special	term=bold ctermfg=Cyan guifg=Cyan gui=underline

  " These two change the background
  highlight Error	term=reverse ctermbg=Red guibg=Orange
  highlight Todo	term=standout cterm=bold ctermbg=Yellow guifg=Blue guibg=Yellow

  " Common groups that link to default highlighting.
  " You can specify other highlighting easily.
  highlight link String		Constant
  highlight link Character	Constant
  highlight link Number		Constant
  highlight link Boolean	Constant
  highlight link Float		Number
  highlight link Function	Identifier
  highlight link Conditional	Statement
  highlight link Repeat		Statement
  highlight link Label		Statement
  highlight link Operator	Statement
  highlight link Keyword	Statement
  highlight link Include	PreProc
  highlight link Define		PreProc
  highlight link Macro		PreProc
  highlight link PreCondit	PreProc
  highlight link StorageClass	Type
  highlight link Structure	Type
  highlight link Typedef	Type
  highlight link Tag		Special

  augroup highlight

  " Ada (83, 9X, 95)
  au BufNewFile,BufReadPost *.adb,*.ads		so /usr/share/vim/vim80/syntax/ada.vim

  " Assembly (GNU)
  au BufNewFile,BufReadPost *.asm,*.s		so /usr/share/vim/vim80/syntax/asm.vim

  " Awk
  au BufNewFile,BufReadPost *.awk		so /usr/share/vim/vim80/syntax/awk.vim

  " Batch file for MSDOS
  au BufNewFile,BufReadPost *.bat,*.sys		so /usr/share/vim/vim80/syntax/dosbatch.vim

  " C
  au BufNewFile,BufReadPost *.c			so /usr/share/vim/vim80/syntax/c.vim

  " C++
  au BufNewFile,BufReadPost *.cpp,*.cc,*.h,*.cxx,*.c++,*.C,*.H,*.hh so $VIM/vim80/syntax/cpp.vim

  " Century Term Command Scripts
  au BufNewFile,BufReadPost *.cmd,*.con		so /usr/share/vim/vim80/syntax/cterm.vim

  " Diff files
  au BufNewFile,BufReadPost *.diff		so /usr/share/vim/vim80/syntax/diff.vim

  " Fortran
  au BufNewFile,BufReadPost *.f,*.for,*.fpp	so /usr/share/vim/vim80/syntax/fortran.vim

 " Fortran90
  au BufNewFile,BufReadPost *.f90        	so /usr/share/vim/vim80/syntax/fortran90.vim

  " HTML
  au BufNewFile,BufReadPost *.html,*.htm	so /usr/share/vim/vim80/syntax/html.vim

  " Java
  au BufNewFile,BufReadPost *.java		so /usr/share/vim/vim80/syntax/java.vim

  " JavaCC
  au BufNewFile,BufReadPost *.jj		so /usr/share/vim/vim80/syntax/javacc.vim

  " Lex
  au BufNewFile,BufReadPost *.lex,*.l		so /usr/share/vim/vim80/syntax/lex.vim

  " Lisp
  au BufNewFile,BufReadPost *.lsp,*.L		so /usr/share/vim/vim80/syntax/lisp.vim

  " Mail (for Elm, trn and rn)
  au BufNewFile,BufReadPost snd.*,.letter,.article,.article.[0-9]\+,pico.[0-9]\+,mutt[0-9]\+ so /usr/share/vim/vim80/syntax/mail.vim

  " Makefile
  au BufNewFile,BufReadPost [mM]akefile*	so /usr/share/vim/vim80/syntax/make.vim

  " Maple V
  au BufNewFile,BufReadPost *.mv		so /usr/share/vim/vim80/syntax/maple.vim

  " Matlab
  au BufNewFile,BufReadPost *.m			so /usr/share/vim/vim80/syntax/matlab.vim

  " Pascal
  au BufNewFile,BufReadPost *.p,*.pas		so /usr/share/vim/vim80/syntax/pascal.vim

  " Perl
  au BufNewFile,BufReadPost *.pl,*.pm		so /usr/share/vim/vim80/syntax/perl.vim

  " PostScript
  au BufNewFile,BufReadPost *.ps,*.eps		so /usr/share/vim/vim80/syntax/postscr.vim

  " Prolog
  au BufNewFile,BufReadPost *.pdb		so /usr/share/vim/vim80/syntax/prolog.vim

  " Python
  au BufNewFile,BufReadPost *.py		so /usr/share/vim/vim80/syntax/python.vim

  " Sather
  au BufNewFile,BufReadPost *.sa		so /usr/share/vim/vim80/syntax/sather.vim

  " Shell scripts (sh, ksh, bash, csh)
  au BufNewFile,BufReadPost .profile,.bashrc	so /usr/share/vim/vim80/syntax/sh.vim
  au BufNewFile,BufReadPost .login,.cshrc	so /usr/share/vim/vim80/syntax/csh.vim

  " Z-Shell script
  au BufNewFile,BufReadPost .z*,zsh*,zlog*	so /usr/share/vim/vim80/syntax/zsh.vim

  " SQL
  au BufNewFile,BufReadPost *.sql		so /usr/share/vim/vim80/syntax/sql.vim

  " TeX
  au BufNewFile,BufReadPost *.tex,*.sty		so /usr/share/vim/vim80/syntax/tex.vim

  " Motif UIT/UIL files
  au BufNewFile,BufReadPost *.uit,*.uil         so /usr/share/vim/vim80/syntax/uil.vim

  " Verilog HDL
  au BufNewFile,BufReadPost *.v			so /usr/share/vim/vim80/syntax/verilog.vim

  " Tcl
  au BufNewFile,BufReadPost *.tcl		so /usr/share/vim/vim80/syntax/tcl.vim

  " VHDL
  au BufNewFile,BufReadPost *.hdl,*.vhd,*.vhdl,*.vhdl_[0-9]*,*.vbe,*.vst  so /usr/share/vim/vim80/syntax/vhdl.vim
 
  " Vim Help file
  au BufNewFile,BufReadPost */vim*/doc/*.txt	so /usr/share/vim/vim80/syntax/help.vim

  " Vim script
  au BufNewFile,BufReadPost *.*vimrc,*.vim,.exrc,_*vimrc,_exrc so /usr/share/vim//vim80/syntax/vim.vim

  " VRML V1.0c
  au BufNewFile,BufReadPost *.wrl		so /usr/share/vim/vim80/syntax/vrml.vim

  " Xmath
  au BufNewFile,BufReadPost *.ms,*.msc,*.msf	so /usr/share/vim/vim80/syntax/xmath.vim

  " Yacc
  au BufNewFile,BufReadPost *.y			so /usr/share/vim/vim80/syntax/yacc.vim

  " Various scripts, without a specific extension
  au BufNewFile,BufReadPost *			so /usr/share/vim/vim80/scripts.vim

  augroup END

  if has("gui")
    50nmenu Syntax.off			:syn clear<CR>
    50nmenu Syntax.ABCDE.Ada		:so /usr/share/vim/vim80/syntax/ada.vim<CR>
    50nmenu Syntax.ABCDE.assembly	:so /usr/share/vim/vim80/syntax/asm.vim<CR>
    50nmenu Syntax.ABCDE.Awk		:so /usr/share/vim/vim80/syntax/awk.vim<CR>
    50nmenu Syntax.ABCDE.C		:so /usr/share/vim/vim80/syntax/c.vim<CR>
    50nmenu Syntax.ABCDE.C++		:so /usr/share/vim/vim80/syntax/cpp.vim<CR>
    50nmenu Syntax.ABCDE.Century\ Term	:so /usr/share/vim/vim80/syntax/cterm.vim<CR>
    50nmenu Syntax.ABCDE.Csh\ shell\ script :so /usr/share/vim/vim80/syntax/csh.vim<CR>
    50nmenu Syntax.ABCDE.Diff		:so /usr/share/vim/vim80/syntax/diff.vim<CR>
    50nmenu Syntax.FGHIJ.Fortran	:so /usr/share/vim/vim80/syntax/fortran.vim<CR>
    50nmenu Syntax.FGHIJ.HTML		:so /usr/share/vim/vim80/syntax/html.vim<CR>
    50nmenu Syntax.FGHIJ.Java		:so /usr/share/vim/vim80/syntax/java.vim<CR>
    50nmenu Syntax.FGHIJ.JavaCC		:so /usr/share/vim/vim80/syntax/javacc.vim<CR>
    50nmenu Syntax.KLMNO.Lex		:so /usr/share/vim/vim80/syntax/lex.vim<CR>
    50nmenu Syntax.KLMNO.Lisp		:so /usr/share/vim/vim80/syntax/lisp.vim<CR>
    50nmenu Syntax.KLMNO.Mail		:so /usr/share/vim/vim80/syntax/mail.vim<CR>
    50nmenu Syntax.KLMNO.Makefile	:so /usr/share/vim/vim80/syntax/make.vim<CR>
    50nmenu Syntax.KLMNO.Maple		:so /usr/share/vim/vim80/syntax/maple.vim<CR>
    50nmenu Syntax.KLMNO.Matlab		:so /usr/share/vim/vim80/syntax/matlab.vim<CR>
    50nmenu Syntax.KLMNO.MS-DOS\ \.bat\ file :so /usr/share/vim/vim80/syntax/dosbatch.vim<CR>
    50nmenu Syntax.KLMNO.Objective\ C	:so /usr/share/vim/vim80/syntax/objc.vim<CR>
    50nmenu Syntax.PQRST.Pascal		:so /usr/share/vim/vim80/syntax/pascal.vim<CR>
    50nmenu Syntax.PQRST.Perl		:so /usr/share/vim/vim80/syntax/perl.vim<CR>
    50nmenu Syntax.PQRST.PostScript	:so /usr/share/vim/vim80/syntax/postscr.vim<CR>
    50nmenu Syntax.PQRST.Prolog		:so /usr/share/vim/vim80/syntax/prolog.vim<CR>
    50nmenu Syntax.PQRST.Python		:so /usr/share/vim/vim80/syntax/python.vim<CR>
    50nmenu Syntax.PQRST.Sather		:so /usr/share/vim/vim80/syntax/sather.vim<CR>
    50nmenu Syntax.PQRST.Sh\ shell\ script :so /usr/share/vim/vim80/syntax/sh.vim<CR>
    50nmenu Syntax.PQRST.SQL		:so /usr/share/vim/vim80/syntax/sql.vim<CR>
    50nmenu Syntax.PQRST.Tex		:so /usr/share/vim/vim80/syntax/tex.vim<CR>
    50nmenu Syntax.PQRST.Tcl		:so /usr/share/vim/vim80/syntax/tcl.vim<CR>
    50nmenu Syntax.UVWXYZ.UIT/UIL	:so /usr/share/vim/vim80/syntax/uil.vim<CR>
    50nmenu Syntax.UVWXYZ.Verilog\ HDL	:so /usr/share/vim/vim80/syntax/verilog.vim<CR>
    50nmenu Syntax.UVWXYZ.VHDL		:so /usr/share/vim/vim80/syntax/vhdl.vim<CR>
    50nmenu Syntax.UVWXYZ.Vim\ help\ file :so /usr/share/vim/vim80/syntax/help.vim<CR>
    50nmenu Syntax.UVWXYZ.Vim\ script	:so /usr/share/vim/vim80/syntax/vim.vim<CR>
    50nmenu Syntax.UVWXYZ.VRML		:so /usr/share/vim/vim80/syntax/vrml.vim<CR>
    50nmenu Syntax.UVWXYZ.Xmath		:so /usr/share/vim/vim80/syntax/xmath.vim<CR>
    50nmenu Syntax.UVWXYZ.Yacc		:so /usr/share/vim/vim80/syntax/yacc.vim<CR>
    50nmenu Syntax.UVWXYZ.Zsh\ shell\ script :so /usr/share/vim/vim80/syntax/zsh.vim<CR>
  endif

  " Execute the highlight autocommands for the each buffer.
  doautoall highlight BufReadPost

endif
