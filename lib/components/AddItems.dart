import 'package:flutter/material.dart';

class AddItem extends StatefulWidget
{
	createState()
	{
		return ItemState();
	}
}

class ItemState extends State<AddItem>
{
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			body: Container
			(
				padding: EdgeInsets.only(top:35,left:20,right:20,bottom:2),
				color: Colors.white70,
				child: Column
				(
					children: <Widget>
					[
						Container
						(
							margin: EdgeInsets.all(20),
							padding: EdgeInsets.all(10),
							decoration: BoxDecoration
							(
								borderRadius: BorderRadius.circular(100),
								border: Border.all(width:2, color:Colors.black38)
							),
							child: Icon
							(
								Icons.collections_bookmark,
								color: Colors.blue,
								size: 60,
							),
						),
						TextField
						(
							decoration: InputDecoration
							(
								hintText:"Name", 
							),
						),
						TextField
						(
							decoration: InputDecoration
							(
								hintText:"Quantity", 
							),
						),
						TextField
						(
							decoration: InputDecoration
							(
								hintText:"Weight", 
							),
						),
						TextField
						(
							decoration: InputDecoration
							(
								hintText:"Price", 
							),
						),
						Padding(padding: EdgeInsets.only(bottom:10)),
						Container
						(
							child: SizedBox
							(
								width: double.infinity,
								child: RaisedButton
								(		
									color: Colors.orangeAccent,
									onPressed: (){}, 
									child: Text("ADD")
								),
							),
						),
					],
					
				),
			),
			floatingActionButton: FloatingActionButton
			(
				onPressed: ()
				{
					Navigator.pushNamed(context, "/viewList");
				},
				child: Icon(Icons.view_list),
			),
		);
	}
}