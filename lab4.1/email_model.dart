import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class EmailModel extends ChangeNotifier {
  late List<Email> emails;
  late List<Email> starred;

  EmailModel() {
    starred = <Email>[];
    emails = <Email>[];

    fetchEmails().then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        emails = list.map((model) => Email.fromJson(model)).toList();
      }
      notifyListeners();
    });
  }

  Future fetchEmails() {
    return http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
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
  final int _id;
  final String _title;
  final String _body;

  const Email(this._id, this._title, this._body);

  Email.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _title = json['title'],
        _body = json['body'].replaceAll("\n", " ");

  int get id => _id;

  String get title => _title;

  String get body => _body;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Email && other.id == id;
}
