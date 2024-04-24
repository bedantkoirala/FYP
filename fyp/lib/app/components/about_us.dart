import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            color: Color(0xFF07364A),
            fontFamily: 'YourCustomFont',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            // Add a Hero animation for the logo
            Hero(
              tag: 'logo', // Unique tag for the logo animation
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Welcome to Book Sala',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF07364A),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'At Book Sala, we are dedicated to providing an extensive and diverse selection of books that cater to a wide range of tastes and interests. From timeless classics to contemporary bestsellers, academic resources to niche subjects, our curated collection ensures that there\'s something for every reader to discover and enjoy. With a passion for literature and a commitment to providing exceptional service, Book Sala is here to enrich your reading experience and fuel your love for books.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                fontFamily: 'YourCustomFont',
              ),
            ),
            SizedBox(height: 40.0),
            Text(
              'Membership Benefits and Convenient Shopping',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF07364A),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Unlock a world of benefits with Book Sala\'s membership program. Our valued members enjoy exclusive perks, including a generous 15% discount on every book purchase, making it easier than ever to indulge in your literary cravings. Plus, with our seamless and user-friendly interface, browsing and shopping for your favorite books has never been more convenient. Whether you\'re exploring different categories, searching for specific titles, or simply browsing for inspiration, our platform is designed to streamline your shopping experience and help you find exactly what you\'re looking for. And with secure payment options, including the use of the popular KHALTI app, you can shop with confidence and peace of mind.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                fontFamily: 'YourCustomFont',
              ),
            ),
            SizedBox(height: 40.0),
            Text(
              'Commitment to Excellence and Customer Satisfaction',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF07364A),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'At Book Sala, we are dedicated to excellence in every aspect of our service. From the quality of our book selection to the efficiency of our delivery process, we are committed to exceeding your expectations at every turn. Your satisfaction is our top priority, and we value your feedback as an opportunity to continuously improve and enhance our offerings. Whether you\'re a seasoned bibliophile or a casual reader, we strive to make your experience with Book Sala as enjoyable and rewarding as possible. Thank you for choosing Book Sala as your trusted partner in your literary journey. Join us today and embark on an adventure through the pages of your next favorite book.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                fontFamily: 'YourCustomFont',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
