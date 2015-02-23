# vim-stardict

A Vim plugin for looking up meaning of words inside Vim using the **StarDict
Command-Line Version (SDCV)** dictionary program.

In addition to opening a Vim split and populating it with the output of StarDict
Command-Line Version (SDCV), **vim-stardict** takes advantage of Vim syntax
highlighting and some basic regexes to present the words' definitions to the
users in an organized and user-friendly way.

The plugin was inspired and originally a fork of
[chusiang/vim-sdcv](https://github.com/chusiang/vim-sdcv).

Screenshots
===========

Lookup word under cursor (using :split)
--------------
![:split mode of vim-stardict](http://www.mediafire.com/convkey/bc14/a6nv3auv11g61226g.jpg)

Lookup word using :StarDict command (using :vsplit)
---------------
![:vsplit mode of vim-stardict](http://www.mediafire.com/convkey/3ef1/js0cp9p475fse5q6g.jpg)

Installation
============

Before installing **vim-stardict** , the following applications need to be
already installed in your computer:

* [SDCV][0]

There are several ways to install **vim-stardict**:

* [Pathogen][1]
    * `git clone https://github.com/phongvcao/vim-stardict.git`
* [NeoBundle][2]
    * `NeoBundle 'phongvcao/vim-stardict'`
* [Vundle][3]
    * `Plugin 'phongvcao/vim-stardict'`
* Manual
    * Copy all of the files into your `~/.vim` directory

Usage
=====

To lookup the meaning of a word with no-space-in-between:

	:StarDict random_word_with_no_spaces

To lookup the meaning of a word with spaces-in-between, put it inside
quotation marks (both double and single quotes are acceptable):

	:StarDict "random word with spaces"
	:StarDict 'random word with spaces'

To look up the meaning of several words (either no-spaces-in-between or
spaces-in-between):

	:StarDict first_word second_word "third word" 'fourth word'
	:StarDict "first word" 'second word'

To lookup the meaning of a word under-the-cursor:

	:StarDictCursor

Configuration
=============

Sample configuration for you `.vimrc` (more in the official documentation)

```vim
    " Make vim-stardict split open in a :split (default value)
    let g:stardict_split_horizontal = 1

    " Set vim-stardict split width (or height) to 20 based on
    " whether vim-stardict split is a :vsplit (or :split)
	let g:stardict_split_size = 20

    " Map vim-stardict's commands
    nnoremap <leader>sw :StarDict<Space>	    " Ready for typing the word in
	nnoremap <leader>sc :StarDictCursor<CR>     " Lookup the word under the cursor
```

Credits
=======

* Special thanks to [chusiang](https://github.com/chusiang/) from whom I got
the original idea from.

[0]: http://sdcv.sourceforge.net/
[1]: https://github.com/tpope/vim-pathogen
[2]: https://github.com/Shougo/neobundle.vim
[3]: https://github.com/gmarik/vundle

