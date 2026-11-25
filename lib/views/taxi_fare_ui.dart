// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class TaxiFareUI extends StatefulWidget {
  const TaxiFareUI({super.key});

  @override
  State<TaxiFareUI> createState() => _TaxiFareUIState();
}

class _TaxiFareUIState extends State<TaxiFareUI> {
  // สร้างตัวควบคุม TextField
  TextEditingController distance = TextEditingController();
  TextEditingController time = TextEditingController();

  // สร้างตัวแปรแสดงค่าโดยสารแท็กซี่
  String showMoney = '0.00';
  String showResult = 'บาท';

  @override
  void dispose() {
    distance.dispose();
    time.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Taxi ซู่ซ่า',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(55),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/taxi.png',
                  width: MediaQuery.of(context).size.width * 0.35,
                ),
                Text(
                  'คำนวณค่าโดยสารแท็กซี่',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ระยะทาง (กิโลเมตร) 🛣️',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: distance,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'กรุณากรอกระยะทาง',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เวลารถติด (นาที) ⏰',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: time,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'กรุณากรอกเวลารถติด',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.028,
                ),

                // ปุ่มคำนวณค่าโดยสาร
                ElevatedButton(
                  onPressed: () {
                    // ตรวจสอบว่ากรอกข้อมูลครบหรือไม่
                    if (distance.text.trim().isEmpty ||
                        time.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '⚠️ กรุณากรอกข้อมูลให้ครบถ้วน',
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // แปลงข้อความเป็นตัวเลข
                    double? distanceValue =
                        double.tryParse(distance.text.trim());

                    double? timeValue =
                        double.tryParse(time.text.trim());

                    // ตรวจสอบความถูกต้องของตัวเลข
                    if (distanceValue == null ||
                        timeValue == null ||
                        !distanceValue.isFinite ||
                        !timeValue.isFinite ||
                        distanceValue < 0 ||
                        timeValue < 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '⚠️ กรุณากรอกตัวเลขให้ถูกต้อง',
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // ตัวแปรเก็บค่าโดยสาร
                    double fare = 0;

                    // คำนวณค่าโดยสารตามระยะทาง
                    if (distanceValue <= 1) {
                      fare = 35;
                    } else if (distanceValue <= 10) {
                      fare = 35 + (distanceValue - 1) * 6.50;
                    } else if (distanceValue <= 20) {
                      fare = 93.50 + (distanceValue - 10) * 7.00;
                    } else if (distanceValue <= 40) {
                      fare = 163.50 + (distanceValue - 20) * 8.00;
                    } else if (distanceValue <= 60) {
                      fare = 323.50 + (distanceValue - 40) * 8.50;
                    } else if (distanceValue <= 80) {
                      fare = 493.50 + (distanceValue - 60) * 9.00;
                    } else {
                      fare = 673.50 + (distanceValue - 80) * 10.50;
                    }

                    // เพิ่มค่าโดยสารกรณีรถติด นาทีละ 3 บาท
                    fare = fare + (timeValue * 3.00);

                    // แสดงผลค่าโดยสารบนหน้าจอ
                    setState(() {
                      showMoney = fare.toStringAsFixed(2);
                      showResult = 'บาท';
                    });
                  },
                  child: Text(
                    'คำนวณค่าโดยสาร',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),

                // ปุ่มยกเลิก
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      distance.text = '';
                      time.text = '';
                      showMoney = '0.00';
                      showResult = 'บาท';
                    });
                  },
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),

                // แสดงผลค่าโดยสารแท็กซี่
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ค่าโดยสารแท็กซี่',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        showMoney,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.1,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        showResult,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}