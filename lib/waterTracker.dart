import 'package:flutter/material.dart';
import 'main.dart';
import 'package:intl/intl.dart';

import 'model.dart';

class waterTracker extends StatefulWidget {
  const waterTracker({super.key});

  @override
  State<waterTracker> createState() => _waterTrackerState();
}

class _waterTrackerState extends State<waterTracker> {
  final TextEditingController _glassCountTEController =
      TextEditingController(text: '1');

  List<WaterConsume> WaterConsumeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Tracker App"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.water_rounded),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  glassConsumeButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  glassAmountField(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  'Total: ${totalGlassCount()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            buildglassConsumeList(),
          ],
        ),
      ),
    );
  }

  Widget buildglassConsumeList() {
    return Expanded(
            child: ListView.builder(
                itemCount: WaterConsumeList.length,
                itemBuilder: (context, index) {
                  return buildListTile(WaterConsumeList[index], index+1);
                }),
          );
  }

  Widget buildListTile(WaterConsume waterconsume, int SerialNo) {
    return ListTile(
                  title: Text(DateFormat.yMEd()
                      .add_jms()
                      .format(waterconsume.time)),
                  leading: CircleAvatar(
                    child: Text('${SerialNo}'),
                  ),
                  trailing: Text(
                    waterconsume.glassCount.toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                );
  }

  Widget glassConsumeButton() {
    return GestureDetector(
      onTap: _addWaterConsume,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.blueGrey, width: 8),
          ),
          child: Padding(
              padding: EdgeInsets.all(24), child: Icon(Icons.water_drop))),
    );
  }

  Widget glassAmountField() {
    return SizedBox(
      width: 120,
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Glass Amount',
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
            )),
        controller: _glassCountTEController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
      ),
    );
  }

  void _addWaterConsume() {
    FocusScope.of(context).unfocus();
    int glasscount = int.tryParse(_glassCountTEController.text) ?? 1;
    WaterConsume waterConsume =
        WaterConsume(time: DateTime.now(), glassCount: glasscount);

    WaterConsumeList.insert(0, waterConsume);
    setState(() {
      _glassCountTEController.clear();
    });
  }

  int totalGlassCount() {
    int totalCount = 0;

    for (WaterConsume waterConsume in WaterConsumeList) {
      totalCount += waterConsume.glassCount;
    }

    return totalCount;
  }
}
