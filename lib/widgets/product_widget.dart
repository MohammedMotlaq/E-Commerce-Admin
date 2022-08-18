import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../data/firestore_provider.dart';
import '../models/product_model.dart';

class ProductWidget extends StatelessWidget {
  Product product;
  ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Container(
          width: 343.w,
          height: 104.h,
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 248, 238, 1.0),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              Image.network(product.imageUrl,width: 104.w,height: 104.h,fit: BoxFit.cover,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width:190.w,
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 15),
                            child: Text(product.productName,style: TextStyle(fontSize: 20),)
                        ),
                        Text(''),
                        Text(product.price+'\$')
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
  Provider.of<FireStoreProvider>(context,listen:false).deleteProduct(product);
                    },
                    child:const Icon(Icons.delete,size: 30,color: Colors.red,)
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
