import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokemon_app/constants.dart';
import 'package:pokemon_app/cubits/auth/auth_cubit.dart';
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
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSignUpError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(state.err)),
                );
            } else if (state is AuthSignUpSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is AuthInitial) {
              return _buildInitialForm();
            } else if (state is AuthSignUpLoading) {
              return _loading();
            } else if (state is AuthSignUpSuccess) {
              return _buildInitialForm();
            } else {
              return _buildInitialForm();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialForm() {
    return SafeArea(
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
                _SignUpButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      final authCubit = BlocProvider.of<AuthCubit>(context);
                      await authCubit.signUp(
                          _formKey.currentState.fields['name'].value,
                          _formKey.currentState.fields['email'].value,
                          _formKey.currentState.fields['password'].value);
                    }
                  },
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
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  final Function onPressed;

  const _SignUpButton({
    Key key,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      child: const Text(
        "Sign Up",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
