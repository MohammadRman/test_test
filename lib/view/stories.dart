import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matcher/matcher.dart';

import '../controller/Home_controller.dart';
import '../controller/stories_controller.dart';


stories_contlooer vv = Get.find();

class stories extends GetView<stories_contlooer> {
const stories({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
      Get.back();
    },),backgroundColor: Colors.white
    ,centerTitle: true,title: Text('stories',style: 
    TextStyle(color: Colors.black),),),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(child: Column(children: [
        Form(key: controller.e1,child: Column(mainAxisSize: MainAxisSize.min,children: [
          TextFormField(validator: (value) {
            if(value!.isEmpty){
              return 'isEmpty';
            }else{
              return null;
            }
            
          },onSaved: (vv){
            controller.title1(vv!);
          }
          ,decoration: InputDecoration(border: OutlineInputBorder()),),
          SizedBox(height: 18,),
          TextFormField(
            validator: (value) {
            if(value!.isEmpty){
              return 'isEmpty';
            }else{
              return null;
            }
            
          },onSaved: (vv){
            controller.body2(vv!);
          },decoration: InputDecoration(border: OutlineInputBorder()),)

        ],)),
        SizedBox(height: 10,),
        MaterialButton(onPressed:()async{
          controller.hh();
        },child: Text('images'),textColor: Colors.white,color: Colors.blue,),
        SizedBox(height: 10,),
        MaterialButton(onPressed:()async{
          controller.add();

        },child: Text("Add"),textColor: Colors.white,color: Colors.blue,)
        
      ],mainAxisSize: MainAxisSize.min),),
    )
    );

  }
}