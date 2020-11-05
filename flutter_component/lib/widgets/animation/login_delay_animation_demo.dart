import 'package:flutter/material.dart';

class LoginDelayDemo extends StatefulWidget {
  const LoginDelayDemo({Key key}) : super(key: key);

  @override
  _LoginDelayDemoState createState() => _LoginDelayDemoState();
}

class _LoginDelayDemoState extends State<LoginDelayDemo> with SingleTickerProviderStateMixin {
  TextEditingController _nameController;
  TextEditingController _pwController;

  Animation _animationTitle, _animationTextField, _animationButton;
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _pwController = TextEditingController();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2, milliseconds: 50));
    _animationTitle = Tween(begin: -1.0, end: 0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn
    ));
    _animationTextField = Tween(begin: -1.0, end: 0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 1.0,
            curve: Curves.fastOutSlowIn
        )
    ));

    _animationButton = Tween(begin: -1.0, end: 0).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.6, 1.0,
            curve: Curves.fastOutSlowIn
        )
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
      animation: _animationController,
      builder: (context, child) {
        return Scaffold(
          body:ListView(
            children: [
              SizedBox(height: 80,),
              Transform(
                transform: Matrix4.translationValues(_animationTitle.value * width, 0, 0),
                child: Center(
                  child: Text(
                    'login',
                    style: TextStyle(
                        fontSize: 32
                    ),
                  ),
                ),
              ),

              SizedBox(height: 80,),

             Transform(
               transform: Matrix4.translationValues(_animationTextField.value * width, 0, 0),
              child: Column(
                children: [
                  _buildTextField(_nameController, false, 'name'),
                  _buildTextField(_pwController, true, 'password'),
                ],
              ),
             ),

              Transform(
                transform: Matrix4.translationValues(_animationButton.value * width, 0, 0),
                child: ButtonBar(
                  children: [
                    RaisedButton(onPressed: (){}, child: Text('login'), color: Colors.white,)
                  ],
                ),
              ),


            ],
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
