import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'RatingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  bool isFavorite = false;
  int quantity = 0;
  double productRating = 3.5;
  bool isForSale = true; // Adjust the value based on your logic

  // @override
  // void initState() {
  //   super.initState();
  //   _fApp = Firebase.initializeApp();
  // }
  String ProductName = '';
  String ProductDescription = '';
  String ProductPhoto = '';
  String Status = '';
  String StartBidAmount = '0';
  String Category_Id = '0';
  // String Seller_Id = '0';
  // String shipmentt_Id = '0';

  List<QueryDocumentSnapshot> docs = [];

  getData () async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("product").get();
    docs.addAll(querySnapshot.docs);
    print(docs.length);
    setState(() {
      
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 212, 255),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_circle_left_outlined),
        ),
        title: Text("Product Details: ${docs[0]["ProductDescription"]}"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              Icons.favorite,
              color: isFavorite ? Colors.red : Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    width: 375,
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.network(
                      '${docs[0]["ProductPhoto"]}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${docs[0]["ProductName"]}",
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Text(
                    "Description: ${docs[0]["ProductDescription"]}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Text(
                    "${docs[0]["StartBidAmount"]} EGP",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 185),
                  Container(
                    width: 30,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (quantity > 0) quantity--;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 227, 158, 238),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 232, 130, 248),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            // Updated Row widget for rating
            Row(
              children: [
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            // Displaying gold stars based on the rating
                            for (var i = 0; i < productRating.floor(); i++)
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                              ),
                            // Displaying the half star if applicable
                            if (productRating % 1 != 0)
                              const Icon(
                                Icons.star_half_rounded,
                                color: Colors.amber,
                              ),
                            // Displaying white stars for the remaining
                            for (var i = 0; i < 5 - productRating.ceil(); i++)
                              const Icon(
                                Icons.star_outline_rounded,
                                color: Colors.amber,
                              ),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RatingPage(
                                          averageRating: productRating,
                                          userName: 'Farah',
                                        )));
                          },
                          child: Text('${productRating}'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 10, // Replace this with your actual item count
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Item $index',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 247, 247, 248),
        color: const Color.fromARGB(255, 249, 212, 255),
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {},
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          //Icon(Icons.picture_in_picture),
          Icon(Icons.shopping_cart),
          Icon(Icons.person),
        ],
      ),
      floatingActionButton: isForSale
          ? FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed functionality here
                print('Add to cart tapped!');
              },
              icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
              label: const Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 232, 130, 248),
            )
          : FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed functionality here for booking a ticket
                print('Book a Ticket tapped!');
              },
              icon: const Icon(Icons.confirmation_num, color: Colors.black),
              label: const Text(
                'Book a Ticket',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 232, 130, 248),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: ProductInfo(),
  ));
}