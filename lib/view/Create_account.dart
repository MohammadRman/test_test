import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Home_controller.dart';
Home_controller cc = Get.find();



class Create_account extends GetView<Home_controller> {
  const Create_account({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Create account',
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
                    'Create account',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 13,),
                  Form(key: controller.f3,child: Column(mainAxisSize: MainAxisSize.min,children: [
                     TextFormField(
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'isEmpty';
                        }else{
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        controller.get_n(newValue!);
                      
                      },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        hintText: 'na'),
                  ),
                     TextFormField(
                      validator: (value) {
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
                        if(value!.length == 6){
                          return null;
                        }else{
                          return '6';
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

                  ],) ),
                  
                 
                  SizedBox(height: 18,)
               ,MaterialButton(onPressed:()async{
                controller.cr();
               },child: Text('create account'),color: Colors.blue,textColor: Colors.white,
               shape: StadiumBorder(),padding: EdgeInsets.symmetric(horizontal: 90,vertical: 13),) ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

