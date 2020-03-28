import "package:flutter/material.dart";
import 'package:kitchen/components/AddItems.dart';
import 'package:kitchen/components/CreateOrganization.dart';
import 'package:kitchen/components/CreateUser.dart';
import 'package:kitchen/components/Init.dart';
import 'package:kitchen/components/Join.dart';
import 'package:kitchen/components/Login.dart';
import 'package:kitchen/components/Home.dart';
<<<<<<< HEAD
import 'package:kitchen/components/Order.dart';
import 'package:kitchen/components/ViewList.dart';

=======
import 'package:kitchen/components/ViewItems.dart';
>>>>>>> 84d59e33090a35d4c9cb5c3314ac10177865fa8c

void main(List<String> args) 
{
	runApp(MaterialApp
	(
		debugShowCheckedModeBanner: false,
		title: "Kitchen",
		initialRoute: "/",
		routes: 
		{
			"/": (context) => Init(),
			"/createOrganization": (context) => CreateOrganization(),
			"/createUser": (context) => CreateUser(),
			"/join": (context) => Join(),
			"/login": (context) => Login(),
			"/home": (context) => Home(),
			"/addItem": (context) => AddItem(),
<<<<<<< HEAD
			"/viewList" :(context) => ViewList(),
			"/order": (context) => Order()
=======
			"/viewList" :(context) => ViewItems()
>>>>>>> 84d59e33090a35d4c9cb5c3314ac10177865fa8c
		},
	));
}