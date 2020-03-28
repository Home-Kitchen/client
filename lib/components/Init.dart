import 'package:flutter/material.dart';

class Init extends StatelessWidget
{
	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			home: Scaffold
			(
				body: Container
				(
					color: Colors.white24,
					padding: EdgeInsets.only(left: 130,right: 0,top: 95,bottom: 2),
					child: Column
					(
						children: <Widget>
						[
							ClipOval
							(
								child: Material
								(
									color: Colors.orangeAccent,
									child: InkWell
									(
										splashColor: Colors.blue,
										child: SizedBox
										(
											width:100, 
											height:100,
											child: Icon
											(
												Icons.add_shopping_cart,
												size: 45.0
											),
										),
											onTap: (){},
									),
								),
							),
							Padding(padding: EdgeInsets.only(bottom:20),),
							RaisedButton
							(
								onPressed:()
								{
									Navigator.pushNamed(context, "/createOrganization");
								},
								splashColor: Colors.blue,
								child: Text("CREATE"),
								textColor: Colors.white,
								color: Colors.lightBlueAccent,
							),
							Padding(padding: EdgeInsets.only(bottom:20),),
							RaisedButton
							(
								onPressed:()
								{
									Navigator.pushNamed(context, "/join");
								},
								child: Text("JOIN"),
								splashColor: Colors.blue,
								textColor: Colors.white,
								color: Colors.lightBlueAccent,
							),
							Padding(padding: EdgeInsets.only(bottom:20),),
							RaisedButton
							(
								onPressed:()
								{
									Navigator.pushNamed(context, "/login");
								},
								child: Text("LOGIN"),
								splashColor: Colors.blue,
								textColor: Colors.white,
								color: Colors.lightBlueAccent,
							),
						],
					)
				),
			),
		);
	}
}