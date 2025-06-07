
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/forgot_password.dart';
import 'package:thuongmaidientu/features/auth/presentation/page/register_page.dart';

import 'package:thuongmaidientu/screen/Home_page/home_page.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  //late LoginResponse loginResponse;
  bool _showPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }
    // try {
    //   print(_usernameController.text + _passwordController.text);
    //   bool loginResponse = await context
    //       .read<LoginService>()
    //       .login(_usernameController.text, _passwordController.text);
    //   if (loginResponse == false) {
    //     await showErrorDialog(context, "Đăng nhập không thành công!");
    //   }
    // } catch (error) {
    //   if (mounted) {
    //     print("Đã xảy ra lỗi: $error");
    //     await showErrorDialog(context, "Đăng nhập không thành công!");
    //   }
    // }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ĐĂNG NHẬP",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Chào mừng bạn đến với nền tảng mua sắm trực tuyến của chúng tôi !",
                        style: GoogleFonts.aBeeZee(fontSize: 22, color:  Colors.grey[800]),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

               Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Tên đăng nhập",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _usernameController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.all(
                                  //     Radius.circular(25),
                                  //   ),
                                  // ),
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 29, 29, 29),
                                    fontSize: 16,
                                  ),
                                ),
                                // validator: (value) {
                                //   // || value.length < 5
                                //   if (value == null) {
                                //     return 'Tên đăng nhập không được trống và chứa ít nhất 5 kí tự';
                                //   }
                                //   return null;
                                // },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 25),
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Mật khẩu",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    icon: _showPassword == false
                                        ? const Icon(
                                      Icons.visibility,
                                    )
                                        : const Icon(
                                      Icons.visibility_off,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  // border: const OutlineInputBorder(
                                  //   borderRadius: BorderRadius.all(
                                  //     Radius.circular(25),
                                  //   ),
                                  // ),
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 29, 29, 29),
                                    fontSize: 16,
                                  ),
                                ),
                                obscureText: !_showPassword,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                              },
                              child: const Text(
                                "Quên mật khẩu?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.amber,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 20, left: 60, right: 60),
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.greenAccent,
                                  Colors.cyan
                                ], // Choose your gradient colors
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(
                                  12), // Border radius for rounded corners
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromARGB(0, 255, 255, 255),
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                _submit();
                              },
                              child: const Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const Padding(
                padding: EdgeInsets.only(top: 20, left: 60, right: 60),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Đăng nhập với | ',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/logo/facebook.png',
                                  ),
                                  radius: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/logo/google.png',
                                  ),
                                  radius: 17,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 75, right: 75),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bạn không có tài khoản? ",
                    style: TextStyle(fontSize: 17),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Đăng ký ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}