import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:softbenz/components/color.dart';
import 'package:softbenz/components/utils.dart';
import 'package:softbenz/localNotification/localNotification.dart';
import 'package:softbenz/views/buyNowViews/buyNowScreen.dart';
import 'package:softbenz/views/cartViews/cartScreen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedVariantIndex = 0; // To manage product variant selection
  //int _quantity = 1; // To manage product quantity

  // Sample product details (can be fetched via an API)

  final double price = 13499;
  final double strikePrice = 13499;
  final int stock = 10;

  final List<String> variants = ["Blue", "Green"];
  final List<String> images = [
    "https://meladigitalbazaar.s3.amazonaws.com/product_images/16659007068185828.jpg",
    "https://meladigitalbazaar.s3.amazonaws.com/product_images/16659014953347945.jpg",
    "https://meladigitalbazaar.s3.amazonaws.com/product_images/1665901500264035.jpg",
    "https://meladigitalbazaar.s3.amazonaws.com/product_images/16659015045075274.jpg",
    "https://meladigitalbazaar.s3.amazonaws.com/product_images/16659007108383741.jpg",
  ];

  /*******Product image on full screen code*****/
  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
          body: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }

  /***********Permission to send notification**********/
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Get the screen size

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Container(
            padding: EdgeInsets.only(
              top: 3,
              bottom: 3,
              left: size.width / 4.2,
              right: size.width / 4.2,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
                width: 0.5,
              ),
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            child: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.share,
            ),
            onPressed: () {
              Share.share("Dipesh Jaiswal");
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz_rounded,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 7, right: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Images Section
              GestureDetector(
                onTap: () => _showFullScreenImage(
                    context, images[_selectedVariantIndex]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  child: Image.network(
                    images[_selectedVariantIndex], // Display the selected image
                    height: size.height * 0.35,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //Feature images section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  images.length,
                  (index) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedVariantIndex == index
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedVariantIndex = index),
                      child: Image.network(
                        images[index],
                        width: size.width *
                            0.15, // Dynamic width based on screen size
                        height: size.width *
                            0.15, // Dynamic height based on screen size
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // Product Name
              const SizedBox(height: 16),
              const Text(
                "Realme C30",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // Price and Discount Section
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "\Rs.${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "\Rs.${strikePrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "(${((strikePrice - price) / strikePrice * 100).toStringAsFixed(0)}% OFF)",
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),

              // Product Variant Selector
              const SizedBox(height: 16),
              const Text("Select Color", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  variants.length,
                  (index) => GestureDetector(
                    onTap: () => setState(() => _selectedVariantIndex = index),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedVariantIndex == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(variants[index]),
                    ),
                  ),
                ),
              ),

              // Stock Availability
              const SizedBox(height: 16),
              Text(
                "Stock: $stock available",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              // Product Description
              const SizedBox(height: 16),
              const Text(
                "Description",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                productDescription,
                style:  TextStyle(fontSize: 16),
              ),

              // Product Specifications
              const SizedBox(height: 24),
              const Text(
                "Specifications",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "• Brand: Realme",
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                "• Warranty: 1 year Brand warranty",
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                "• Colors: Lake Blue, Bamboo Green",
                style: TextStyle(fontSize: 16),
              ),

              //Variant details
              const SizedBox(height: 24),
              const Text(
                "Variant Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                "• RAM: 2GB, ROM: 32GB, Color: Blue, Price: 13,499",
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                "• RAM: 3GB, ROM: 32GB, Color: Blue, Price: 14,499",
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                "• RAM: 2GB, ROM: 32GB, Color: green, Price: 13,499",
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                "• RAM: 3GB, ROM: 32GB, Color: Green, Price: 14,499",
                style: TextStyle(fontSize: 16),
              ),

              // Customer Reviews Section
              const SizedBox(height: 24),
              const Text(
                "Customer Reviews",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  Icon(Icons.star_border, color: Colors.yellow, size: 20),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "4.5/5 based on 120 reviews",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text("User Reviews",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text(
                "These headphones are amazing! The sound quality is top-notch and the noise cancellation is incredible. I use them for work and travel.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black.withOpacity(0.7),
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.store,
                  size: 30,
                  color: Colors.black.withOpacity(
                    0.6,
                  ),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.chat,
                  size: 30,
                  color: Colors.black.withOpacity(0.6),
                ),
                onPressed: () {
                  _showMessageDialog(context);
                },
              ),
              //Buy now button
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Colors.amber),
                child: TextButton(
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuyNowScreen(),
                      ),
                    );
                  },
                ),
              ),
              //Cart button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.orange,
                      Colors.red,
                    ],
                  ),
                ),
                //width: size.width / 3.5,
                child: TextButton(
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Utils.toastMessage(
                      "Item added to cart successfully!",
                      Colors.green.withOpacity(0.9),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /********Chat message code******/
  void _showMessageDialog(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter message"),
          content: TextField(
            controller: messageController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: "Type your message here",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ],
              ),
              onPressed: () {
                if (messageController.text.isNotEmpty) {
                  triggerNotification();
                  Navigator.of(context).pop();
                } else {
                  Utils.toastMessage(
                    "Empty message",
                    Colors.red,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
