**Installed SWI Prolog**
Test with terminal:
```sh
swipl -s recipes.pl -g "findall(R, suggest_recipe(['hanh','trung'], R), List), writeln(List)." -t halt
```

**Run app**
direction to file food-suggestion-app, run app
```sh
cd food-suggestion-app
node app.js
```
