import 'dart:convert';
import "package:flutter/widgets.dart";
import 'package:flutter/material.dart';
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
				title: Text("LIST VIEW"),
				backgroundColor: Colors.deepPurpleAccent[200],
			),
			body: Container
			(
				child:ListView.builder
				(
					itemCount: this.items.length,
  					itemBuilder: (context, position) 
					{
    					return Card
						(
      						child: ListTile
							(
								leading: Image.network(this.items[position]["picture"]),
								title: Text(this.items[position]["name"]),
								subtitle: Text(this.items[position]["_id"]),
								onTap: () 
								{
									print(this.items[position]);
								},
							),
    					);
  					},
				),
			)
		);
	}

	fetchItems() async
	{
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
			setState(() 
			{
				this.items = parsedResponse["data"];
			});			
		}		
	}
}