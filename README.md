vim-alt
=======

vim-alt is a simple Vim plugin for opening related/alternate
files.

Installation
------------

If you're using pathogen:

    git clone https://github.com/viking/vim-alt ~/.vim/bundle/vim-alt

Or place the `alt.vim` file into your `~/.vim/plugin` directory.

Usage
-----

Place a file called `.altrc` in your project root directory with
your configuration. The file should contain a Vim list of lists,
where each sublist has two elements. The first element is a file
pattern (same format as you would use in a Vim search). The second
element is the file you want to be the alternate file.

Example:

    [
      ['^src/js/\([^/]\+/\)*\(.\+\)\.js$', 'test/js/\1test_\2.js'],
      ['^test/js/\([^/]\+/\)*test_\(.\+\)\.js$', 'src/js/\1\2.js']
    ]

Using this example, the `src/js/models/foo.js` file would match
with `test/js/models/test_foo.js` and vice versa. You can use any
pattern you want.

When you want to open the alternate file, run one of the follow
commands:

* `:A` - open the alternate file using the `:ex` command
* `:AS` - open the alternate file using the `:sp` command
* `:AV` - open the alternate file using the `:vs` command
* `:AT` - open the alternate file using the `:tabe` command

Note that you must run Vim in the same working directory as the
`.altrc` file.
