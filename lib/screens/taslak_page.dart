//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:scooter_app/screens/rent_page.dart';

class taslak extends StatefulWidget {
  const taslak({Key? key}) : super(key: key);

  @override
  State<taslak> createState() => _taslakState();
}

class _taslakState extends State<taslak> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Material(
      color: const Color(0xff21254A),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height * .265,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/topImage.png"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 1,
                    left: 10,
                    child: SizedBox(
                      width: 375,
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SafeArea(
                            child: Text(
                              "Ana Ekran",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Kiralayın doya doya gezin !",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: context.onlyTopPaddingLow,
                            child: const SizedBox(
                              height: 46,
                              child: TextField(
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.mic_outlined),
                                  prefixIcon: Icon(Icons.search_outlined),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffF3F4F6),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: context.onlyTopPaddingLow,
                            child: SizedBox(
                              height: context.dynamicHeight(.04),
                              child: ListView.builder(
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index.isOdd) {
                                    return const _ActiveChip();
                                  }
                                  return const _PassiveChip();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              customSizedBox(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: context.dynamicHeight(.3),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return const _HorizontalCard();
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: .0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Cebiniz için önerilen scooterlar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "tümünü gör",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return const _RecomandedCard();
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customSizedBox() => const SizedBox(
        height: 10,
      );

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _RecomandedCard extends StatelessWidget {
  const _RecomandedCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
      child: Row(
        children: [
          Image.network(
            "https://images.pexels.com/photos/159192/vespa-roller-motor-scooter-cult-159192.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            height: 96,
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
          ),
          const Expanded(
            child: ListTile(
              title: Text(
                "ekonomik",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "scooter",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HorizontalCard extends StatelessWidget {
  const _HorizontalCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: context.onlyRightPaddingLow,
          child: Image.network(
            "https://images.pexels.com/photos/159192/vespa-roller-motor-scooter-cult-159192.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: context.paddingLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RentPage()));
                  },
                  icon: const Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: context.paddingLow,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Vespa",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.cyan,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "italyan tasarımıyla dikkat çeken vespa!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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
      ],
    );
  }
}

class _ActiveChip extends StatelessWidget {
  const _ActiveChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: const Text(
        'label active',
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        //textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.deepPurple.shade400,
      padding: context.paddingLow,
    );
  }
}

class _PassiveChip extends StatelessWidget {
  const _PassiveChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: const Text('label passive',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
          )

          //textAlign: TextAlign.center,
          ),
      backgroundColor: Color(0xff21254A),
      padding: context.paddingLow,
    );
  }
}
