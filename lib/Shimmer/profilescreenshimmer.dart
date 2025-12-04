import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EditScreeenShimmer extends StatelessWidget {
  const EditScreeenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 30,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 70,
                  width: 70,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                ),
              ),SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 25,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.grey,
              ),
                SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.grey,
              ),
                 SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.grey,
              ),
                 SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.grey,
              ),
                 SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 20,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
