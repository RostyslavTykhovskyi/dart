import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'email_model.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => EmailModel(),
      child: const MyApp(),
    ));

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
  bool _darkTheme = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 2);
    _loadTheme();
  }

  void changeTheme(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkTheme', theme);
    setState(() {
      _darkTheme = prefs.getBool('darkTheme') ?? false;
    });
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkTheme = prefs.getBool('darkTheme') ?? false;
    });
  }

  void generateWidgetOptions(context) {
    _tabs = <Widget>[Emails(scrollController: _scrollController), const Meet()];
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
      body: _buildBody(),
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
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
            onSelected: (value) {
              changeTheme(value);
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  child: Text("Light Theme"),
                  value: false,
                ),
                PopupMenuItem(
                  child: Text("Dark Theme"),
                  value: true,
                )
              ];
            },
          ),
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: _darkTheme ? Colors.grey[400] : Colors.grey[100],
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
        color: _darkTheme ? Colors.grey[400] : Colors.grey[100],
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
                title: Consumer<EmailModel>(
                  builder: (context, model, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Starred'),
                        Text(model.starred.isNotEmpty
                            ? '${model.starred.length}'
                            : ''),
                      ],
                    );
                  },
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
      backgroundColor: _darkTheme ? Colors.grey[400] : Colors.grey[100],
      selectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MessageScreen()),
        );

        if (result != null && result.length > 0) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('$result')));
        }
      },
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

class EmailWidget extends StatelessWidget {
  final Email email;
  final bool isStarred;

  const EmailWidget({Key? key, required this.email, required this.isStarred})
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
              children: [
                const Text(
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
                  email.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  email.body,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
              _StarredButton(
                email: email,
                isStarred: isStarred,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StarredButton extends StatefulWidget {
  final Email email;
  bool isStarred;

  _StarredButton({Key? key, required this.email, required this.isStarred})
      : super(key: key);

  @override
  _StarredButtonState createState() => _StarredButtonState();
}

class _StarredButtonState extends State<_StarredButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.isStarred
            ? Provider.of<EmailModel>(context, listen: false)
                .removeStarred(widget.email)
            : Provider.of<EmailModel>(context, listen: false)
                .addStarred(widget.email);
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

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type your message'),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Message',
            ),
            onSubmitted: (String value) {
              Navigator.pop(context, value);
            },
          ),
        ),
      ),
    );
  }
}

class Emails extends StatelessWidget {
  final ScrollController scrollController;

  const Emails({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(context) {
    return ListView(
      controller: scrollController,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Text(
                  "Primary",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Consumer<EmailModel>(builder: (context, model, child) {
                return Column(
                  children: <Widget>[
                    for (Email e in model.emails)
                      EmailWidget(
                        email: e,
                        isStarred: model.starred.contains(e),
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class Meet extends StatefulWidget {
  const Meet({Key? key}) : super(key: key);

  @override
  State<Meet> createState() => _Meet();
}

class _Meet extends State<Meet> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation1;
  late Animation sizeAnimation2;
  late Animation sizeAnimation3;
  late Animation sizeAnimation4;
  late Animation sizeAnimation5;
  late Animation sizeAnimation6;
  late Animation sizeAnimation7;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    colorAnimation = ColorTween(begin: Colors.blue, end: Colors.green)
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    sizeAnimation1 = Tween<double>(begin: 30.0, end: 130.0).animate(controller);
    sizeAnimation2 = Tween<double>(begin: 150.0, end: 50.0).animate(controller);
    sizeAnimation3 = Tween<double>(begin: 50.0, end: 160.0).animate(controller);
    sizeAnimation4 = Tween<double>(begin: 180.0, end: 90.0).animate(controller);
    sizeAnimation5 = Tween<double>(begin: 70.0, end: 110.0).animate(controller);
    sizeAnimation6 = Tween<double>(begin: 10.0, end: 180.0).animate(controller);
    sizeAnimation7 = Tween<double>(begin: 130.0, end: 20.0).animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
  }

  @override
  Widget build(context) {
    return Column(
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
            children: [
              SizedBox(
                height: 200,
                width: 147,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: sizeAnimation1.value,
                      width: 20,
                      color: colorAnimation.value,
                    ),
                    Container(
                      height: sizeAnimation2.value,
                      width: 20,
                      color: colorAnimation.value,
                    ),
                    Container(
                      height: sizeAnimation3.value,
                      width: 20,
                      color: colorAnimation.value,
                    ),
                    Container(
                      height: sizeAnimation4.value,
                      width: 20,
                      color: colorAnimation.value,
                    ),
                    Container(
                      height: sizeAnimation5.value,
                      width: 20,
                      color: colorAnimation.value,
                    ),
                    Container(
                      height: sizeAnimation6.value,
                      width: 20,
                      color: colorAnimation.value,
                    ),
                    Container(
                      height: sizeAnimation7.value,
                      width: 20,
                      color: colorAnimation.value,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "Get a link you can share",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 240,
                child: Text(
                    "Tap New meeting to get a link you can send to people you want to meet with"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
