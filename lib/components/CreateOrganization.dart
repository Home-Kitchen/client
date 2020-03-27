import 'dart:convert';

import "package:flutter/material.dart";
import "../constants/Api.dart";

class CreateOrganization extends StatefulWidget
{
	createState() 
	{
		return(CreateOrganizationState());
	}
}

class CreateOrganizationState extends State<CreateOrganization> 
{
	final String prefixUrl = "/organization";
	
	// Controllers
	var txtNameController = TextEditingController();
	var txtAddressController = TextEditingController();

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
								decoration: BoxDecoration
								(
									border: Border.all(color: Colors.black)
								),
								child: Icon
								(
									Icons.home,
									size: 80.0									
								)
							),
							Container
							(
								padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
								child: Text("An organization resembles the house you want to maintain the inventory for. Enter the details below to create a new organization.", textAlign: TextAlign.center)
							),
							TextField
							(
								decoration: InputDecoration
								(
									hintText: "Join Code",
								),
							),
							TextField
							(
								controller: txtNameController,
								decoration: InputDecoration
								(
									hintText: "Name"
								)
							),
							TextField
							(
								controller: txtAddressController,
								decoration: InputDecoration
								(
									hintText: "Address",										
								)
							),
							Container
							(
								margin: EdgeInsets.only(top: 20.0),
								child: SizedBox
								(
									width: double.infinity,
									child: RaisedButton
									(
										child: Text("Create", style: TextStyle(fontSize: 20.0),),
										onPressed: () 
										{
											// Navigator.pushNamed(context, "/createUser");
											this.createOrganization(txtNameController.text, txtAddressController.text, "");
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

	createOrganization(String name, String address, String code) async 
	{
		Api apiClient = new Api();

		String endpoint = this.prefixUrl + "/create";	

		Map body = 
		{
			"name": name,
			"address": address
		};

		print(body);

		var response = await apiClient.post(endpoint, body);
		var parsedResponse = jsonDecode(response);		

		print(response);
		print(parsedResponse);

		if (parsedResponse["status"] == 200)
		{
			Navigator.pushNamed(context, "/createUser");
		}
	}
}