import 'package:flutter/material.dart';

class LoginBasicDemo extends StatefulWidget {
  const LoginBasicDemo({Key key}) : super(key: key);

  @override
  _LoginBasicDemoState createState() => _LoginBasicDemoState();
}

class _LoginBasicDemoState extends State<LoginBasicDemo> with SingleTickerProviderStateMixin {
  TextEditingController _nameController;
  TextEditingController _pwController;

  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _pwController = TextEditingController();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pwController.dispose();
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Scaffold(
          body: Transform(
            transform: Matrix4.translationValues(_animation.value * width, 0, 0),
            child: ListView(
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
          ),
        );
      },
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
