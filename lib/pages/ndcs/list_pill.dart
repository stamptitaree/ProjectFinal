import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/pages/ndcs/list_pill_detail.dart';
import 'package:mytest/utils/global.colors.dart';

class Listpillsdrug extends StatefulWidget {
  const Listpillsdrug({super.key});

  @override
  State<Listpillsdrug> createState() => _ListpillsdrugState();
}

class _ListpillsdrugState extends State<Listpillsdrug> {
  final TextEditingController searchdrugController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sizeS = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: const Center(
            child: Text('ข้อมูลยา Drug Interaction',
                style: TextStyle(fontFamily: 'Prompt'))),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                // Get.back();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actionsIconTheme: const IconThemeData(
          color: Colors.transparent,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
            child: Row(
              children: [
                const Text('ค้นหา',
                    style: TextStyle(fontFamily: 'Prompt', fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: searchdrugController,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Prompt'),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: GlobalColors.borderInput,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: GlobalColors.borderInput,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SizedBox(
            height: sizeS.height,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('drug_inter')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return snapshot.data!.size == 0
                      ? Center(
                          child: Row(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Expanded(
                                child: Text(
                                  'ว่าง',
                                  style: TextStyle(
                                      // fontFamily: 'FC Minimal',
                                      color: Colors.grey[600],
                                      fontSize: 28,
                                      fontFamily: 'Prompt'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          // scrollDirection: Axis.vertical,
                          // physics: const ClampingScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount: snapshot.data!.size,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ncds = snapshot.data!.docs[index];
                            List<dynamic> dataArray = ncds['data'];
                            List<Widget> drugListWidgets =
                                dataArray.map((dataMap) {
                                  final drugName = dataMap['drug_list'].toString().toLowerCase();
                                  final searchQuery = searchdrugController.text.toLowerCase();
                              if(drugName.contains(searchQuery)){
                              return GestureDetector(
                                onTap: () {
                                  print(dataMap['drug_list']);
                                  Get.to(() => ListpillDetail(obj: dataMap));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 5, bottom: 5),
                                  child: Container(
                                    // width: sizeS.width,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 145, 113, 113),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: 90,
                                    width: double.maxFinite,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'ยา : ${dataMap['drug_list']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontFamily: 'Prompt'),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          'ปฏิกิริยาระหว่างยา : ${dataMap['drug_inter_list']}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontFamily: 'Prompt'),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Text(
                                          'รายละเอียด : โปรดกดดูข้างใน!',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontFamily: 'Prompt'),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Text(
                                        //     'เวลาทานยา : ${(pill.data() as Map<String, dynamic>)['history_time']}',
                                        //     style: const TextStyle(
                                        //         fontSize: 16,
                                        //         color: Colors.white,
                                        //         fontFamily: 'Prompt')),
                                        // Text(
                                        //     'หมายเหตุ : ${(pill.data() as Map<String, dynamic>)['history_note']}',
                                        //     style: const TextStyle(
                                        //         fontSize: 16,
                                        //         color: Colors.white,
                                        //         fontFamily: 'Prompt')),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              }else {
                                return Container();
                              }
                            }).toList();

                            return Column(
                              children: drugListWidgets,
                            );
                          },
                        );
                }),
          ))
        ],
      ),
    );
  }
}
