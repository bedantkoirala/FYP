import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/routes/app_pages.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          flexibleSpace: Center(
            child: Image.asset(
              'assets/logo.png',
              height: 130,
            ),
          ),
          title: const Text(
            '',
            style: TextStyle(
              color: Color(0xFF07364A),
            ),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (context) {
              return IconButton(
                padding: EdgeInsets.zero, // Remove padding around the icon
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
                color:
                    const Color(0xFF07364A), // Set hanger icon color to white
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchView(),
                    query: '',
                  );
                },
                icon: const Icon(Icons.search),
                color: const Color(0xFF07364A),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF07364A),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to Booksala',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'booksala2024@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text(
                'Genre',
                style: TextStyle(
                  fontSize: 15, // Reduce font size for categories
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Generate list of categories here
            if (controller.categories != null)
              ...controller.categories!.map((category) {
                return ListTile(
                  leading: Icon(Icons.arrow_right),
                  title: Text(
                    category.categoryTitle ?? '',
                    style: TextStyle(
                      fontSize: 13, // Reduce font size for category items
                      fontWeight: FontWeight.bold,
                      color: Colors.black87, // Use standard text color
                    ),
                  ),
                  onTap: () {
                    // Navigate to category detail page when tapped
                    Get.toNamed(
                      Routes.DETAIL_CATEGORY,
                      arguments: category,
                    );
                  },
                );
              }).toList(),

            Divider(), // Divider after Profile
            ListTile(
              leading: Icon(Icons.card_membership),
              title: Text(
                'Membership Plan',
                style: TextStyle(
                  fontSize: 15, // Reduce font size for clarity
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Navigate to membership plan page when tapped
                Get.toNamed(Routes.BUY_MEMBERSHIP);
              },
            ),
            Divider(), // Divider after Membership Plan
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 15, // Reduce font size for clarity
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Navigate to order details page when tapped
                Get.toNamed(Routes.ORDER);
              },
            ),
            Divider(), // Divider after Order Details
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                'About Us',
                style: TextStyle(
                  fontSize: 15, // Reduce font size for clarity
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Navigate to about us page when tapped
                Get.toNamed(Routes.ABOUT_US);
              },
            ),
          ],
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.categories == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                right: 10,
                left: 10,
                top: 0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 0), // Reduce the top space
                  // Categories list
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.BUY_MEMBERSHIP);
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Image.asset(
                                  'assets/book.png',
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: const Border(
                                        bottom: BorderSide(
                                          color: Colors.white,
                                          width: 5,
                                        ),
                                      ),
                                      color: Colors.black.withOpacity(0.2)),
                                  padding: const EdgeInsets.all(10),
                                ),
                              ),
                              const Positioned(
                                left: 10,
                                bottom: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Become a Member',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Get exclusive offers and discounts',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        const Text(
                          'Genre',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromARGB(255, 82, 81, 81),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Generate list of categories here
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categories?.length,
                            itemBuilder: (context, index) {
                              var category = controller.categories?[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.DETAIL_CATEGORY,
                                    arguments: category,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Chip(
                                    label: Text(category?.categoryTitle ?? ''),
                                    backgroundColor: const Color(0xFF07364A),
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        // Wrap(
                        //   spacing: 16,
                        //   children:
                        //       (controller.categories ?? []).map((category) {
                        //     return GestureDetector(
                        //       onTap: () {
                        //         Get.toNamed(
                        //           Routes.DETAIL_CATEGORY,
                        //           arguments: category,
                        //         );
                        //       },
                        //       child: Chip(
                        //         label: Text(category.categoryTitle ?? ''),
                        //         backgroundColor: const Color(0xFF07364A),
                        //         labelStyle: const TextStyle(
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ), // Add spacing between categories and featured items

                  // Featured Books text
                  const Padding(
                    padding: EdgeInsets.only(
                        right: 250, bottom: 20, top: 20), // Adjusted padding
                    child: Text(
                      'Featured Books',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 82, 81, 81),
                      ),
                      textAlign: TextAlign.left, // Align text to the left
                    ),
                  ),

                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.products?.length ?? 0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (context, index) => ProductCard(
                      product: controller.products![index],
                      category: controller.products![index].categoryTitle ?? '',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

HomeController controller = Get.find();

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isNotEmpty) {
            query = '';
          } else {
            close(context, null);
          }
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestions = [];
    suggestions = query.trim().isEmpty
        ? []
        : controller.products
                ?.where((element) =>
                    element.title
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false)
                .toList() ??
            [];

    if (suggestions.isEmpty && query.isNotEmpty) {
      return Center(
        child: SizedBox(
          width: Get.width * 0.6,
          child: const Text(
            'No Books Found!',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (suggestions.isEmpty) {
      return const Center(
        child: Text(
          'Search for Books!',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10), // Adjust padding
      shrinkWrap: true,
      itemCount: suggestions.length,
      itemBuilder: (context, index) => SearchCard(product: suggestions[index]),
    );
  }
}
