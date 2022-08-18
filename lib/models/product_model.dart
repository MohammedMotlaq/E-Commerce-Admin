class Product{
  late String proId;
  late String productName;
  late String imageUrl;
  late String price;
  Product({
    required this.productName,
    required this.imageUrl,
    required this.price,
  });
  Product.fromMap(Map<String,dynamic> map){
    productName = map['productName'];
    imageUrl = map['imageUrl'];
    price = map['price'];
  }
  toMap(){
    return{
      'productName': productName,
      'imageUrl': imageUrl,
      'price': price
    };
  }
}