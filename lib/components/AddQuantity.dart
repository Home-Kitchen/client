import 'package:flutter/material.dart';

class Quantity extends StatefulWidget
{
	createState()
	{
		return QuantityState();
	}
}

class QuantityState extends State<Quantity>
{
	Widget build(BuildContext context)
	{
		return Scaffold
		(
			appBar: AppBar
			(
				title: Text("EDIT"),
			),
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
							controller: txtNameController,
							decoration: InputDecoration
							(
								hintText:"Name", 
							),
						),
			    	],
				),
			),
		);
	}
}