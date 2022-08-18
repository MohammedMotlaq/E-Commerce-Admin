import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/firestore_provider.dart';
import 'widgets/product_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FireStoreProvider>(
        builder: (x,provider,y){
          return
          provider.products == null?
              const Center(child: CircularProgressIndicator(),):
              ListView.builder(
              itemCount: provider.products!.length,
              itemBuilder: (BuildContext context, int index){
                return ProductWidget(provider.products![index]);
              }
            );
        }
    );

  }
}
