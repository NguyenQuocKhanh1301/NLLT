**Installed SWI Prolog**
Test with terminal:
```sh
swipl -s recipes.pl -g "findall(R, suggest_recipe(['hanh','trung'], R), List), writeln(List)." -t halt
```

**Run app**

```sh
node app.js
```
