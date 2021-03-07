// import 'package:awesome_card/awesome_card.dart';
// import 'package:awesome_card/credit_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_challange/src/models/user/user_model.dart';
// import 'package:flutter_challange/src/providers/user/user_bloc.dart';
// import 'package:provider/provider.dart';

// class DummyCard extends StatelessWidget {
//   static const String routeName = '/dummy';
//   @override
//   Widget build(BuildContext context) {
//     // Panggil file bloc tadi
//     // Untuk dijalankan function fetchDatanya didalam class home ini
//     final UserBloc bloc = Provider.of<UserBloc>(context);
//     bloc.fecthData();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Simple Fecth Data With Provider"),
//       ),
//       body: bloc.listUser == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: bloc.listUser.length,
//               itemBuilder: (context, index) {
//                 final UserModel data = bloc.listUser[index];
//                 return GestureDetector(
//                   onTap: () {
//                     bloc.userId = data.id;
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => DetailPage(id: data.id)));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 16),
//                     child: CreditCard(
//                       cardNumber: data.phone,
//                       cardExpiry: "10/25",
//                       cardHolderName: data.name,
//                       cvv: "456",
//                       bankName: data.company.name,
//                       cardType: CardType
//                           .masterCard, // Optional if you want to override Card Type
//                       showBackSide: false,
//                       frontBackground: CardBackgrounds.black,
//                       backBackground: CardBackgrounds.white,
//                       showShadow: true,
//                     ),
//                   ),
//                 );
//               }),
//     );
//   }
// }
