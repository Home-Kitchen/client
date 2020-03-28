import "package:flutter/material.dart";
import 'package:kitchen/components/AddItems.dart';
import 'package:kitchen/components/CreateOrganization.dart';
import 'package:kitchen/components/CreateUser.dart';
import 'package:kitchen/components/Init.dart';
import 'package:kitchen/components/Join.dart';
import 'package:kitchen/components/Login.dart';
import 'package:kitchen/components/Home.dart';
import 'package:kitchen/components/ViewItems.dart';

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
			"/viewList" :(context) => ViewItems()
		},
	));
}