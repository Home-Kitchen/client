import 'package:flutter/material.dart';
 
 class Home extends StatefulWidget
 {
	 createState()
	 {
		 return HomeState();
	 }
 }

 class HomeState extends State<Home>
 {
	 Widget build(BuildContext context)
	 {
		 return MaterialApp
		 (
			 home: Scaffold
			 (
				appBar: AppBar
				(
					title: Text("KITCHEN"),
					backgroundColor: Colors.deepPurpleAccent,
				),
				body: Column
				(
					children: <Widget>
					[
						Container(), 
						Container(),
					],
				),
				bottomNavigationBar: BottomAppBar
				(
					color: Colors.deepPurpleAccent,
					child: Row
					(
						children: <Widget>
						[
							Padding(padding: EdgeInsets.only(left: 10)),
							IconButton
							(
								icon:Icon(Icons.home),
								color: Colors.white70,
								iconSize: 45,
								onPressed: ()
								{
									Navigator.pushNamed(context, "/home");
								},
							),
							Padding(padding: EdgeInsets.only(left: 200)),
							IconButton
							(
								icon:Icon(Icons.check_box),
								color: Colors.white70,
								iconSize: 45,
								onPressed: ()
								{
									Navigator.pushNamed(context, "/addItem");
								},
							),
						],
					),
				),
			 ),
		 );
	 }
 }