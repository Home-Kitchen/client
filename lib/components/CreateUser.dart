import "package:flutter/material.dart";
import 'package:kitchen/constants/Store.dart';


class CreateUser extends StatefulWidget
{
	createState() 
	{
		return(CreateUserState());
	}
}

class CreateUserState extends State<CreateUser> 
{
	Widget build(BuildContext context)
	{				
		return 
		(
			Scaffold
			(
				body: Container
				(											
					padding: EdgeInsets.all(50.0),
					child: Column
					(
						children: 
						[
							Container(margin: EdgeInsets.only(top:50.0)),
							Container
							(
								padding: EdgeInsets.all(10.0),
								decoration: BoxDecoration
								(
									border: Border.all(color: Colors.black),
									borderRadius: BorderRadius.all(Radius.circular(50.0)),									
								),
								child: Icon
								(
									Icons.verified_user,
									size: 80.0,
									color: Colors.green,
								)
							),
							Container
							(
								child: Column
								(
									children: 
									[
										Text(Store.store.getString("name")),
										Text(Store.store.getString("address")),										
									],
								),
							),
							Container
							(
								padding: EdgeInsets.only(left: 5.0, right: 15.0, top: 20.0),
								child: Text("Create an Admin for your organization", style: TextStyle(fontSize: 15.0),)
							),
							TextField
							(
								decoration: InputDecoration
								(
									hintText: "Name",
								),
							),
							TextField
							(
								decoration: InputDecoration
								(
									hintText: "Username"
								),
							),
							TextField
							(
								decoration: InputDecoration
								(
									hintText: "Password",										
								),
							),
							Container
							(
								margin: EdgeInsets.only(top: 20.0),
								child: SizedBox
								(
									width: double.infinity,
									child: RaisedButton
									(
										child: Text("Create User", style: TextStyle(fontSize: 20.0),),
										onPressed: () {},
										color: Colors.yellow,
										padding: EdgeInsets.all(5.0),
									)
								)
							)								
						]
					)
				)
			)			
		);
	}
}