
Scripts for the presentation 'Treat Scripts Like Software'

https://github.com/jkstill/treat-scripts-like-software


= assert.sh

Demo of using an assert function in Bash


./assert.sh  tvar alpha 'this is a 9 test'

Error!
value of variable tvar is not ALPHA
tvar: this is a 9 test


./assert.sh  tvar alpha 'this is a test'

OK!


./assert.sh  tvar hex 'FFFF FFE0'

OK!


./assert.sh  tvar hex 'FGFF FFE0'

Error!
value of variable tvar is not HEX
tvar: FGFF FFE0


./assert.sh  tvar number 123,456.20

OK!


./assert.sh  tvar number 123,x456.20

Error!
value of variable tvar is not NUMBER
tvar: 123,x456.20

= bash-regex.sh

Example of using Bash regex matching

= global-variables.sh

Example of setting global variables to read only

= myscript.sh

put a few elements together in a script

- uninitialized-variable.sh

not checking for variable initialization can be dangerous


$ ./uninitialized-variable.sh

Removing: /u01/app/oracle/

$ ./uninitialized-variable.sh  tmp

Removing: /u01/app/oracle/tmp


