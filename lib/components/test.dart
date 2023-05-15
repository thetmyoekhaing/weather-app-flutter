// Column(
//         children: [
//           Container(
//             decoration: const BoxDecoration(color: Colors.white),
//             child: Container(
//               padding: const EdgeInsets.only(left: 15),
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                   hintText: "Search Task",
//                   suffixIcon: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.search),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: _countriesList.length,
//               itemBuilder: (context, index) {
//                 if (searchController.text.isNotEmpty &&
//                     !_countriesList[index]
//                         .toLowerCase()
//                         .contains(searchController.text.toLowerCase())) {
//                   // Return an empty container if the country name does not start with the search string
//                   return Container();
//                 }
//                 return ListTile(
//                   title: Text(_countriesList[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       )