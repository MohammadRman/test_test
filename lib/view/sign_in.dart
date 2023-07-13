import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_test/controller/Home_controller.dart';
import 'package:test_test/view/Create_account.dart';
import 'Reset password.dart';
Home_controller cc = Get.find();

class Sign_in extends GetView<Home_controller> {
  const Sign_in({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'sign in',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Form(key: controller.f1,child: Column(mainAxisSize: MainAxisSize.min,children: [
                     TextFormField(validator: (value) {
                       if(value!.isEmpty){
                        return 'isEmpty';
                       }else{
                        return null;
                       }
                     },

                     onSaved: (newValue) {
                      controller.emil(newValue!);
                       
                     },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                       if(value!.length != 6 || value.isEmpty){
                        return '6';
                       }else{
                        return null;
                       }
                     },

                     onSaved: (newValue) {
                      controller.password(newValue!);
                       
                     },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.password),
                        hintText: 'Passward'),
                  ),
                  ],)),
                 
                  SizedBox(height: 13,),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.toNamed('/Create');
                                
                              },
                              child: Text('Create an account')),
                          TextButton(
                              onPressed: () {
                                Get.toNamed('/Reset');
                              }, child: Text('Reset password'))
                        ],
                      ),
                    ]
                  ),
                  SizedBox(height: 13,)
               ,MaterialButton(onPressed:()async{
                
                controller.si();

               },child: Text('sign in'),color: Colors.blue,textColor: Colors.white,
               shape: StadiumBorder(),padding: EdgeInsets.symmetric(horizontal: 90,vertical: 13),) ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

