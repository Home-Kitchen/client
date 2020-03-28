import 'dart:convert';

import "package:flutter/material.dart";
import 'package:kitchen/constants/Api.dart';
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
	final String prefixUrl = "/user";

	var txtNameController = TextEditingController();
	var txtUsernameController = TextEditingController();
	var txtPasswordController = TextEditingController();

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
								controller: txtNameController,
								decoration: InputDecoration
								(
									hintText: "Name",
								),
							),
							TextField
							(
								controller: txtUsernameController,
								decoration: InputDecoration
								(
									hintText: "Username"
								),
							),
							TextField
							(
								controller: txtPasswordController,
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
										child: Text("Create User", style: TextStyle(fontSize: 20.0)),
										onPressed: () async
										{
											var isCreated = await this.createUser(txtNameController.text, txtUsernameController.text, txtPasswordController.text);

											if (isCreated)
											{
												Navigator.pushNamed(context, "/home");
											}
										},
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

	Future<bool> createUser(String name, String username, String password) async 
	{
		Api apiClient = Api();

		String url = this.prefixUrl + "/create";

		Map body = 
		{
			"organizationId": Store.store.getString("organizationId"),
			"name": name,
			"username": username,
			"password": password
		};

		var response = await apiClient.post(url, body);
		var parsedResponse = jsonDecode(response);

		if (parsedResponse["status"] == 200)
		{
			await Store.store.setString("userId", parsedResponse["data"]["_id"]);
			await Store.store.setString("username", parsedResponse["data"]["name"]);			
			
			return(true);
		}

		return(false);
	}
}