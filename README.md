# dsc_symbols
symbol dumps of iOS shared caches


This script will extract the shared cache and make a file tree that matches the images in the dsc. 
* *Symbols that begin with || mean they are defined (implemented in that module)*
* *Symbols that begin with __ mean they are undefined and referenced in a different module
* Undefined symbols will include the module its referenced in, defined symbols will include the Mach-o segment/section it's included in

## Howto

git clone, then...

List currently available iOS versions to compare
```
git branch -r
```

Compare all the new shit in libsystem_c.dylib from iOS 14.0.0 -> 15.7.0

```
git diff 14.0.0:usr/lib/system/libsystem_c.dylib 15.7.0:usr/lib/system/libsystem_c.dylib
```

List all modules that were removed between iOS 14.0.0 and iOS 15.7.0
```
git diff 14.0.0 15.7.0 --diff-filter=D --name-status
```

List all modules that were created between iOS 14.0.0 and iOS 15.7.0
```
git diff 14.0.0 15.7.0 --diff-filter=A --name-status
```

```
git diff  14.0.0 15.7.0  **/libsystem_c.dylib
```


