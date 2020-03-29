import 'package:flutter/material.dart';
import 'package:kitchen/constants/Store.dart';

class Profile extends StatefulWidget
{
	createState()
	{
		return ProfileState();
	}
}

class ProfileState extends State<Profile>
{
	final String prefixUrl = "/viewProfile";

	Widget build(BuildContext context)
	{
		return MaterialApp
		(
			home: Scaffold
			(
				appBar: AppBar
				(
					title: Text("Profile",style: TextStyle(fontSize:20.0),),
				),
				backgroundColor: Colors.blue[100],
				body: SafeArea
				(
					child: Center
					(
						child: Column
						(
							mainAxisAlignment: MainAxisAlignment.center,
							children: 
							[
								CircleAvatar
								(
									radius: 80,
									backgroundColor: Colors.yellow[200],
									// backgroundImage: NetworkImage("profile.jpeg"),
								),
								Text
								(
									Store.store.getString("name"),
									style: TextStyle(fontSize: 25),
								),
								Padding(padding: EdgeInsets.only(bottom:2),),
                				Card
								(
                    				color: Colors.white,
                    				margin:
                        			EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    				child: ListTile
									(
                      					leading: Icon
										(
                        					Icons.home,
                        					color: Colors.teal[900],
                      					),
                      					title: Text
										(
											Store.store.getString("username"),
											style:TextStyle
											(
												fontFamily: 'BalooBhai', 
												fontSize: 20.0
											),
										),
									),
								),
								Card
								(
                    				color: Colors.white,
                    				margin:
                        			EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    				child: ListTile
									(
                      					leading: Icon
										(
                        					Icons.supervised_user_circle,
                        					color: Colors.black,
                      					),
                      					title: Text
										  (
											Store.store.getString("name"),
											style:TextStyle
											(
												fontFamily: 'BalooBhai', 
												fontSize: 20.0
											),
										),
									),
								),
								Card
								(
                    				color: Colors.white,
                    				margin:
                        			EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
                    				child: ListTile
									(
                      					leading: Icon
										(
                        					Icons.date_range,
                        					color: Colors.teal[900],
                      					),
                      					title: Text
										(
											'date',
											style:TextStyle
											(
												fontFamily: 'BalooBhai', 
												fontSize: 20.0
											),
										),
									),
								),
												
							],
						),
					),
				),
			),
		);
	}

}