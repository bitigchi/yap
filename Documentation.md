#  Documentation

Reminder: `yap <command> -h/--help` always displays available options and flags.

## Adding to-do items

Adding to-do items are very simple.

`yap add "Do laundry"`

If you prefer to use `stdin`, that's available as well.

`yap add`<Enter>

This will enter stdin mode. When you're done, just press Enter.

## Listing to-do items

`yap list` displays remaining to-do.

`yap list -c` displays recently completed to-dos.

`yap list -a` displays both remaining and completed to-dos.

`yap list -d` flag will display the creation date next to the item number.

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
