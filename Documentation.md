#  Documentation

Reminder: `yap <command> -h/--help` always displays available options and flags.

## Adding to-do items

Adding to-do items are very simple.

`yap add "Do laundry"`

If you prefer to use `stdin`, that's available as well.

`yap add`<Enter>

This will enter stdin mode. When you're done, just press Enter.

## Setting due dates

Easiest way to set a due date is doing it while adding the to-do. Just use:

`yap add <item> <due-date>`.

`<due-date>` will accept dates in your current locale. You can also use predefined
dates, like:

* `yap add <item> [tomorrow, nextweek, nextmonth, nextyear]`

Select one from the predefined dates, it will set the due date by adding a week, month,
or year to the current date.

## Listing to-do items

`yap` displays remaining to-do with item due date `yap` will assume the due date is
today if none entered while adding.

`yap -c` displays recently completed to-dos.

`yap -a` displays both remaining and completed to-dos.

`yap -n` flag will not display the due date.

Flags can be combined.

## Marking items as "complete"

When you complete an item, use the ID number to the left of the to-do to mark it as
complete. For example:

`yap cm 2`

If you mark an item as "done" by mistake, you can use the same ID number with `-u` flag
to revert the operation.

`yap cm 2 -u/--undone`

## Cleaning lists

`yap purge` by default purges the "completed" list. Be wary, if you add an `-a` flag, it
will purge everything.

`yap purge -a/--all`

## Silent mode

Using the `-s/--silent` flag with `cm` and `purge` command will not display an entry
with all the items iterated. Instead, only one entry with a summary will be displayed.

## Application data

yap saves to-do data at following locations:

* macOS: ~/Library/Application Support/
* Linux: ~/.local/share/
