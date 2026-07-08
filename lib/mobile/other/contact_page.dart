// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ContactUsPage extends StatelessWidget {
//   const ContactUsPage({super.key});

//   final String phone = "+919876543210";
//   final String whatsapp = "+919876543210";
//   final String email = "support@rentloco.com";
//   final String website = "https://rentloco.com";
//   final String address =
//       "Mind You Infotech Pvt. Ltd.\nLucknow, Uttar Pradesh, India";

//   Future<void> _launch(String url) async {
//     final uri = Uri.parse(url);

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF5F6FA),

//       appBar: AppBar(
//         title: const Text("Contact Us"),
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [

//             CircleAvatar(
//               radius: 45,
//               backgroundColor: Colors.amber.shade100,
//               child: const Icon(
//                 Icons.support_agent,
//                 color: Colors.amber,
//                 size: 45,
//               ),
//             ),

//             const SizedBox(height: 15),

//             const Text(
//               "We're Here to Help",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 6),

//             Text(
//               "Contact our support team anytime.",
//               style: TextStyle(
//                 color: Colors.grey.shade700,
//               ),
//             ),

//             const SizedBox(height: 25),

//             _contactTile(
//               icon: Icons.call,
//               color: Colors.green,
//               title: "Call Us",
//               subtitle: phone,
//               onTap: () {
//                 _launch("tel:$phone");
//               },
//             ),

//             _contactTile(
//               icon: Icons.chat,
//               color: Colors.green,
//               title: "WhatsApp",
//               subtitle: whatsapp,
//               onTap: () {
//                 _launch(
//                   "https://wa.me/${whatsapp.replaceAll("+", "")}",
//                 );
//               },
//             ),

//             _contactTile(
//               icon: Icons.email,
//               color: Colors.red,
//               title: "Email Us",
//               subtitle: email,
//               onTap: () {
//                 _launch("mailto:$email");
//               },
//             ),

//             _contactTile(
//               icon: Icons.language,
//               color: Colors.blue,
//               title: "Website",
//               subtitle: website,
//               onTap: () {
//                 _launch(website);
//               },
//             ),

//             Card(
//               margin: const EdgeInsets.only(top: 15),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(18),
//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                   children: [

//                     const Row(
//                       children: [

//                         Icon(
//                           Icons.location_on,
//                           color: Colors.amber,
//                         ),

//                         SizedBox(width: 10),

//                         Text(
//                           "Office Address",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 15),

//                     Text(
//                       address,
//                       style: const TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),

//                     const Divider(height: 30),

//                     const Row(
//                       children: [

//                         Icon(
//                           Icons.access_time,
//                           color: Colors.amber,
//                         ),

//                         SizedBox(width: 10),

//                         Text(
//                           "Support Hours",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 10),

//                     const Text(
//                       "Monday - Saturday\n09:00 AM - 07:00 PM",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _contactTile({
//     required IconData icon,
//     required Color color,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 15),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: ListTile(
//         onTap: onTap,
//         leading: CircleAvatar(
//           backgroundColor: color.withOpacity(.12),
//           child: Icon(
//             icon,
//             color: color,
//           ),
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Icons.arrow_forward_ios),
//       ),
//     );
//   }
// }