import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FireStoreHelper{
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();
  CollectionReference<Map<String, dynamic>>  productCollectionRefrence= FirebaseFirestore.instance.collection('products');


  addNewProduct(Product product)async{
    await productCollectionRefrence.add(product.toMap());
  }

  Future<List<Product>> getAllProducts() async{
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await productCollectionRefrence.get();
    List<QueryDocumentSnapshot<Map<String,dynamic>>> documents = querySnapshot.docs;
    List<Product> products =  documents.map((e) {
      Product product = Product.fromMap(e.data());
      product.proId = e.id;
      return product;
    }).toList();
  return products;
  }

  deleteProducts(Product product)async {
    await productCollectionRefrence.doc(product.proId).delete();
  }

}