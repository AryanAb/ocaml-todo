<div align="center">

<h1>
<code>todo</code>
<br clear="all" />
</h1>
</div>

`todo` is a command line tool for simple to-do list management.

## Features

### Add

Adds a task to the to-do list. Takes one string argument which is the description of the task that is to be added to the list.

```shell
$ todo add "Task 1"
```

### List

Lists the tasks currently on the to-do list. 

Could use both `list` or `ls` to invoke this functionality.

```shell
$ todo list
Task 1
Task 2
Task 3
```

### Remove

Removes a task from the to-do list. Takes one integer argument which is the line number of the task that is to be removed.

Could use both `remove` or `rm` to invoke this functionality.

```shell
$ todo rm 2
$ todo ls
Task 1
Task 3
```

## Build

To build this project, use Dune. Simply run:

```shell
$ dune build
```
