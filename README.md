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

Lookup word under cursor in a :split (using :StarDictCursor command)
--------------
![:split mode of vim-stardict](http://www.mediafire.com/convkey/bc14/a6nv3auv11g61226g.jpg)

Lookup word in a :vsplit (using :StarDict command)
---------------
![:vsplit mode of vim-stardict](http://www.mediafire.com/convkey/3ef1/js0cp9p475fse5q6g.jpg)

Lookup word in Bash (using 'stardict' command)
---------------
![Using vim-stardict from Bash](http://www.mediafire.com/convkey/c799/jasp8h8pimlhbat6g.jpg)

Redirect Bash output to Vim (using 'vstardict' command)
---------------
![Redirect vim-stardict Bash output to Vim](http://www.mediafire.com/convkey/f4a6/xy7slj2jsdcrpsu6g.jpg)


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

## 1. Vim:
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


## 2. Bash:
To lookup the meaning of a word with no-space-in-between:

	stardict random_word_with_no_spaces

To lookup the meaning of a word with spaces-in-between, put it inside
quotation marks (both double and single quotes are acceptable):

	stardict "random word with spaces"
	stardict 'random word with spaces'

To look up the meaning of several words (either no-spaces-in-between or
spaces-in-between):

	stardict first_word second_word "third word" 'fourth word'
	stardict "first word" 'second word'

To view the meaning of word in Vim from Bash:

	vstardict first_word second_word "third word" 'fourth word'


Configuration
=============

## 1. Vim:
Sample configuration for your `.vimrc` (more in the official documentation)

```vim
    " Make vim-stardict split open in a :split (default value)
    let g:stardict_split_horizontal = 1

    " Set vim-stardict split width (or height) to 20 based on
    " whether vim-stardict split is a :vsplit (or :split)
	let g:stardict_split_size = 20

	" This option should only be set if your Vim is compiled with +python and
	" -python3 options (in other words, if your Vim doesn't support Python 3)
	" let g:stardict_prefer_python3 = 0

    " Map vim-stardict's commands
    nnoremap <leader>sw :StarDict<Space>	    " Ready for typing the word in
	nnoremap <leader>sc :StarDictCursor<CR>     " Lookup the word under the cursor
```

## 2. Bash:
Sample configuration for your `.bashrc` (supposed you use [Vundle][3] to manage
your plugins):

```bash
	# Source the stardict.sh file in the vim-stardict installation directory
	if [[ -f ${HOME}/.vim/bundle/vim-stardict/bash/stardict.sh ]]; then
		source ${HOME}/.vim/bundle/vim-stardict/bash/stardict.sh
	fi

	# To avoid typing the long & daunting 'stardict' & 'vstardict' commands,
	# you can alias it to something else
	alias whatis="stardict"
	alias whatvim="vstardict"
```

You can change **whatis** and **whatvim** above to whatever aliases you like.
Also, you can change the path to source the **stardict.sh** file above, if your
Vim plugin directory is different.

With the above configuration, you can issue these commands to find meaning of
words:

	whatis first_word second_word "third word" 'fourth word'
	whatvim first_word second_word "third word" 'fourth word'


Credits
=======

* Special thanks to [chusiang](https://github.com/chusiang/) from whom I got
the original idea from.

[0]: http://sdcv.sourceforge.net/
[1]: https://github.com/tpope/vim-pathogen
[2]: https://github.com/Shougo/neobundle.vim
[3]: https://github.com/gmarik/vundle

