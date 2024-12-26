import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task1/app_screens/home_screens/add_task.dart';
 import 'package:task1/app_widgets/filter_button.dart';
import '../../app_helpers/asset_helper.dart';
 import '../../app_models/task_model.dart';
import '../../app_providers/task_provider.dart';

import '../../app_helpers/constant.dart';
import '../../app_widgets/card_widget.dart';
import '../../app_widgets/custom_textfield.dart';
 import '../../app_widgets/floating_button.dart';
import '../../app_widgets/task_field.dart';
import 'card_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<TaskProvider>(context, listen: false);
    provider.getTasks();
  }
    @override
    Widget build(BuildContext context) {
      final provider = Provider.of<TaskProvider>(context, listen: false);
      return Scaffold(
          appBar: buildAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: searchController,
                  onChanged: (value) {
                    provider.searchTask(value);
                  },
                ),
                kheightBoxed(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // "My Tasks" Text
                    Text(
                      "My Tasks",
                      style: GoogleFonts.robotoSerif().copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// Toggle buttons for sorting
                    const FilterButtons()

                  ],
                ),

                kheightBoxed(),
                CardList(provider: provider),
              ],
            ),
          ),
          floatingActionButton: FloatingButton(
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen(isUpdate: false,
                  task: Task(taskName: '', description: '',
                      dateAdded: ''))));
            },
          ));
    }

    AppBar buildAppBar() {
      return AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF2F5FF),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('EEEE').format(DateTime.now()),
                style: GoogleFonts.robotoSerif().copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            Text(
              DateFormat('MMM dd, yyyy').format(DateTime.now()),
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(AssetHelper.bg),
              child: Icon(Icons.person, color: Colors.white,),
            ),
          )
          // FilterButton()
        ],
      );
    }


  }


