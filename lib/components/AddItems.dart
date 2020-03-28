import 'dart:convert';
import "package:flutter/material.dart";
import 'package:kitchen/constants/Store.dart';
import "../constants/Api.dart";

class AddItem extends StatefulWidget
{
	createState()
	{
		return ItemState();
	}
}

class ItemState extends State<AddItem>
{
	final String prefixUrl = "/item";

	// contoller
	var txtNameController = TextEditingController();
	var txtQuantityController = TextEditingController();
	var txtWeightController = TextEditingController();
	var txtPriceController = TextEditingController();


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
							controller: txtNameController,
							decoration: InputDecoration
							(
								hintText:"Name", 
							),
						),
						TextField
						(
							controller: txtQuantityController,
							decoration: InputDecoration
							(
								hintText:"Quantity", 																
							),
							keyboardType: TextInputType.number,
						),
						TextField
						(
							controller: txtWeightController,
							decoration: InputDecoration
							(
								hintText:"Weight", 
							),
							keyboardType: TextInputType.number,
						),
						TextField
						(
							controller: txtPriceController,
							decoration: InputDecoration
							(
								hintText:"Price", 
							),
							keyboardType: TextInputType.number,
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
									onPressed: () async
									{
										print(txtNameController.text);

										bool x = await this.addItem(txtNameController.text, txtQuantityController.text, txtWeightController.text, txtPriceController.text);
										print(x);

										if(x == true)
										{
											Navigator.pushNamed(context, "/home");
										}
									}, 
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

	Future<bool> addItem(String name, String quantity, String weight, String price) async
	{
		
		Api apiClient = new Api();

		String endpoint = this.prefixUrl + "/create";

		Map body = 
		{
			"organizationId": Store.store.getString("organizationId"),
			"name" :name,
			"stocks":
			[
				{
					"quantity": quantity,
					"weight" : weight,
					"price": price,
					"userId": Store.store.getString("userId")
				}
			]
		};

		print(body);

		var response = await apiClient.post(endpoint, body);
		var parsedResponse = jsonDecode(response);

		print(response);
		print(parsedResponse);

		if (parsedResponse["status"] == 200)
		{




			return (true);
			
		}
		return (false);
	}
}