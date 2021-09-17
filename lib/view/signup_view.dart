import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokemon_app/auth/auth.dart';
import 'package:pokemon_app/constants.dart';
import 'package:pokemon_app/widgets/custom_btn.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _animationController;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isObscure = true;

  toggleAnimation() {
    animation = Tween(begin: 0.0, end: 10.0).animate(_animationController);
    if (_animationController.isDismissed) {
      _animationController.forward().whenComplete(() => toggleAnimation());
    }
    if (_animationController.isCompleted) {
      _animationController.reverse().whenComplete(() => toggleAnimation());
    }
  }

  // signup
  final _auth = Auth();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
        duration: Duration(milliseconds: 1800), vsync: this)
      ..addListener(() => setState(() {}));
    toggleAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BackButton(
                        color: kPrimaryColor,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, animation.value),
                      child: Hero(
                        tag: 'img',
                        child: SvgPicture.asset(
                          'assets/pokeball.svg',
                          height: 70.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      "Pokemon Flutter App",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Sign Up',
                        style: kHeadingStyle,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "It's quick and easy",
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.match(context, r'[a-zA-Z]',
                              errorText: "Name can only be alphabets!"),
                        ]),
                        name: 'name',
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Full Name',
                          hintStyle: kHintStyle,
                          fillColor: Colors.grey[200],
                          filled: true,
                          enabledBorder: kOutlineBorder,
                          focusedBorder: kOutlineBorder,
                          errorBorder: kErrorOutlineBorder,
                          focusedErrorBorder: kErrorOutlineBorder,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context),
                        ]),
                        name: 'email',
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email Address',
                          hintStyle: kHintStyle,
                          fillColor: Colors.grey[200],
                          filled: true,
                          enabledBorder: kOutlineBorder,
                          focusedBorder: kOutlineBorder,
                          errorBorder: kErrorOutlineBorder,
                          focusedErrorBorder: kErrorOutlineBorder,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: FormBuilderTextField(
                        textInputAction: TextInputAction.done,
                        validator: FormBuilderValidators.required(context),
                        obscureText: _isObscure,
                        name: 'password',
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          prefixIcon: Icon(Icons.lock_open),
                          hintText: 'Enter password',
                          hintStyle: kHintStyle,
                          fillColor: Colors.grey[200],
                          filled: true,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            child: Icon(
                              _isObscure
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              size: 20.0,
                            ),
                          ),
                          enabledBorder: kOutlineBorder,
                          focusedBorder: kOutlineBorder,
                          errorBorder: kErrorOutlineBorder,
                          focusedErrorBorder: kErrorOutlineBorder,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    CustomButton(
                      width: MediaQuery.of(context).size.width * 0.9,
                      onPressed: _signUp,
                      child: _isLoading ? kBtnLoader : const Text("Sign Up"),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      "By clicking sign up you are agreeing to our Terms of Services",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // signup ftn
  void _signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      FocusScope.of(context).unfocus();

      var value = await _auth
          .signUp(
              _formKey.currentState.fields['name'].value,
              _formKey.currentState.fields['email'].value,
              _formKey.currentState.fields['password'].value)
          .whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });

      if (value is String) {
        _signUpError(value);
      } else {
        _signUpSuccess();
      }
    }
  }

  // on signup success
  void _signUpSuccess() {
    var snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.person,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            "Account created successfully! Please login :)",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
    _formKey.currentState.reset();
  }

  // on signup error
  void _signUpError(String value) {
    print("Error: " + value);
    var snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
