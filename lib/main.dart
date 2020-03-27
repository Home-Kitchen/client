

import "package:flutter/material.dart";
import 'package:kitchen/components/CreateOrganization.dart';
import 'package:kitchen/components/CreateUser.dart';
import 'package:kitchen/components/Init.dart';
import 'package:kitchen/components/Join.dart';

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
			"/join": (context) => Join()
		},
	));
}