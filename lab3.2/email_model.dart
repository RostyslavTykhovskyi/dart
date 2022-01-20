import 'package:flutter/cupertino.dart';

class EmailModel extends ChangeNotifier {
  late List<Email> emails;
  late List<Email> starred;

  EmailModel() {
    emails = <Email>[];
    starred = <Email>[];

    for (var i = 0; i < 15; i++) {
      emails.add(Email(i));
    }
  }

  void addStarred(email) {
    starred.add(email);
    notifyListeners();
  }

  void removeStarred(email) {
    starred.remove(email);
    notifyListeners();
  }
}

@immutable
class Email {
  final int id;

  const Email(this.id);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Email && other.id == id;
}
