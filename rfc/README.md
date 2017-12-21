# rfc.sh
basic commandline program that fetches rfc txt documents from
https://www.rfc-editor.org

## how to use:

```bash
rfc <help> # will return help page
rfc <index> # will return list of rfcs 
rfc <number> # will return rfc txt document.
```

it will perform a remote call to rfc-editor.org using curl. you have the option
to using unix redirection to output to a file or pipe to another program if you
so wish. 
