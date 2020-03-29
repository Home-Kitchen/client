import 'package:flutter/material.dart';
import 'package:kitchen/constants/Store.dart';
 
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
				automaticallyImplyLeading: false,				
				title: Column
				(					
					crossAxisAlignment: CrossAxisAlignment.start,					
					children: 
					[
						Text("Home"),
						Text(Store.store.getString("username"), style: TextStyle(fontSize: 12.0),)
					],
				),				
				backgroundColor: Colors.green,
			),
			body: Column
			(
				children: <Widget>
				[
					Card
					(
						child: Column
						(
							crossAxisAlignment: CrossAxisAlignment.start,
							children:
							[
								ListTile
								(
									contentPadding: EdgeInsets.only(left: 20.0, top: 30.0),
									title: Text("Budget", style: TextStyle(fontSize: 30.0),),
									subtitle: Text("Spendings so far!"),
								),
								Padding
								(
									padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
									child: Text("353/5000", style: TextStyle(fontSize: 40.0))
								),
								
							]
						)
					),
					Row
					(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: 
						[
							Flexible
							(
								child: Card
								(
									child: ListTile
									(
										contentPadding: EdgeInsets.all(30.0),
										title: Text("25,234", style: TextStyle(fontSize: 40.0),),
										subtitle: Text("Total Spent"),
									)
								)
							),
							Flexible
							(
								child: Card
								(
									child: ListTile
									(
										contentPadding: EdgeInsets.all(30.0),
										title: Text("62", style: TextStyle(fontSize: 40.0),),
										subtitle: Text("Total Items"),
									)
								)
							)
						],
					),
					Card
					(
						child: ListTile
						(
							contentPadding: EdgeInsets.all(25.0),
							title: Text("Recent Additions", style: TextStyle(fontSize: 30.0)),
							subtitle: Text("Here are some of the recent items you have purchased"),
						),
					)
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
							icon:Icon(Icons.check_box),
							color: Colors.white70,
							iconSize: 35,
							alignment: Alignment.centerRight,
							onPressed: ()
							{
								Navigator.pushNamed(context, "/addItem");
							},
						),
						IconButton
						(
							icon:Icon(Icons.format_list_numbered),
							color: Colors.white70,
							iconSize: 35,
							alignment: Alignment.center,
							onPressed: ()
							{
								Navigator.pushNamed(context, "/viewList");
							},
						),
						IconButton
						(
							icon:Icon(Icons.shopping_cart),
							color: Colors.white70,
							iconSize: 35,
							alignment: Alignment.center,
							onPressed: ()
							{
								Navigator.pushNamed(context, "/orders");
							},
						),						
					],
				),
			),
		);
	 }
 }