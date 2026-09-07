import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:fooddeliveryapp/services/database.dart";
import "package:fooddeliveryapp/services/shared_pref.dart";
import "package:fooddeliveryapp/services/widget_support.dart";

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id;
  Stream<QuerySnapshot>? ordersStream;
  getthesharedpref() async{
    id=await SharedpreferenceHelper.getUserId();



  }

  getontheload() async{
    await getthesharedpref();
    ordersStream=await DataBaseMethods.getUserOrders(id!);
    setState(() {

    });

  }


  @override
  void initState(){

    super.initState();
    getontheload();
  }

  Widget allOrders() {
    return StreamBuilder(
        stream: ordersStream, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData ? ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshot.data.docs.length,

          itemBuilder: (context, index) {

          DocumentSnapshot ds=snapshot.data.docs[index];


          return    Container(
            margin: EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0 ),

            child: Material(
              elevation:3.0 ,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              child: Container(
                margin: EdgeInsets.only(left:20.0,right: 20.0 ),
                width: MediaQuery.of(context).size.width,
               // padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),

                child:Column(
                  children:[
                    SizedBox(height:5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined,
                          color: Color(0xffef2b39),),
                        SizedBox(width:10.0),
                        Text(ds['Address'],style: AppWidget.SimpleTextField(),),

                      ],
                    ),
                    Divider(),
                    Row(
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Image.asset(ds['FoodImage'],
                            height:120,
                            width:120,
                            fit:BoxFit.cover),
                        SizedBox(width:20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(ds['FoodName'], style:AppWidget.boldTextFieldStyle()),

                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Icon(Icons.format_list_numbered, color:Color(0xffef2b39)),
                                SizedBox(width:10.0),
                                Text(ds['Quantity'], style:AppWidget.boldTextFieldStyle()),
                                SizedBox(width: 10.0,),

                                Icon(Icons.monetization_on, color:Color(0xffef2b39)),
                                SizedBox(width:10.0),
                                Text(ds["Total"], style:AppWidget.boldTextFieldStyle())
                              ],
                            ),

                            SizedBox(height: 5.0,),

                            Text(ds['Status']+"!",style:TextStyle( color:Color(0xffef2b39),fontSize: 20.0, fontWeight: FontWeight.bold)


                            ),


                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );

          }) : Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Container(
        margin: EdgeInsets.only(top:40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Orders",style: AppWidget.HeadlineTextField(),),
              ],),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color:Color(0xffececf8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),

                ),

                child:Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                        height: MediaQuery.of(context).size.height/1.5,
                        child: allOrders()),




                      ],
                    ),

                ),
              ),

          ],
        )
      )


    ),
    );
  }
}
