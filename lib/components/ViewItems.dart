import 'dart:convert';
import "package:flutter/widgets.dart";
import 'package:flutter/material.dart';
import 'package:kitchen/components/Loader.dart';
import 'package:kitchen/constants/Api.dart';
import 'package:kitchen/constants/Store.dart';

class ViewItems extends StatefulWidget
{
	createState()
	{
		return ViewItemsState();
	}
}

class ViewItemsState extends State<ViewItems> with WidgetsBindingObserver
{
	final String prefixUrl = "/item";
	List<dynamic> items = [];

	void initState()
	{
		super.initState();
		WidgetsBinding.instance.addPostFrameCallback((_)
		{
			fetchItems();
		});
	}

	Widget build(BuildContext context)
	{
		return Scaffold
		(
			appBar: AppBar
			(
				title: Text("All Items"),
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
							padding: EdgeInsets.only(top: 120.0,left: 20.0),
							child: SizedBox
							(
								width: double.infinity,
								child: Column
								( 
									crossAxisAlignment: CrossAxisAlignment.start,
									children: 
									[
										Text("Inventory", style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold)),
										Text("Here is the entire list of items in your organization.")
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
									itemCount: this.items.length,
									itemBuilder: (context, position) 
									{
										return Card
										(
											child: ListTile
											(
												leading: Icon(Icons.dehaze, size: 40.0, color: Colors.green,),
												title: Text(this.items[position]["name"], style: TextStyle(fontWeight: FontWeight.bold)),
												subtitle: Text("purchases: " + this.items[position]["items"].toString(), style: TextStyle(fontSize: 15.0)),
												onTap: () async
												{
													await Store.store.setString("itemId", this.items[position]["itemId"]);
													Navigator.pushNamed(context, "/viewItemDetails").then((value) async
													{														
														print("Back Here");

														if (Store.store.getString("ViewItems") == "1")
														{
															print("Back Here Too");
															await Store.store.setString("ViewItems", "0");
															fetchItems();
														}
													});
												},
												trailing: Text(this.items[position]["price"].toString(), style: TextStyle(fontSize: 25.0)),
											),
										);
									},
								)
							),
						)
					],
				)				
			),
			floatingActionButton: FloatingActionButton
			(
				backgroundColor: Colors.green,
				child: Icon(Icons.add),				
				onPressed: () 
				{
					showDialog(context: context, builder: (BuildContext context) => addItemPopUp(context));
				}
			),
		);
	}

	fetchItems() async
	{
		showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => Loader("Fetching Items"));

		Api apiClient = Api();

		String url = this.prefixUrl + "/list";

		Map body = 
		{
			"organizationId": Store.store.getString("organizationId")
		};

		var response = await apiClient.post(url, body);
		var parsedResponse = jsonDecode(response);

		print(body);
		print(parsedResponse);

		if (parsedResponse["status"] == 200)
		{
			List<dynamic> itemList = [];

			parsedResponse["data"].forEach((item)
			{				
				Map formattedItem = 
				{
					"name":item["name"],
					"items":item["stocks"].length,
					"price": calculateTotalPrice(item["stocks"]),
					"itemId": item["_id"],					
				};

				print(formattedItem);

				itemList.add(formattedItem);
			});

			print(itemList);

			setState(() 
			{
				this.items = itemList;
			});			
		}

		Navigator.pop(context);
	}

	String calculateTotalPrice(items)
	{
		int total = 0;

		items.forEach((item)
		{			
			total = total + (item["price"] * item["quantity"]);
		});

		return(total.toString());
	}

	Widget addItemPopUp(BuildContext context)
	{
		var txtNameController = TextEditingController();
		var txtWeightController = TextEditingController();
		var txtQuantityController = TextEditingController();
		var txtPriceController = TextEditingController();

		return AlertDialog
		(
			title: Text("New Item"),
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
							hintText: "Item Name",
						),
					),
					TextField
					(
						controller: txtWeightController,
						keyboardType: TextInputType.number,
						decoration: InputDecoration
						(							
							hintText: "Weight (in grams)",						
						),						
					),
					TextField
					(
						controller: txtQuantityController,
						keyboardType: TextInputType.number,
						decoration: InputDecoration
						(							
							hintText: "Quantity(Units purchased)",						
						),						
					),
					TextField
					(
						controller: txtPriceController,
						keyboardType: TextInputType.number,
						decoration: InputDecoration
						(							
							hintText: "Price (in rupees)",							
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
							child: Text("Add Item"),
							color: Colors.green,
							textColor: Colors.white,
							onPressed: () async
							{
								await this.addItem(txtNameController.text, txtQuantityController.text, txtWeightController.text, txtPriceController.text);
							},
						),
					)					
				],
			),
		);
	}

	Future<bool> addItem(String name, String quantity, String weight, String price) async
	{
		Navigator.pop(context);		

		Api apiClient = Api();

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

		var response = await apiClient.post(endpoint, body);
		var parsedResponse = jsonDecode(response);

		print(response);
		print(parsedResponse);

		if (parsedResponse["status"] == 200)
		{
			await this.fetchItems();
		}

		return (false);
	}
}