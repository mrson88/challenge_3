// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:chanllenge_3/themes/app_colors.dart';

import 'package:chanllenge_3/themes/app_styles.dart';

Widget scrollViewVertical(List chatUser, context) {
  String hour(int index) {
    return chatUser[index]['created_at'].toString().split(':')[1];
  }

  String minute(int index) {
    return chatUser[index]['created_at'].toString().split(':')[2].split('.')[0];
  }

  return Container(
    padding: const EdgeInsets.only(left: 15),
    height: 400,
    child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(
              chatUser.length,
              (index) => Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(children: [
                      Stack(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(chatUser[index]['user']
                                        ['picture']['medium']),
                                    fit: BoxFit.cover)),
                          ),
                          chatUser[index]['unread_count'] > 0
                              ? Positioned(
                                  top: 40,
                                  left: 39,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.textColor, width: 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                          '${chatUser[index]['unread_count']}'),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${chatUser[index]['user']['name']}',
                                    style: AppStyles.h1,
                                  ),
                                  Text(
                                    int.parse(hour(index = index)) < 12
                                        ? '${hour(index = index)} '
                                            ': ${minute(index = index)} AM'
                                        : '0${int.parse(hour(index = index)) - 12} '
                                            ': ${minute(index = index)} PM',
                                    style: AppStyles.h2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 5.0,
                                  direction: Axis.vertical,
                                  children: [
                                    Text('${chatUser[index]['text']}',
                                        style: AppStyles.h2,
                                        maxLines: 1,
                                        textAlign: TextAlign.left),
                                  ]),
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              child: Container(
                                color: Colors.black,
                                height: 2,
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  )),
        )),
  );
}
