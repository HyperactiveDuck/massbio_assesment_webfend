import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<dynamic> fetchData() async {
    final url = Uri.parse(
        'https://api-dev.massbio.info/assignment/query?page=2&page_size=5');

    final headers = {'Content-Type': 'application/json'};
    final body = "{}"; // Replace with your actual data

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // successful request
        final data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        // handle error
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // handle exception
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int filteredPageSize = 35;
    int pageSize = 30;
    final List<String> UVOptions = ['Option 1', 'Option 2', 'Option 3'];
    final List<String> EVOptions = ['Option 4', 'Option 5', 'Option 6'];
    final List<String> symbolOptions = ['Option 7', 'Option 8', 'Option 9'];
    String selectedUVOption = '';
    String selectedEVOption = '';
    String selectedSymbolOption = '';
    int AFVCFMin;
    int AFVCFMax;
    int DPMin;
    int DPMax;
    int dannScoreMin;
    int dannScoreMax;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Search Name',
                      icon: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: const Icon(
                            Icons.search,
                          ),
                          onTap: () {
                            //Search
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomPopup(
                  content: SizedBox(
                    height: 510,
                    width: 300,
                    child: Column(
                      children: [
                        const Text('Search Filters'),
                        const SizedBox(
                          height: 10,
                        ),
                        StatefulBuilder(
                          builder: (context, setState) =>
                              PopupMenuButton<String>(
                            onSelected: (value) => setState(() {
                              selectedUVOption = value;
                              debugPrint(selectedUVOption);
                            }),
                            child: ListTile(
                              title: Text(selectedUVOption.isEmpty
                                  ? 'Uploaded Variation'
                                  : selectedUVOption),
                            ),
                            itemBuilder: (context) =>
                                UVOptions.map((option) => PopupMenuItem(
                                      value: option,
                                      child: Text(option),
                                    )).toList(),
                          ),
                        ),
                        StatefulBuilder(
                          builder: (context, setState) =>
                              PopupMenuButton<String>(
                            onSelected: (value) => setState(() {
                              selectedEVOption = value;
                              debugPrint(selectedEVOption);
                            }),
                            child: ListTile(
                              title: Text(selectedEVOption.isEmpty
                                  ? 'Existing Variation'
                                  : selectedEVOption),
                            ),
                            itemBuilder: (context) =>
                                EVOptions.map((option) => PopupMenuItem(
                                      value: option,
                                      child: Text(option),
                                    )).toList(),
                          ),
                        ),
                        StatefulBuilder(
                          builder: (context, setState) =>
                              PopupMenuButton<String>(
                            onSelected: (value) => setState(() {
                              selectedSymbolOption = value;
                              debugPrint(selectedSymbolOption);
                            }),
                            child: ListTile(
                              title: Text(selectedSymbolOption.isEmpty
                                  ? 'Symbol'
                                  : selectedSymbolOption), // Update text based on selectedOption
                            ),
                            itemBuilder: (context) => symbolOptions
                                .map((option) => PopupMenuItem(
                                      value: option,
                                      child: Text(option),
                                    ))
                                .toList(),
                          ),
                        ),
                        Row(
                          children: [
                            const Text('AF VCF'),
                            const Spacer(),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                onChanged: (value) {
                                  AFVCFMin = int.parse(value);
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Min',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                onChanged: (value) {
                                  AFVCFMax = int.parse(value);
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Max',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('DP'),
                            const Spacer(),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                onChanged: (value) => DPMin = int.parse(value),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Min',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                onChanged: (value) {
                                  DPMax = int.parse(value);
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Max',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Dann Score'),
                            const Spacer(),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                onChanged: (value) {
                                  dannScoreMin = int.parse(value);
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Min',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                onChanged: (value) {
                                  dannScoreMax = int.parse(value);
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Max',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Text('Mondo'),
                            Spacer(),
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Text('Pheno Pumed'),
                            Spacer(),
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Result Amount'),
                            const Spacer(),
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: TextField(
                                onChanged: (value) {
                                  pageSize = int.parse(value);
                                  debugPrint(pageSize.toString());
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              pageSize = filteredPageSize;
                            });
                          },
                          child: const Text('Apply Filters'),
                        ),
                      ],
                    ),
                  ),
                  child: const Icon(Icons.filter_alt_outlined),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mail),
                ),
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              height: screenHeight * 0.8,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    height: 60,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                      child: Row(
                        children: [
                          TableColumn(
                            columnName: 'Name',
                            columnIcon: Icon(Icons.sort),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          TableColumn(
                              columnName: 'Uploaded\nVariation',
                              columnIcon: Icon(Icons.arrow_drop_down_rounded)),
                          SizedBox(
                            width: 60,
                          ),
                          TableColumn(
                              columnName: 'Existing\nVariation',
                              columnIcon: Icon(Icons.arrow_drop_down_rounded)),
                          SizedBox(
                            width: 60,
                          ),
                          TableColumn(
                              columnName: 'Symbol',
                              columnIcon: Icon(Icons.arrow_drop_down_rounded)),
                          SizedBox(
                            width: 60,
                          ),
                          TableColumn(
                              columnName: 'AF VCF',
                              columnIcon: Icon(Icons.arrow_drop_down_rounded)),
                          SizedBox(
                            width: 80,
                          ),
                          TableColumn(
                              columnName: 'DP',
                              columnIcon: Icon(Icons.arrow_drop_down_rounded)),
                          SizedBox(
                            width: 90,
                          ),
                          TableColumn(
                              columnName: 'Dann\nScore',
                              columnIcon: Icon(Icons.arrow_drop_down_rounded)),
                          SizedBox(
                            width: 80,
                          ),
                          TableColumn(
                              columnName: 'Mondo',
                              columnIcon: Icon(Icons.arrow_drop_down_rounded)),
                          SizedBox(
                            width: 60,
                          ),
                          TableColumn(
                              columnName: 'Pheno\nPubmed',
                              columnIcon: Icon(Icons.arrow_drop_down_rounded)),
                          SizedBox(
                            width: 60,
                          ),
                          TableColumn(
                              columnName: 'Details',
                              columnIcon: Icon(Icons.arrow_drop_down_rounded))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredPageSize,
                      itemBuilder: (context, index) {
                        final isEven = index % 2 == 0; // Check if index is even
                        final color = isEven
                            ? Colors.grey
                            : Colors.white; // Set color based on even/odd

                        return Container(
                          height: 40,
                          color: color, // Set the container color
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Name'),
                              Text('Value 1'),
                              Text('Value 2'),
                              Text('Value 3'),
                              Text('Value 4'),
                              Text('Value 5'),
                              Text('Value 6'),
                              Text('Value 7'),
                              Text('Value 8'),
                              Text('Value 9'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text('1-$filteredPageSize'),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TableColumn extends StatelessWidget {
  final String columnName;

  final Icon columnIcon;

  const TableColumn(
      {super.key, required this.columnName, required this.columnIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(columnName),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {},
            child: columnIcon,
          ),
        ),
      ],
    );
  }
}

class ListFilter extends StatelessWidget {
  final String filterName;

  const ListFilter({
    super.key,
    required this.filterName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(filterName),
        const Spacer(),
        CustomPopup(
          showArrow: false,
          content: SizedBox(
            height: 140,
            child: Column(
              children: [
                TextButton(onPressed: () {}, child: const Text('Type 1')),
                TextButton(onPressed: () {}, child: const Text('Type 2')),
                TextButton(onPressed: () {}, child: const Text('Type 3')),
                TextButton(onPressed: () {}, child: const Text('Type 4')),
              ],
            ),
          ),
          child: const Row(
            children: [
              Text('Type 1'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        )
      ],
    );
  }
}
