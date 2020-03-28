import 'package:flutter/material.dart';

class Login extends StatefulWidget
{
	createState()
	{
		return LoginState();
	}
}

class LoginState extends State<Login>
{
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			home: Scaffold
			(
				body: Container
				(
					padding: EdgeInsets.only(bottom: 2,top:75,left:30,right: 30),
					child:Column
					(
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
									Icons.local_activity,
									color: Colors.green,
									size: 50,
								),
							),
							TextField
							(
								decoration: InputDecoration
								(
									hintText: "Username",
								),
							),
							TextField
							(
								decoration: InputDecoration
								(
									hintText: "Password",
								)
							),
							Padding(padding: EdgeInsets.only(bottom:20),),
							Container
							(
								child: SizedBox
								(
									width: double.infinity,
									child: RaisedButton
									(
										onPressed: ()
										{
											Navigator.pushNamed(context, "/home");
										},
										child: Text("LOGIN"),
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