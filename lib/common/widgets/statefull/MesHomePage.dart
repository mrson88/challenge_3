
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:chanllenge_3/themes/app_assets.dart';
import 'package:chanllenge_3/themes/app_colors.dart';
import 'package:chanllenge_3/themes/app_styles.dart';
class MesHomePage extends StatefulWidget {
  const MesHomePage({Key? key}) : super(key: key);

  @override
  State<MesHomePage> createState() => _HomePageState();
}

int _selectedIndex = 0;
String hour = ['created_at'].toString().split(':')[1];
String minute = ['created_at'].toString().split(':')[2];

class _HomePageState extends State<MesHomePage> {
  List _user = [];
  List _chat = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String userResponse =
        await rootBundle.loadString('assets/data/users.json');
    final String chatResponse =
        await rootBundle.loadString('assets/data/chats.json');
    final userdata = await json.decode(userResponse);
    final chatted = await json.decode(chatResponse);

    setState(() {
      _user = userdata["results"];
      _chat = chatted["results"];

      // print(_user);
      // print(_chat);
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber[800],
        currentIndex: _selectedIndex,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/Home.png'),
            ),
            backgroundColor: AppColors.navigationColor,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/streams.png'),
            ),
            label: 'Streams',
            backgroundColor: AppColors.navigationColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/message.png'),
            ),
            label: 'Messages',
            backgroundColor: AppColors.navigationColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/Notification.png'),
            ),
            label: 'Notifications',
            backgroundColor: AppColors.navigationColor,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/profile.png'),
            ),
            label: 'Profiles',
            backgroundColor: AppColors.navigationColor,
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => setState(() {
                  readJson();
                  // print(_user);
                }),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textColor,
                  size: 28,
                ),
              ),
              TextButton(
                onPressed: () => setState(() {
                  readJson();
                  // print(_user);
                }),
                child: const Icon(
                  Icons.add,
                  color: AppColors.textColor,
                  size: 38,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, bottom: 24),
            child: const Text(
              'Messages',
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textColor),
            ),
          ),
          Container(
            color: Colors.black,
            child: const SizedBox(
              height: 1,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _user.isNotEmpty
                ? Row(
                    children: List.generate(_user.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 18, left: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 9),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(_user[index]
                                                ['picture']['medium']),
                                            fit: BoxFit.cover)),
                                  ),
                                  _user[index]['status'].toString() == 'online'
                                      ? Positioned(
                                          top: 45,
                                          left: 42,
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: AppColors.textColor,
                                                  width: 2.5),
                                            ),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            Text(
                              _user[index]['name'].toString(),
                              style: AppStyles.h1,
                            )
                          ],
                        ),
                      );
                    }),
                  )
                : Container(),
          ),
          Container(
            color: Colors.black,
            child: const SizedBox(
              height: 2,
            ),
          ),
          Container(
              height: 400,
              padding: const EdgeInsets.only(left: 20),
              child: ListView(
                children: List.generate(
                    _chat.length,
                    (index) => Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(_chat[index]
                                                        ['user']['picture']
                                                    ['medium']),
                                                fit: BoxFit.cover)),
                                      ),
                                      _chat[index]['unread_count'] > 0
                                          ? Positioned(
                                              top: 40,
                                              left: 39,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: AppColors.textColor,
                                                      width: 1),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      '${_chat[index]['unread_count']}'),
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 130,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${_chat[index]['user']['name']}',
                                          style: AppStyles.h2,
                                        ),
                                        Text(
                                          '${_chat[index]['created_at'].toString().split(':')[1]} '
                                          ': ${_chat[index]['created_at'].toString().split(':')[2].split('.')[0]}',
                                          style: AppStyles.h2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(
                                          bottom: 20, top: 20),
                                      child: Text(
                                        '${_chat[index]['text']}',
                                        style: AppStyles.h2,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
              ))
        ],
      ),
    );
  }
}
