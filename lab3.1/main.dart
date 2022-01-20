import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Gmail';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedIndex;
  late ScrollController _scrollController;
  late List<Widget> _tabs;
  late List<Email> _emails;
  late List<Email> _starred;

  void addStarred(email) {
    setState(() {
      _starred.add(email);
    });
  }

  void removeStarred(email) {
    setState(() {
      _starred.remove(email);
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 2);
    _emails = <Email>[];
    _starred = <Email>[];

    for (var i = 0; i < 15; i++) {
      _emails.add(Email(i));
    }
  }

  void generateWidgetOptions(context) {
    _tabs = <Widget>[
      ListView(
        controller: _scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Text(
                    "Primary",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    for (Email e in _emails)
                      EmailWidget(
                          email: e,
                          isStarred: _starred.contains(e),
                          addStarred: addStarred,
                          removeStarred: removeStarred)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('New meeting'),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 40.0),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Join with a code',
                    style: TextStyle(
                      color: Colors.blue[900],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(
                      side: BorderSide(color: Colors.black45),
                    ),
                    elevation: 0.0,
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 40.0),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.black26,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "Get a link you can share",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: Text(
                      "Tap New meeting to get a link you can send to people you want to meet with"),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    generateWidgetOptions(context);

    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(_starred.length),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Search in mail',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
        ),
      ),
      actions: [
        SizedBox(
          width: 50,
          child: PopupMenuButton(
            icon: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://lh5.googleusercontent.com/-HUHDOIBRdOI/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rexMlk9Sa711erdbDClucBXz-kLLQ/photo.jpg"),
              backgroundColor: Colors.red,
            ),
            itemBuilder: (BuildContext context) {
              return const [];
            },
          ),
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: Colors.grey[200],
      iconTheme: IconThemeData(color: Colors.grey[1000]),
    );
  }

  Center _buildBody() {
    return Center(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: _tabs,
      ),
    );
  }

  Drawer _buildDrawer(starred) {
    return Drawer(
      child: Container(
        color: Colors.grey[200],
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 60,
                child: DrawerHeader(
                  child: Text(
                    'Gmail',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.all_inbox,
                  color: Colors.black,
                ),
                title: Text('All inboxes'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.inbox,
                  color: Colors.black,
                ),
                title: Text('Primary'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.people_alt_outlined,
                  color: Colors.black,
                ),
                title: Text('Social'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.local_offer_outlined,
                  color: Colors.black,
                ),
                title: Text('Promotions'),
              ),
              const ListTile(
                title: Text(
                  'ALL LABELS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Starred'),
                    Text(starred > 0 ? '$starred' : '')
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: Colors.black,
                ),
                title: Text('Snoozed'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.label_important_outline,
                  color: Colors.black,
                ),
                title: Text('Important'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
                title: Text('Sent'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.schedule_send_outlined,
                  color: Colors.black,
                ),
                title: Text('Scheduled'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.outbox_outlined,
                  color: Colors.black,
                ),
                title: Text('Outbox'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.insert_drive_file_outlined,
                  color: Colors.black,
                ),
                title: Text('Drafts'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.mail_outlined,
                  color: Colors.black,
                ),
                title: Text('All mail'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.report_gmailerrorred,
                  color: Colors.black,
                ),
                title: Text('Spam'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.delete_outlined,
                  color: Colors.black,
                ),
                title: Text('Trash'),
              ),
              const ListTile(
                title: Text(
                  'GOOGLE APPS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
                title: Text('Calendar'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                ),
                title: Text('Contacts'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                ),
                title: Text('Settings'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Colors.black,
                ),
                title: Text('Help & feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.mail_rounded),
          activeIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue[200],
            ),
            child: const Icon(Icons.mail),
          ),
          label: 'Mail',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.video_camera_front_outlined),
          activeIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue[200],
            ),
            child: const Icon(Icons.video_camera_front),
          ),
          label: 'Meet',
        ),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: Colors.grey[200],
      selectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      label: const Text(
        'Compose',
        style: TextStyle(color: Colors.black),
      ),
      icon: const Icon(
        Icons.mode_edit_outlined,
        color: Colors.black,
      ),
      backgroundColor: Colors.blue[200],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class Email {
  final int id;

  const Email(this.id);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Email && other.id == id;
}

class EmailWidget extends StatelessWidget {
  final Email email;
  final bool isStarred;
  final Function addStarred;
  final Function removeStarred;

  const EmailWidget(
      {Key? key,
      required this.email,
      required this.isStarred,
      required this.addStarred,
      required this.removeStarred})
      : super(key: key);

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://lh5.googleusercontent.com/-HUHDOIBRdOI/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rexMlk9Sa711erdbDClucBXz-kLLQ/photo.jpg"),
              backgroundColor: Colors.red,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Name",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  "Subject of the email",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  "Oct 12",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              StarredButton(
                  email: email,
                  isStarred: isStarred,
                  addStarred: addStarred,
                  removeStarred: removeStarred)
            ],
          ),
        ],
      ),
    );
  }
}

class StarredButton extends StatefulWidget {
  bool isStarred;
  final Email email;
  final Function addStarred;
  final Function removeStarred;

  StarredButton(
      {Key? key,
      required this.email,
      required this.isStarred,
      required this.addStarred,
      required this.removeStarred})
      : super(key: key);

  @override
  _StarredButtonState createState() => _StarredButtonState();
}

class _StarredButtonState extends State<StarredButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isStarred
            ? widget.removeStarred(widget.email)
            : widget.addStarred(widget.email);
        setState(() {
          widget.isStarred = widget.isStarred ? false : true;
        });
      },
      child: Icon(
        widget.isStarred ? Icons.star_outlined : Icons.star_outline_sharp,
        color: widget.isStarred ? Colors.blue : Colors.black,
        size: 25,
      ),
    );
  }
}
