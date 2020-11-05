import 'package:flutter/material.dart';

class LoginNormalDemo extends StatefulWidget {
  const LoginNormalDemo({Key key}) : super(key: key);

  @override
  _LoginNormalDemoState createState() => _LoginNormalDemoState();
}

class _LoginNormalDemoState extends State<LoginNormalDemo> {
  TextEditingController _nameController;
  TextEditingController _pwController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _pwController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pwController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 80,),
            Center(
              child: Text(
                'login',
                style: TextStyle(
                  fontSize: 32
                ),
              ),
            ),
            SizedBox(height: 80,),
            _buildTextField(_nameController, false, 'name'),
            _buildTextField(_pwController, true, 'password'),
            ButtonBar(
              children: [
                RaisedButton(onPressed: (){}, child: Text('login'), color: Colors.white,)
              ],
            )

          ],
        ),
    );
  }

  Widget _buildTextField(TextEditingController controller, bool obscureText,
      String labelText) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            labelText: labelText
          ),
        ),
      ),
    );
  }
}
