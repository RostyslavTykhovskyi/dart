class Person {
  String? name;
  String? surname;
  int? _age;

  Person({this.name, this.surname, age}) : _age = age;

  int? get age => _age;

  void set age(int? age) => _age = age;

  String toString() => "Person: {name: $name, surname: $surname, age: $_age}";
}

void main() {
  var person = Person(name: "Rostyslav", surname: "Tykhovskyi");

  print(person);

  person.age = 20;

  print(person);
}
