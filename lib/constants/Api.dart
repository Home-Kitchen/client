import 'dart:convert';
import 'dart:io';

class Api 
{
	Future<String> post(String url, String contentType, Map body) async 
	{
		HttpClient httpClient = new HttpClient();
		HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
		request.headers.set('content-type', contentType);
		request.add(utf8.encode(json.encode(body)));
		
		HttpClientResponse response = await request.close();
		
		String reply = await response.transform(utf8.decoder).join();
		httpClient.close();
		
		return reply;
	}
}