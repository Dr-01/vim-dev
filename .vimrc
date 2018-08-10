" https://zhuanlan.zhihu.com/p/36279445
" https://www.zhihu.com/question/47691414/answer/373700711  2018 vim c++ 配置
set nocompatible  "关闭vi一致性模式
set bs=2          "set backspace=indent,eol,start 

set number        "设置行号
set ruler         "底部显示光标行号列号

set incsearch     "增量查询
set hlsearch      "高亮查询
"set ignorecase 
"set smartcase
set cursorline    "高亮当前行
hi CursorLine  cterm=NONE ctermbg=black ctermfg=NONE

"let g:indentLine_enabled = 0
let g:indentLine_faster = 1
"set cursorcolumn
set so=3           "下面总有三行
set so=999         "总在中间
set laststatus=2   "总是显示状态栏

"tab替换为空格
set sw=4
set ts=4
set expandtab

let mapleader = ","
syntax on
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set nowrap

"高亮匹配显示尖括号
set mps+=<:>

"nnoremap j jzz
"nnoremap k kzz

"设置文件编码
set encoding=utf-8  
set fileencodings=utf-8,gb2312,gbk,gb18030 
set t_ti= t_te=    "退出vim后 内容保留在终端

"折叠
set foldmethod=syntax  "用语法高亮来定义折叠
"set foldmethod=indent
set nofoldenable       "关闭折叠
nnoremap <space> za 
"za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠

"窗口调整
nmap w= :resize +3<CR>
nmap w- :resize -3<CR>
nmap w, :vertical resize -3<CR>
nmap w. :vertical resize +3<CR>

"设置tags 路径
"set tags=./.tags;,.tags
"set tags=./tags,tags;$HOME

"if has("cscope")          
   "set csprg=/usr/bin/cscope
   "set csto=0              
   "set cscopetag           
   ""set cst                
   "set nocsverb            
   "" add any database in current directory
   "if filereadable("cscope.out")  
     "cs add cscope.out     
   "" else add database pointed to by environment
   "elseif $CSCOPE_DB != "" 
     "cs add $CSCOPE_DB     
   "endif
   "set csverb              
"endif

"vim-plug
call plug#begin('~/.vim/plugged')             "兼容原来bundle的插件 不用重新安装
Plug 'vim-scripts/ShowPairs'                         "ShowPairs highlights the matching pair surrounding the current cursor location
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'Valloric/YouCompleteMe'
Plug 'Raimondi/delimitMate'           "符号自动补全  注:按shift-tab, 跳到补全的符号后面, 还是insert-mode
Plug 'octol/vim-cpp-enhanced-highlight'  "CPP 高亮
Plug 'scrooloose/nerdcommenter'        "快速注释
Plug 'Lokaltog/vim-easymotion'         "快速跳转 ,,w ,,b
Plug 'bling/vim-airline'               "状态栏增强
Plug 'vim-scripts/a.vim'               "源文件头文件快速切换
Plug 'SirVer/ultisnips'                "插入预设代码块引擎 和vim-snippets配合使用
Plug 'honza/vim-snippets'              "代码块集合
Plug 'yonchu/accelerated-smooth-scroll' "smooth scroll
Plug 'mileszs/ack.vim'                  "用ack搜索
Plug 'dyng/ctrlsf.vim'                  "使用ack来进行搜索
Plug 'Yggdroot/indentLine'              "显示每个段落的垂直线
Plug 'fatih/vim-go'                     "golang 插件 
Plug 'buoto/gotests-vim'                "gotest
"Plug 'Chiel92/vim-autoformat'           "代码格式插件 c++配置 需要安装clang
Plug 'vim-utils/vim-man'                "man pages
"Plug 'ctrlpvim/ctrlp.vim'               "ctlrp buffer 查找插件
"Plug 'vim-scripts/gtags.vim'            "gtags 插件 要先安装GNU Global, 代码目录下 gtags
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } " 用于代替CtrlP和tagbar插件  locating files, buffers, mrus, tags 
Plug 'justinmk/vim-dirvish'             " Directory viewer for Vim 替换nerdtree
Plug 'ludovicchabant/vim-gutentags'     " gtags ctags 管理工具
"Plug 'skywind3000/gutentags_plus'       " gtags功能加强
"Plug 'skywind3000/vim-preview'          " 快速preview预览窗口
call plug#end()

