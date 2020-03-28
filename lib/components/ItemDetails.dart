import 'dart:convert';

import "package:flutter/material.dart";
import 'package:kitchen/constants/Api.dart';
import 'package:kitchen/constants/Store.dart';

class ItemDetails extends StatefulWidget
{
	createState() 
	{
		return(ItemDetailsState());
	}
}

class ItemDetailsState extends State<ItemDetails> with WidgetsBindingObserver
{
	final String prefixUrl = "/item";

	String name = "";
	String picture = "";

	List<dynamic> stocks = [{"weight":0,"price":0,"added":""}];

	void initState()
	{
		super.initState();

		WidgetsBinding.instance.addPostFrameCallback((_)
		{
			fetchItemDetails();			
		});
	}
	
	Widget build(BuildContext context)
	{
		return 
		(
			Scaffold
			(
				appBar: AppBar
				(
					title: Text("Item Details"),
					backgroundColor: Colors.deepPurpleAccent,
				),
				floatingActionButton: FloatingActionButton
			(
				onPressed: (){},
				child:Icon
				(
					Icons.add_box,
					size: 30,
				),
				
			),
				body: Container
				(					
					child: Column
					(
						children: 
						[
							Container
							(
								color: Colors.orange,
								height: 200.0,
								padding: EdgeInsets.only(top: 165.0,left: 10.0),
								child: SizedBox
								(
									width: double.infinity,
									child: Text(name, style: TextStyle(fontSize: 25.0))
								),
							),
							Expanded
							(
								child: SizedBox
								(								
									child: ListView.builder
									(
										itemCount: this.stocks.length,
										itemBuilder: (context, position)
										{
											return Card
											(
												child: ListTile
												(
													leading: Text(this.stocks[position]["weight"].toString()),
													title: Text(this.stocks[position]["added"].toString()),
													subtitle: Text(this.stocks[position]["price"].toString()),
													onTap: () 
													{
														// print(this.stocks[position]);
													},
												),
											);
										}
									)
								),
							)														
						],
					),
				),
			)			
		);
	}

	fetchItemDetails() async
	{
		Api apiClient = Api();

		String url = prefixUrl + "/details";

		Map body = 
		{
			"organizationId": Store.store.getString("organizationId"),
			"itemId": Store.store.getString("itemId")
		};

		var response = await apiClient.post(url, body);
		var parsedResponse = jsonDecode(response);

		print(parsedResponse);

		if (parsedResponse["status"] == 200)
		{			
			setState(() 
			{
				this.name = parsedResponse["data"]["name"];
				this.picture = parsedResponse["data"]["picture"];
				this.stocks = parsedResponse["data"]["stocks"];
			});			
		}
	}
}