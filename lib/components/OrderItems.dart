import 'dart:convert';

import "package:flutter/material.dart";
import 'package:kitchen/constants/Api.dart';
import 'package:kitchen/constants/Store.dart';
import "package:intl/intl.dart";

class OrderItems extends StatefulWidget
{
	createState()
	{
		return(OrderItemsState());
	}
}

class OrderItemsState extends State<OrderItems>
{
	final String prefixUrl = "/order";

	List<dynamic> orders = [{"name":"","items":0,"created":"0000-00-00", "items":[]}];

	void initState()
	{
		super.initState();

		WidgetsBinding.instance.addPostFrameCallback((_)
		{
			fetchOrders();			
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
					title: Text("Order Items"),
					backgroundColor: Colors.green,
				),
				body: Container
				(					
					child: Column
					(
						children: 
						[
							Container
							(
								color: Colors.green[400],
								height: 200.0,
								padding: EdgeInsets.only(top: 110.0,left: 20.0),
								child: SizedBox
								(
									width: double.infinity,
									child: Column
									( 
										crossAxisAlignment: CrossAxisAlignment.start,
										children: 
										[
											Text("Order Items", style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold)),
											Text("Create a new order list or add items to an existing one. Once done you can also mark off items from the list.")
										]
									)
								),
							),
							Expanded
							(
								child: SizedBox
								(								
									child: ListView.builder
									(
										itemCount: this.orders.length,
										itemBuilder: (context, position)
										{
											return Card
											(
												child: ListTile
												(
													leading: Icon(Icons.format_list_bulleted, size: 40.0, color: Colors.green,),
													title: Text(this.orders[position]["name"].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
													subtitle: Text(this.orders[position]["description"].toString()),
													trailing: Column
													(
														crossAxisAlignment: CrossAxisAlignment.end,
														children: 
														[
															Container
															(
																padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
																child: Text(this.orders[position]["items"].length.toString(), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
															),
															Text(DateFormat("d-MMM-y").format(DateTime.parse(this.orders[position]["created"].toString())), style: TextStyle(fontSize: 12.0)),
														],
													), 
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
				floatingActionButton: FloatingActionButton
				(
					child: Icon(Icons.add),
					backgroundColor: Colors.green,
					onPressed: () 
					{
						showDialog(context: context, builder: (BuildContext context) => popUp(context));						
					},
				),
			)			
		);
	}

	Widget popUp(BuildContext context)
	{
		var txtNameController = TextEditingController();
		var txtDescriptionController = TextEditingController();

		return AlertDialog
		(
			title: Text("New List"),
			content: Column
			(
				mainAxisSize: MainAxisSize.min,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: 
				[
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
						controller: txtDescriptionController,
						decoration: InputDecoration
						(							
							hintText: "Description",						
						),						
					),
					Container
					(
						margin: EdgeInsets.only(top:20.0),
					),
					SizedBox
					(						
						width: double.infinity,
						child: RaisedButton
						(
							child: Text("Create List"),
							color: Colors.green,
							textColor: Colors.white,
							onPressed: () async
							{
								bool success = await this.createList(txtNameController.text, txtDescriptionController.text);

								if (success)
								{
									Navigator.pop(context);
								}
							},
						),
					)
				],
			),
		);
	}

	fetchOrders() async
	{
		Api apiClient = Api();

		String url = prefixUrl + "/list";

		Map body = 
		{
			"organizationId": Store.store.getString("organizationId")			
		};

		var response = await apiClient.post(url, body);
		var parsedResponse = jsonDecode(response);

		print(parsedResponse);

		if (parsedResponse["status"] == 200)
		{			
			setState(() 
			{
				this.orders = parsedResponse["data"];
			});			
		}
	}

	Future<bool> createList(String name, String desc) async
	{
		Api apiClient = Api();

		String url = prefixUrl + "/create";

		Map body = 
		{
			"organizationId": Store.store.getString("organizationId"),
			"name": name,
			"description": desc
		};

		var response = await apiClient.post(url, body);
		var parsedResponse = jsonDecode(response);

		if (parsedResponse["status"] == 200)
		{
			await this.fetchOrders();
			return(true);
		}

		return(false);
	}
}