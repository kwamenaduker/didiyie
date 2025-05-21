import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:didiyie/tools/demo_helper.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Didi Yie Demo Setup'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Demo Instructions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '1. Use this tool to find reliable file names for your demo',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '2. When taking photos during your demo, save them with the exact same file name',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '3. For consistent results, choose 4 foods that work reliably',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DemoHelper(),
          ),
        ],
      ),
    );
  }
}
