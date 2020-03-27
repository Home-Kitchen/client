import "package:flutter/material.dart";
import 'package:kitchen/components/CreateOrganization.dart';
import 'package:kitchen/components/CreateUser.dart';

void main()
{
	runApp(MaterialApp
	(
		debugShowCheckedModeBanner: false,
		title: "Kitchen",
		initialRoute: "/",
		routes: 
		{
			"/": (context) => CreateOrganization(),
			"/createUser": (context) => CreateUser()
		},
	));
}