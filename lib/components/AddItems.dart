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
							decoration: InputDecoration
							(
								hintText:"Name", 
							),
						),
						TextField
						(
							decoration: InputDecoration
							(
								hintText:"Quantity", 
							),
						),
						TextField
						(
							decoration: InputDecoration
							(
								hintText:"Weight", 
							),
						),
						TextField
						(
							decoration: InputDecoration
							(
								hintText:"Price", 
							),
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
									onPressed: (){}, 
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
	Future<bool> addItem(String name, double quantity, double weight, double price)async
	{
		await Store.init();
		Api apiClient = new Api();

		String endpoint = this.prefixUrl + "/addList";

		Map body = 
		{
			"name" :name,
			"quantity": quantity,
			"weight" : weight,
			"price": price
		};
		 print(body);

		var response = await apiClient.post(endpoint, body);
		var parsedResponse = jsonDecode(response);

		print(response);
		print(parsedResponse);

		if (parsedResponse["status"] == 200)
		{
			await Store.store.setString("organizationId", parsedResponse["data"]["_id"]);
			await Store.store.setString("name", parsedResponse["data"]["name"]);
			await Store.store.setString("quantity", parsedResponse["data"]["quantity"]);
			await Store.store.setString("weight", parsedResponse["data"]["weight"]);
			await Store.store.setString("price", parsedResponse["data"]["price"]);

			return (true);
			
		}
		return (false);
	}
}