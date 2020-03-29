import 'dart:convert';

import "package:flutter/material.dart";
import 'package:kitchen/components/Loader.dart';
import 'package:kitchen/constants/Api.dart';
import 'package:kitchen/constants/Store.dart';
import "package:intl/intl.dart";

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

	List<dynamic> stocks = [{"weight":0,"price":0,"added":"0000-00-00", "quantity":0}];

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
		print("Here");

		return 
		(
			Scaffold
			(
				appBar: AppBar
				(
					title: Text("Item Details"),
					backgroundColor: Colors.green,
				),
				body: Container
				(					
					color: Colors.white,
					child: Column
					(
						children: 
						[
							Container
							(
								color: Colors.green[400],
								height: 200.0,
								padding: EdgeInsets.only(top: 160.0,left: 20.0),
								child: SizedBox
								(
									width: double.infinity,
									child: Text(name, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))
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
													leading: Container
													(														
														decoration: BoxDecoration
														(					
															color: Colors.grey[100],										
															border: Border
															(
																right: BorderSide(width: 1.0, color: Colors.grey),
																top: BorderSide(width: 1.0, color: Colors.grey),
																bottom: BorderSide(width: 1.0, color: Colors.grey),
																left: BorderSide(width: 1.0, color: Colors.grey)
															)
														),																				
														padding: EdgeInsets.all(15.0),
														child: Text((this.stocks[position]["quantity"] < 10)?("0" + this.stocks[position]["quantity"].toString()):(this.stocks[position]["quantity"].toString()), style: TextStyle(fontSize: 25.0))
													),
													title: Text(this.stocks[position]["weight"].toString() + " gms", style: TextStyle(fontWeight: FontWeight.bold)),
													subtitle: Text(DateFormat("d-MMM-y").format(DateTime.parse(this.stocks[position]["added"].toString())), style: TextStyle(fontSize: 15.0)),
													onTap: () async
													{
														
													},
													trailing: Column
													(
														mainAxisAlignment: MainAxisAlignment.center,
														children: 
														[
															Text((this.stocks[position]["price"] * this.stocks[position]["quantity"]).toString(), style: TextStyle(fontSize: 25.0)),
															Text(this.stocks[position]["price"].toString(), style: TextStyle(fontSize: 15.0)),
														]
													)
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
						showDialog(context: context, builder: (BuildContext context) => updateQuantityPopUp(context, this.name));
					}
				),
			)			
		);
	}

	Widget updateQuantityPopUp(BuildContext context, String itemName)
	{		
		var txtWeightController = TextEditingController();
		var txtQuantityController = TextEditingController();
		var txtPriceController = TextEditingController();

		return AlertDialog
		(
			title: Text("Add Stock"),
			content: Column
			(
				mainAxisSize: MainAxisSize.min,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: 
				[
					Container
					(
						child:Text(itemName, style: TextStyle(color: Colors.white)),
						color: Colors.green,
						padding: EdgeInsets.all(5.0),
						margin: EdgeInsets.only(bottom: 20.0),
					),
					TextField
					(
						controller: txtWeightController,
						keyboardType: TextInputType.number,
						decoration: InputDecoration
						(							
							hintText: "Weight (in grams)",						
						),						
						autofocus: true,
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
							child: Text("Add Quantity"),
							color: Colors.green,
							textColor: Colors.white,
							onPressed: () async
							{
								await this.updateQuantity(txtQuantityController.text, txtWeightController.text, txtPriceController.text);
							},
						),
					)					
				],
			),
		);
	}

	fetchItemDetails() async
	{
		showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => Loader("Fetching Item Details"));

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

		Navigator.pop(context);
	}

	Future<bool> updateQuantity(String quantity, String weight, String price) async
	{
		Navigator.pop(context);

		Api apiClient = new Api();

		String endpoint = this.prefixUrl + "/add";

		Map body = 
		{
			"organizationId": Store.store.getString("organizationId"),
			"itemId": Store.store.getString("itemId"),
			"quantity": quantity,
			"weight" : weight,
			"price": price,
			"userId": Store.store.getString("userId")
		};

		print(body);

		var response = await apiClient.post(endpoint, body);
		var parsedResponse = jsonDecode(response);

		if (parsedResponse["status"] == 200)
		{
			await Store.store.setString("ViewItems", "1");
			await this.fetchItemDetails();
			return (true);
		}

		return (false);
	}
}