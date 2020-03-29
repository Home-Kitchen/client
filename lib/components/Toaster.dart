import "package:toast/toast.dart";
import "package:flutter/material.dart";

class Toaster 
{
	toast(String message, BuildContext context)
	{
		Toast.show
		(
			message, 
			context,
			gravity: Toast.BOTTOM
		);
	}
}