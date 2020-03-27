import 'package:flutter/material.dart';

class Join extends StatefulWidget
{
	createState() 
	{
		return(JoinState());
	}
}

class JoinState extends State<Join>
{
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			home: Scaffold
			(
				body: Container
				(
					padding: EdgeInsets.only(left: 30,right: 30,top: 150,bottom: 2),
					child: Column
					(
						// mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>
						[
							Container
							(
								margin: EdgeInsets.all(20),
								padding: EdgeInsets.all(1),
								decoration: BoxDecoration
								(
									borderRadius: BorderRadius.circular(100),
									border: Border.all(width:2, color:Colors.black26)
								),
								child: Icon
								(
									Icons.beenhere,
									color: Colors.green,
									size: 50,
								),
							),
							TextField
							(
								decoration: InputDecoration
								(
									hintText: "Join Code",
								),
							),
							Padding(padding: EdgeInsets.only(bottom:20),),
							Container
							(
								child: SizedBox
								(
									width: double.infinity,
									child: RaisedButton
									(
										onPressed: (){},
										child: Text("JOIN"),
										textColor: Colors.black,
										color: Colors.orangeAccent,
									),			
								),
							),
						],
					),
				),
			),
		);
	}
}