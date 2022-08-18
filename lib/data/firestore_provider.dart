import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product_model.dart';
import 'firestore_helper.dart';
import 'storage_helper.dart';

class FireStoreProvider extends ChangeNotifier{
  FireStoreProvider(){
    getAllProducts();
  }
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  File? selectedImage;
  List<Product>? products ;
  selectImage() async{
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(xfile!.path);
    notifyListeners();
  }
  addNewProducts()async{
    if(selectedImage != null) {
      String imageUrl = await StorageHelper.storageHelper.uploadImage(selectedImage!);
      Product product = Product(productName: productNameController.text, imageUrl: imageUrl, price: productPriceController.text);
      await FireStoreHelper.fireStoreHelper.addNewProduct(product);
      fillProducts();

    }else{
      log('can not add new product');
    }
  }

  getAllProducts()async{
    products= await FireStoreHelper.fireStoreHelper.getAllProducts();
    notifyListeners();
  }

  deleteProduct(Product product)async{
    products = await FireStoreHelper.fireStoreHelper.deleteProducts(product);
    fillProducts();
  }
  fillProducts()async{
    await getAllProducts();

  }

}