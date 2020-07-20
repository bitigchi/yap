# yap

yap (pronounced y-ah-p) is a simple to-do list written in Swift. It allows you to add to-do 
items, mark them as "complete", set due dates, remove items, and purge entries. yap is 
available on Linux and macOS.

![Main](.github/main.png)

## Installation

Go to the Releases page and get the source code.

* Make sure you have $HOME in your $PATH
* Run `make install` inside the project directory

This will build and install `yap` in your home directory. Alternatively, you can run
`swift build`, then get the binary from `.build/release` folder.

## Help

* Type `yap` or `yap <subcommand> -h/--help` to see available options and flags.
* See [Documentation](Documentation.md)

## Known issues

* It might be necessary to manually import to-do items after an update until v1.0

## Roadmap

### Short-term

* Automatic export of items
* Add unit tests

### Long-term

* Add curses interface

Pull requests and bug reports are welcome.
