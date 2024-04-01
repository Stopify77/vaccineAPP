import 'package:flutter/material.dart';
import 'package:vaccine_app_project/constants.dart';
import 'package:vaccine_app_project/screens/Log_in/components/Form_errors.dart';
import 'package:vaccine_app_project/size_config.dart';
import 'package:http/http.dart' as http;
import 'Login_Button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  final _formKey = GlobalKey<FormState>();
  String? account;
  String? password;

  final List<String?> errors = []; //錯誤訊息的List
  //將錯誤訊息新增到錯誤訊息的List
  void addError({String? error}) {
    if (!errors.contains(error)){
      setState(() {
        errors.add(error);
      });}
  }
  //將錯誤訊息從錯誤訊息的List中刪除
  void removeError({String? error}) {
    if (errors.contains(error)){
      setState(() {
        errors.remove(error);
      });}
  }
  String? selectResult;

  //登入成功點閱率加一
  _addCTR() async {
    await http.post(
      Uri.parse('${VMURL}addCTR.php'),
      body: {
        "name" : "count",
      }
    );
  }
  //處理登入功能的Function
  void _handleLogin({required String name, required String loginPassword}) async {
    var res = await http.post( //將登入的帳號以及密碼傳到後端確認
      Uri.parse('${VMURL}login.php'),
      body: {
        'name': name,
        'password': loginPassword,
      },
    );
    setState(() {
      selectResult = res.body;
    });
    if (selectResult != "") {
      if (name !="0000"){
      SharedPreferences prefs = await SharedPreferences.getInstance();//將帳號存本地端
      prefs.setString('username', name);
      prefs.setString('password', loginPassword);
      }
      var res = await http.post(
        Uri.parse('${VMURL}updateNews.php'),
        body: {
          'name': name,
          'password': loginPassword,
        },
      );
      var res2 = await http.post(
        Uri.parse('${VMURL}onlineADD.php'),
        body: {
          'name': name,
          'password': loginPassword,
        },
      );
      _addCTR();
      Navigator.pushNamed(context,"/MainPage");
      removeError(error: kInvaildAccountPassword); //登入成功即刪除錯誤訊息
    }else {
      addError(error: kInvaildAccountPassword); //登入失敗即顯示錯誤訊息
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedAccount();
  }

  void _loadSavedAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? userPassword = prefs.getString('password');

    if (savedUsername != null && savedUsername.isNotEmpty && savedUsername != "") {
      accountName.value = savedUsername;
      accountPassword.value = userPassword!;
      _handleLogin(name: savedUsername, loginPassword: userPassword);
      print('曾經有帳號輸入過');
    } else {
      print('曾經無帳號輸入過');
    }
  }

  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormError(errors: errors), //錯誤訊息通知
          SizedBox(height:  getProportionateScreenHeight(15)),
          buildAccountFormField(), //輸入帳號的格子
          SizedBox(height: getProportionateScreenHeight(15),),
          buildPasswordFormField(), //輸入密碼的格子
          Padding( //設定登入按鈕
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
            child: LoginButton(
              press: () async{
                if(_formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  accountName.value= account.toString();
                  _handleLogin(name: account.toString(), loginPassword: password.toString());
                  }
                }
            ),
          ),
          Padding( //設定登入按鈕
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(8)),
            child:
            InkWell(
              onTap: (){
                accountName.value= "0000";
                _handleLogin(name: "0000", loginPassword: "0000");
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.height*0.03,
                child: Center(
                  child: Text("訪客登入",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.025,
                        color: Colors.blue
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

TextFormField buildAccountFormField(){
  return TextFormField(
    keyboardType: TextInputType.number,
    onSaved: (newValue) => account = newValue,
    onChanged: (value){
      if (value.isNotEmpty){
        removeError(error: kAccountNullError);
      }
    },
    validator: (value){
      if(value!.isEmpty){
        addError(error: kAccountNullError);
        return "";
      }
      return null;
    },
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kSecondaryColor,width: 3),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kSecondaryColor,width: 3),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kSecondaryColor,width: 3),
        gapPadding: 10,
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25),vertical: getProportionateScreenHeight(10)),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
            color: kSecondaryColor,
          ),
          height: getProportionateScreenHeight(40),
          child: Text("帳 號",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(42),
                color: kPrimaryColor,
                backgroundColor: kSecondaryColor,
                textBaseline: TextBaseline.ideographic,
                height: 1.1
            ),
          ),
        ),
      ),
    ),
    style: TextStyle(fontSize: getProportionateScreenHeight(20)),
  );
}

TextFormField buildPasswordFormField(){
  return TextFormField(
    keyboardType: TextInputType.number,
    obscureText: true,
    onSaved: (newValue) => password = newValue,
    onChanged: (value){
      if (value.isNotEmpty){
        removeError(error: kPassNullError);
      }
    },
    validator: (value){
      if (value!.isEmpty) {
        addError(error: kPassNullError);
        return "";
      }
      return null;
    },
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kSecondaryColor,width: 3),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kSecondaryColor,width: 3),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kSecondaryColor,width: 3),
        gapPadding: 10,
      ),
      prefixIcon:Padding(
        padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25),vertical: getProportionateScreenHeight(10)),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
            color: kSecondaryColor,
          ),
          height: getProportionateScreenHeight(40),
          child: Text("密 碼",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(42),
              color: kPrimaryColor,
              backgroundColor: kSecondaryColor,
                textBaseline: TextBaseline.ideographic,
              height: 1.1
            ),
          ),
        ),
      ),
    ),
    style: TextStyle(fontSize: getProportionateScreenHeight(20)),
  );
}
}