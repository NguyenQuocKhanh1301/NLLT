% Định nghĩa các công thức món ăn

recipe('Salad Rau Tron', ['rau', 'dua leo', 'ca chua']).
recipe('Trung Chien', ['trung', 'hanh']).
recipe('Ga Ran', ['thit ga', 'bot']).
recipe('Pho Bo', ['thit bo', 'banh pho', 'rau thom', 'hanh', 'que']).
recipe('Bun Cha', ['thit heo', 'bun', 'rau song', 'nuoc mam', 'toi', 'ot']).
recipe('Com Chien Hai San', ['com', 'tom', 'muc', 'trung', 'hanh']).
recipe('Mi Xao Hai San', ['mi', 'tom', 'muc', 'rau cai', 'hanh', 'toi']).
recipe('Lau Thai', ['tom', 'muc', 'thit bo', 'nam', 'rau thom', 'sa', 'la chanh']).
recipre('Banh Mi Thit', ['banh mi', 'thit heo', 'rau', 'nuoc mam', 'ot']).
recipe('Lau Hai San', ['tom', 'muc', 'ngheu', 'rau thom', 'nam', 'gia vi']).

%  Định nghĩa các nguyên liệu thay thế
replacement('thit ga', 'thit bo').
replacement('thit heo', 'thit bo').
replacement('nuoc mam', 'tuong').
replacement('rau', 'rau thom').
replacement('hanh', 'toi').
replacement('ca chua', 'dua leo').
replacement('bot', 'bot mi').
replacement('com', 'mi').

% Kiểm tra xem danh sách nguyên liệu có thể bao gồm cả nguyên liệu thay thế
ingredient_available(Ingredient, Ingredients) :-
 member(Ingredient, Ingredients).
ingredient_available(Ingredient, Ingredients) :-
 replacement(Ingredient, Alternative),
 member(Alternative, Ingredients).

%  Kiểm tra nếu tất cả nguyên liệu (hoặc thay thế của chúng) đều có trong danh sách nguyên liệu
all_ingredients_available([], _).
all_ingredients_available([H | T], Ingredients) :-
 ingredient_available(H, Ingredients),
 all_ingredients_available(T, Ingredients).

%  Gợi ý món ăn với hỗ trợ thay thế nguyên liệu

suggest_recipe(Ingredients, Recipe) :-
 recipe(Recipe, Required),
 all_ingredients_available(Required, Ingredients).