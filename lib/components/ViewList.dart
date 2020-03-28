
import 'package:flutter/material.dart';

class ViewList extends StatefulWidget
{
	createState()
	{
		return ListState();
	}
}

class ListState extends State<ViewList>
{
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
  					itemBuilder: (context, position) 
					{
    					return Card
						(
      						child: Padding
							(
        						padding: const EdgeInsets.all(16.0),
        						child: Text
								(
									position.toString(), 
									style: TextStyle(fontSize: 15.0),
								),
      						),
    					);
  					},
				),
			),
			// bottomNavigationBar: BottomNavigationBar
			// (
				
			// ),
		);
	}
}