int test1([int? a]) => a ?? 10;

int test2([int? a]) {
  a ??= 10;
  return a;
}

Function createFunction(String firstString) {
  return (String secondString) => firstString + secondString;
}

int testDefaultNamedParameter({int i = 0}) => i;
int tetsDefaultOptionalParameter([int i = 0]) => i;

mixin PaintableMixin {
  String color = "white";
}

class Symbol with PaintableMixin {
  String name;

  static final Map<String, Symbol> _cache = <String, Symbol>{};

  factory Symbol(String name) {
    return _cache.putIfAbsent(name, () => Symbol._internal(name));
  }

  Symbol._internal(this.name);

  void draw() => print("Draw $color $name symbol.");
}

void main() {
  // Test ?? operator
  assert(test1() == 10);
  assert(test1(20) == 20);

  // Test ??= operator
  assert(test2() == 10);
  assert(test2(20) == 20);

  // Function closure test
  var func1 = createFunction("Hello ");
  var func2 = createFunction("Hi ");

  assert(func1("world") == "Hello world");
  assert(func2("world") == "Hi world");

  // Default parameters test
  assert(testDefaultNamedParameter() == 0);
  assert(tetsDefaultOptionalParameter() == 0);

  // Mixin, factory constructor
  var symbol1 = Symbol("Asterisk")..color = "green";
  symbol1.draw();

  var symbol2 = Symbol("Asterisk");
  symbol2.draw();

  // List
  var list1 = [1, 2, 3];
  var list2 = [...list1, 4, 5];
  var list = list2 + [6, 7];

  list.add(8);
  list.remove(8);
  list.addAll([8, 9, 10]);

  assert(list.length == 10);
  assert(list.any((element) => element > 9));
  assert(list.every((element) => element < 11));
  assert(list.contains(3));
  assert(list[9] == 10);
  assert(list.indexOf(6) == 5);

  list.shuffle();
  print(list);

  list.sort();
  print(list);

  list.clear();
  assert(list.length == 0);

  // Set
  var set = {1, 2, 3};

  set.add(3);
  print(set);

  print(set.difference({1, 2}));
  print(set.union({2, 3, 4, 5}));

  // Map
  var map = {1: "one", 2: "two", 3: "three"};

  map.putIfAbsent(2, () => "two");
  map[1] = "1";
  print(map);
  print(map.keys);
  print(map.values);
}
