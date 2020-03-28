import 'dart:convert';
import "package:flutter/material.dart";
import 'package:kitchen/constants/Store.dart';
import "../constants/Api.dart";

class Quantity extends StatefulWidget
{
	createState()
	{
		return QuantityState();
	}
}

class QuantityState extends State<Quantity>
{
	final String prefixUrl = "/item";

	//controller
	var txtQuantityController = TextEditingController();
	var txtWeightController = TextEditingController();
	var txtPriceController = TextEditingController();


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
										print(txtQuantityController.text);

										bool x = await this.quantityEdit(txtQuantityController.text, txtWeightController.text, txtPriceController.text);
										print(x);

										if(x == true)
										{
											Navigator.pushNamed(context, "/home");
										}
									}, 
									child: Text("EDIT")
								),
							),
						),
					],
					
				),
			),
		);
	}

	Future<bool> quantityEdit( String quantity, String weight, String price) async
	{
		
		Api apiClient = new Api();

		String endpoint = this.prefixUrl + "/add";

		Map body = 
		{
			"organizationId": Store.store.getString("organizationId"),
			"itemId": Store.store.getString("itemId"),
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