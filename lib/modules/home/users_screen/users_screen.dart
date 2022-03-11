import 'package:bmi_calculator/models/users/users.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  String avatar = "https://avatars.githubusercontent.com/u/40515871?v=4";

  List<Users> listUsers = [
    Users(
        1,
        name: "Ahmed Wasfe",
        phone: "05992435704",
        image: "https://avatars.githubusercontent.com/u/40515871?v=4"),
    Users(
        2,
        name: "Mohammed Ali",
        phone: "0599925091",
        image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
    Users(
        3,
        name: "Mahmoued MN",
        phone: "123456789",
        image: "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8dXNlcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
    Users(
        4,
        name: "Khaled KH",
        phone: "987512015",
        image: "https://images.unsplash.com/photo-1543269664-7eef42226a21?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHVzZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    Users(
        5,
        name: "Ali AM",
        phone: "1257751065",
        image: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHVzZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    Users(
        2,
        name: "Mohammed Ali",
        phone: "0599925091",
        image: "https://images.unsplash.com/photo-1587614382231-d1590f0039e7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHVzZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    Users(
        3,
        name: "Mahmoued MN",
        phone: "123456789",
        image: "https://images.unsplash.com/photo-1559526323-cb2f2fe2591b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fHVzZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    Users(
        1,
        name: "Ahmed Wasfe",
        phone: "05992435704",
        image: "https://images.unsplash.com/photo-1605993439219-9d09d2020fa5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzh8fHVzZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    Users(
        5,
        name: "Ali AM",
        phone: "1257751065",
        image: "http://images.unsplash.com/photo-1474176857210-7287d38d27c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mzl8fHVzZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
    Users(
        4,
        name: "Khaled KH",
        phone: "987512015",
        image: "https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzV8fHVzZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: 0.0,
        centerTitle: true,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(avatar),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text("Ahmed"),
          ],
        ),
        actions: [
          IconButton(
              icon: CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.grey[700],
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 16.0,
                ),
              ),
              onPressed: () {}),
        ],
      ),
      body: ListView.separated(
        scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => buildUsersItems(listUsers[index]),
          separatorBuilder: (context, index) => SizedBox(),
          itemCount: listUsers.length,),
    );
  }

  Widget buildUsersItems(Users user) => Card(
        margin: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 18.0,
          right: 18.0
        ),
        color: Colors.grey[800],
        borderOnForeground: true,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(user.image),
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${user.name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text("${user.phone}", style: TextStyle(color: Colors.grey[400])),
                ],
              )
            ],
          ),
        ),
      );
}
