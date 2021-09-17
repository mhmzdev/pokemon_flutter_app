import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokemon_app/constants.dart';
import 'package:pokemon_app/view/login/cubit/login_cubit.dart';
import 'package:pokemon_app/view/signUp/view/signup_page.dart';
import 'package:pokemon_app/widgets/custom_btn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  static Page page() => MaterialPage(child: LoginView());

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
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

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this)
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
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.formState.fields.isEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Missing Fields!')),
            );
        }
      },
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(0, animation.value),
                        child: Hero(
                          tag: 'img',
                          child: SvgPicture.asset(
                            'assets/pokeball.svg',
                            height: 100.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        "Pokemon Flutter App",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 50.0),
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
                            hintText: 'Enter email',
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
                          validator: FormBuilderValidators.required(context),
                          obscureText: _isObscure,
                          name: 'password',
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8.0),
                            prefixIcon: Icon(Icons.lock),
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
                      _LoginButton(),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Forgot Password?")),
                      const Divider(height: 30.0, endIndent: 8.0, indent: 8.0),
                      CustomButton(
                        btnColor: Colors.redAccent,
                        onPressed: () {
                          Navigator.push(context, SignUpPage.route());
                        },
                        child: const Text("Create New Account"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // override the back button on android
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Exit Application",
            ),
            content: const Text(
              "Are You Sure?",
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              TextButton(
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.black54),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )) ??
        false;
  }
}

// login button written in separate Stateless widget (NOT SURE WHY? But bloc is working this way)
class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.formState != current.formState,
      builder: (context, state) => CustomButton(
        onPressed: () => context.read<LoginCubit>().login(),
        child: const Text("Login"),
      ),
    );
  }
}
