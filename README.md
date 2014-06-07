Installation
============

```bash
make
````

Running the command without any arguments will print usage.

Usage
=====

Right now there are only two commands. `set` and `get`. EASY.

Set example:

````
λ:~/src/BashDB ./bashdb set test test2
````

Get example:
````
λ:~/src/BashDB ./bashdb get test
test2
λ:~/src/BashDB
````


Caveats
=======

* You can't use strings with any special characters in them for keys OR values.
  This is because bash interprets string encased arguments 'blah blah blah' to
  functions as multiple values. Kind of dumb.
* I have no idea what happens when you overwrite a chunk of data.
* If you hit the upper limit of the `bashdb_data.meta` file (currently 4 MB) I
  have no idea what happens.
* There are fucking globals everywhere
* You can't delete anything
* `bashdb` just assumes that you want to write the data to a directory wherever
  the bashdb command is being run
