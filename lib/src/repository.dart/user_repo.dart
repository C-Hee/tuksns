import 'package:http/http.dart' as http;
class UserRepo{
  register(String name, String email, String password)
  async{ var url = Uri.http('localhost:3000','api/user/register');
  var response = await http.post(url,body:{
    'name': name,
    'email':email,
    'password':password,
  });
  print(response.statusCode);
  print(response.body);
}
}