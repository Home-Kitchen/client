import 'package:flutter/material.dart';

class Order extends StatefulWidget
{
	createState()
	{
		
		return OrderState();
	}
}

class OrderState extends State<Order>
{
	Widget build(BuildContext context)
	{
		return  Scaffold
		(
			appBar: AppBar
			(
				title: Text("ORDER PRODUCTS",style: TextStyle(color: Colors.brown[800]),),
				backgroundColor: Colors.amber,			
			),
			body: Container
			(
				child: Column
				(
					children: 
					[
						TextField
						(
							decoration: InputDecoration
							(
								hintText: "Search",
								fillColor: Colors.black.withOpacity(0.1),
								filled: true,
								prefixIcon: Icon
								(
									Icons.search,
									size: 30,
									color: Colors.black,
								),
								border: OutlineInputBorder
								(
									borderRadius: BorderRadius.circular(10),
									borderSide: BorderSide.none
								),
								contentPadding: EdgeInsets.zero
							),

						)
					],
				),
			),
		);
	}
}