"if !has('gui_running')
"noremap <silent><ESC>]{0}1~ :tabn 1<cr>
"endif

"LeaderF
"nnoremap <ESC>p :LeaderfFunction!<CR>
"nnoremap <ESC>d :echo "m-d works!"<cr> "测试ALT键 要在xshell里面设置Meta键 终端按下alt 实际发送esc
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <ESC>p :LeaderfFunction!<cr>
noremap <ESC>b :LeaderfBuffer<cr>
noremap <ESC>m :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

"gutentags

"gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

"ctrlp
"let g:ctrlp_match_window = 'results:100'  "overcome limit imposed by max height

"gtags
"cscope
set cscopetag                  " 使用 cscope 作为 tags 命令
set cscopeprg=gtags-cscope   " 使用 gtags-cscope 代替 cscope

"" add any database in current directory
"if filereadable("GTAGS")  
 "cs add GTAGS  
"" else add database pointed to by environment
"elseif $CSCOPE_DB != "" 
 "cs add $CSCOPE_DB     
"endif
"let GtagsCscope_Auto_Load = 1
"let CtagsCscope_Auto_Map = 1
"let GtagsCscope_Quiet = 1

"vim-easymotion
let g:EasyMotion_smartcase = 1
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>. <Plug>(easymotion-repeat)

"vim-autoformat
"F3自动格式化代码
"noremap <F5> :Autoformat<CR>
"let g:autoformat_verbosemode=1
"保存时自动格式化代码，针对所有支持的文件
"au BufWrite * :Autoformat
""保存时自动格式化PHP代码
"au BufWrite *.php :Autoformat

"ctrlspace
"let g:ctrlspace_set_default_mapping = 0
"nnoremap <C-p> :CtrlSpace<CR>
"let g:ctrlspace_default_mapping_key = "<C-m>"

"EasyGrep
"let g:EasyGrepFilesToExclude = "cscope.*,tags,*.o"
"let g:EasyGrepCommand = 1
"let g:EasyGrepWindow = 1

"YCM
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tag_files = 1
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

"Unit
"nnoremap <leader>f :Unite file<CR>
"nnoremap <leader>f :Unite -start-insert file<CR>
""vim-ctrlspace
"set hidden
"function! HideNumber()
  "if(&relativenumber == &number)
    "set relativenumber! number!
  "elseif(&number)
    "set number!
  "else
    "set relativenumber!
  "endif
  "set number?
"endfunc
"nnoremap <F2> :call HideNumber()<CR>

"NerdTree
nnoremap <F3> :TagbarClose<cr>:NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=0
let NERDTreeChDirMode=2
let NERDTreeHijackNetrw=0
let NERDTreeMouseMode=3
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.a$','\.tgz','\.so','\.o$']

"tagbar
nmap <F4> :TagbarToggle<CR>
let g:tagbar_width = 30
let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_singleclick = 1
let g:tagbar_type_cpp = {
            \ 'ctagstype' : 'c++',
            \ 'kinds'     : [
            \ 'd:macros:1:0',
            \ 'p:prototypes:1:0',
            \ 'g:enums',
            \ 'e:enumerators:0:0',
            \ 't:typedefs:0:0',
            \ 'n:namespaces',
            \ 'c:classes',
            \ 's:structs',
            \ 'u:unions',
            \ 'f:functions',
            \ 'm:members:0:0',
            \ 'v:variables:0:0'
            \ ],
            \ 'sro'        : '::',
            \ 'kind2scope' : {
            \ 'g' : 'enum',
            \ 'n' : 'namespace',
            \ 'c' : 'class',
            \ 's' : 'struct',
            \ 'u' : 'union'
            \ },
            \ 'scope2kind' : {
            \ 'enum'      : 'g',
            \ 'namespace' : 'n',
            \ 'class'     : 'c',
            \ 'struct'    : 's',
            \ 'union'     : 'u'
            \ }
            \ }
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

"set background=dark
set t_Co=256
let g:rehash256 = 1
let g:molokai_original = 1
let g:solarized_termcolors=256
"colorscheme solarized
"colorscheme molokai
"set term=xterm-256color
"set term=xterm

" 解决与 YCM 插件的冲突
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"ack 搜索代码
let g:ackprg = "ack"
nmap <F2> :Ack -i --nocolor <cword><CR>

"FOR GO
"autocmd FileType go nmap <leader>b  <Plug>(go-build)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
     call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
     call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_version_warning = 0
