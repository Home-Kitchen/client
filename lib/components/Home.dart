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
		return Scaffold
		(
			appBar: AppBar
			(
				title: Text(""),
				backgroundColor: Colors.green,
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
				color: Colors.green,
				child: Row
				(						
					children:
					[							
						IconButton
						(
							icon:Icon(Icons.home),
							color: Colors.white70,
							iconSize: 35,								
							onPressed: ()
							{
								Navigator.pushNamed(context, "/home");
							},
						),							
						IconButton
						(
							icon:Icon(Icons.check_box),
							color: Colors.white70,
							iconSize: 35,
							alignment: Alignment.centerRight,
							onPressed: ()
							{
								Navigator.pushNamed(context, "/addItem");
							},
						),
					],
				),
			),
		);
	 }
 }