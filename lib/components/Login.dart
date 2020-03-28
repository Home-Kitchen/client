import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kitchen/constants/Api.dart';
import 'package:kitchen/constants/Store.dart';

class Login extends StatefulWidget
{
	createState()
	{
		return LoginState();
	}
}

class LoginState extends State<Login>
{
	final String prefixUrl = "/user";

	var txtUsernameController = TextEditingController();
	var txtPasswordController = TextEditingController();

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
								controller: txtUsernameController,
								decoration: InputDecoration
								(
									hintText: "Username",
								),
							),
							TextField
							(
								controller: txtPasswordController,
								obscureText: true,
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
										onPressed: () async
										{
											var success = await this.userLogin(txtUsernameController.text, txtPasswordController.text);

											if (success)
											{
												Navigator.pushReplacementNamed(context, "/home");
											}											
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

	Future<bool> userLogin(String username, String password) async
	{
		await Store.init();
		Api apiClient = Api();

		String url = prefixUrl + "/login";

		Map body = 
		{
			"username": username,
			"password": password
		};

		print(body);

		var response = await apiClient.post(url, body);
		var parsedResponse = jsonDecode(response);

		print(parsedResponse);

		if (parsedResponse["status"] == 200)
		{
			await Store.store.setString("organizationId", parsedResponse["data"]["organizationId"]);
			await Store.store.setString("username", parsedResponse["data"]["name"]);
			await Store.store.setString("userId", parsedResponse["data"]["_id"]);

			return(true);
		}

		return(false);
	}
}