import "package:flutter/material.dart";
import 'package:kitchen/components/CreateOrganization.dart';
import 'package:kitchen/components/CreateUser.dart';
import 'package:kitchen/components/Init.dart';
import 'package:kitchen/components/ItemDetails.dart';
import 'package:kitchen/components/Join.dart';
import 'package:kitchen/components/Login.dart';
import 'package:kitchen/components/Home.dart';
import 'package:kitchen/components/Order.dart';
import 'package:kitchen/components/OrderItems.dart';
import 'package:kitchen/components/ViewItems.dart';

void main() 
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
			"/viewList" :(context) => ViewItems(),
			"/viewItemDetails": (context) => ItemDetails(),
			"/orders": (context) => Order(),
			"/orderItems": (context) => OrderItems()
		},
	));
}