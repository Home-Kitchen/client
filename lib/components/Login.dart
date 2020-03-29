import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kitchen/components/Loader.dart';
import 'package:kitchen/components/Toaster.dart';
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
		return Scaffold
		(			
			resizeToAvoidBottomInset: true,				
			body: SingleChildScrollView
			(
				padding: EdgeInsets.only(bottom: 50.0),
				child: Container
				(						
					padding: EdgeInsets.only(bottom: 2,top:75,left:30,right: 30),
					child:Column
					(							
						mainAxisAlignment: MainAxisAlignment.start,
						children:
						[
							Container
							(								
								child: Image.network
								(
									"https://www.freepnglogos.com/uploads/logo-home-png/download-home-image-13.png",
									height: 250.0,
								),								
							),
							Container
							(
								child: Text("Kitchen", style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold)),
							),
							Container
							(
								child: Text("Login to continue", style: TextStyle(fontSize: 15.0)),
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
										textColor: Colors.white,
										color: Colors.green,
										padding: EdgeInsets.all(13.0),
									),			
								),
							),
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
										child: Text("SIGNUP"),
										textColor: Colors.white,
										color: Colors.grey,
									),			
								),
							),
						]
					),
				)
			),				
		);		
	}

	Future<bool> userLogin(String username, String password) async
	{
		showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => Loader("Validating User"));
		
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

		Navigator.pop(context);

		if (parsedResponse["status"] == 200)
		{
			await Store.store.setString("organizationId", parsedResponse["data"]["organizationId"]);
			await Store.store.setString("username", parsedResponse["data"]["name"]);
			await Store.store.setString("userId", parsedResponse["data"]["_id"]);

			return(true);
		}
		else 
		{
			Toaster toast = Toaster();
			toast.toast(parsedResponse["message"], context);
		}

		return(false);
	}
}