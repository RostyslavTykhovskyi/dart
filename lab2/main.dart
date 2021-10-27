import 'dart:ui';
import 'dart:math' as math;

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

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 2);
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
                getMailWidgets(15, context),
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
      drawer: _buildDrawer(),
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

  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.grey[200],
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            children: const <Widget>[
              SizedBox(
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
              ListTile(
                leading: Icon(
                  Icons.all_inbox,
                  color: Colors.black,
                ),
                title: Text('All inboxes'),
              ),
              ListTile(
                leading: Icon(
                  Icons.inbox,
                  color: Colors.black,
                ),
                title: Text('Primary'),
              ),
              ListTile(
                leading: Icon(
                  Icons.people_alt_outlined,
                  color: Colors.black,
                ),
                title: Text('Social'),
              ),
              ListTile(
                leading: Icon(
                  Icons.local_offer_outlined,
                  color: Colors.black,
                ),
                title: Text('Promotions'),
              ),
              ListTile(
                title: Text(
                  'ALL LABELS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                ),
                title: Text('Starred'),
              ),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: Colors.black,
                ),
                title: Text('Snoozed'),
              ),
              ListTile(
                leading: Icon(
                  Icons.label_important_outline,
                  color: Colors.black,
                ),
                title: Text('Important'),
              ),
              ListTile(
                leading: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
                title: Text('Sent'),
              ),
              ListTile(
                leading: Icon(
                  Icons.schedule_send_outlined,
                  color: Colors.black,
                ),
                title: Text('Scheduled'),
              ),
              ListTile(
                leading: Icon(
                  Icons.outbox_outlined,
                  color: Colors.black,
                ),
                title: Text('Outbox'),
              ),
              ListTile(
                leading: Icon(
                  Icons.insert_drive_file_outlined,
                  color: Colors.black,
                ),
                title: Text('Drafts'),
              ),
              ListTile(
                leading: Icon(
                  Icons.mail_outlined,
                  color: Colors.black,
                ),
                title: Text('All mail'),
              ),
              ListTile(
                leading: Icon(
                  Icons.report_gmailerrorred,
                  color: Colors.black,
                ),
                title: Text('Spam'),
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_outlined,
                  color: Colors.black,
                ),
                title: Text('Trash'),
              ),
              ListTile(
                title: Text(
                  'GOOGLE APPS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
                title: Text('Calendar'),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                ),
                title: Text('Contacts'),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                ),
                title: Text('Settings'),
              ),
              ListTile(
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

class Email extends StatelessWidget {
  final int number;

  const Email({Key? key, this.number = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.file_download,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.delete_outlined,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.mail_outlined,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
        ),
      ],
      backgroundColor: Colors.grey[200],
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  Hero _buildBody() {
    return Hero(
      tag: 'email$number',
      child: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Subject of the email",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Icon(Icons.star_border_outlined),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
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
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Oct 12",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "to me",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Icon(Icons.reply),
                        ),
                        const Icon(Icons.more_vert),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Icon(
                                Icons.reply,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Reply',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.black12),
                          ),
                          elevation: 0.0,
                          primary: Colors.white,
                          padding: const EdgeInsets.all(20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.reply_all,
                                color: Colors.black,
                              ),
                              Text(
                                'Reply all',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(
                              side: BorderSide(color: Colors.black12),
                            ),
                            elevation: 0.0,
                            primary: Colors.white,
                            padding: const EdgeInsets.all(20.0),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: const Icon(
                                  Icons.reply,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text(
                              'Forward',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.black12),
                          ),
                          elevation: 0.0,
                          primary: Colors.white,
                          padding: const EdgeInsets.all(20.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getMailWidgets(size, context) {
  List<Widget> list = <Widget>[];

  for (var i = 0; i < size; i++) {
    list.add(
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Email(number: i)),
          );
        },
        child: Hero(
          tag: 'email$i',
          child: Padding(
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
                  children: const [
                    Padding(
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
                    Icon(
                      Icons.star_outline_sharp,
                      size: 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  return Column(children: list);
}
