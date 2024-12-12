import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:pick_a_card/list.dart';

const double kCardHeight = 225;
const double kCardWidth = 389;

const double kSpaceBetweenCard = 24;
const double kSpaceBetweenUnselectCard = 32;
const double kSpaceUnselectedCardToTop = 320;

const Duration kAnimationDuration = Duration(milliseconds: 245);

class CreditCardData {
  CreditCardData({required this.bankName, required this.holderName, required this.cardNumber, required this.expDate, required this.backgroundColor});
  final Color backgroundColor;
  final String holderName;
  final String cardNumber;
  final String expDate;
  final String bankName;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner:false,
      home:
StackedList()

   /*   
       MainPage(
        cardsData: [
          CreditCardData(
            backgroundColor: Colors.orange, holderName: 'Mustafa Hisham Salama', cardNumber: '374245455400126', expDate: '05/2029',bankName: "BOK"
          ),
          CreditCardData(
            backgroundColor: Colors.grey.shade900, holderName: 'Hisham Salama Mustafa', cardNumber: '374245455400127', expDate: '08/2029',bankName: "BOK"
          ),
          CreditCardData(
            backgroundColor: Colors.cyan, holderName: 'Salama Mustafa Hisham', cardNumber: '374245455400987', expDate: '09/2029',bankName: "BOK"
          ),
          CreditCardData(
            backgroundColor: Colors.blue, holderName: 'Mojtaba Hisham Salama', cardNumber: '374245455400006', expDate: '02/2029',bankName: "BOK"
          ),
          CreditCardData(
            backgroundColor: Colors.purple, holderName: 'Mustafa Salama Mustafa', cardNumber: '374245455400765', expDate: '03/2029',bankName: "MOC"
          ),
        ],
      ),
    
    */
    
    
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    this.cardsData = const [],
    this.space = kSpaceBetweenCard,
  });

  final List<CreditCardData> cardsData;
  final double space;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? selectedCardIndex;

  late final List<CreditCard> creditCards;

  @override
  void initState() {
    super.initState();

    creditCards = widget.cardsData
        .map((data) => CreditCard(
      card: data,
    ))
        .toList();
  }

  int toUnselectedCardPositionIndex(int indexInAllList) {
    if (selectedCardIndex != null) {
      if (indexInAllList < selectedCardIndex!) {
        return indexInAllList;
      } else {
        return indexInAllList - 1;
      }
    } else {
      throw 'Wrong usage';
    }
  }

  double _getCardTopPosititoned(int index, isSelected) {
    if (selectedCardIndex != null) {
      if (isSelected) {
        return widget.space;
      } else {
        /// Space from top to place put unselect cards.
        return kSpaceUnselectedCardToTop +
            toUnselectedCardPositionIndex(index) * kSpaceBetweenUnselectCard;
      }
    } else {
      /// Top first emptySpace + CardSpace + emptySpace + ...
      return widget.space + index * kCardHeight + index * widget.space;
    }
  }

  double _getCardScale(int index, isSelected) {
    if (selectedCardIndex != null) {
      if (isSelected) {
        return 1.0;
      } else {
        int totalUnselectCard = creditCards.length - 1;
        return 1.0 -
            (totalUnselectCard - toUnselectedCardPositionIndex(index) - 1) *
                0.05;
      }
    } else {
      return 1.0;
    }
  }

  void unSelectCard() {
    setState(() {
      selectedCardIndex = null;
    });
  }

  double totalHeightTotalCard() {
    if (selectedCardIndex == null) {
      final totalCard = creditCards.length;
      return widget.space * (totalCard + 1) + kCardHeight * totalCard;
    } else {
      return kSpaceUnselectedCardToTop +
          kCardHeight +
          (creditCards.length - 2) * kSpaceBetweenUnselectCard +
          kSpaceBetweenCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('PICK A CARD',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AnimatedContainer(
                duration: kAnimationDuration,
                height: totalHeightTotalCard(),
                width: mediaQuery.size.width,
              ),

              for (int i = 0; i < creditCards.length; i++)
                AnimatedPositioned(
                  top: _getCardTopPosititoned(i, i == selectedCardIndex),
                  duration: kAnimationDuration,
                  child: AnimatedScale(
                    scale: _getCardScale(i, i == selectedCardIndex),
                    duration: kAnimationDuration,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCardIndex = i;
                            });
                          },
                          child: creditCards[i],
                        ),

                      ],
                    ),
                  ),
                ),
              
              
              
              
              if(selectedCardIndex!=null)
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50.0,left: 30),
                    child: Visibility(
                      visible: selectedCardIndex != null?true:false,
                      child: Row(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            color: creditCards[selectedCardIndex!].card.backgroundColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.add,
                              size: 24,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            color: creditCards[selectedCardIndex!].card.backgroundColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.edit,
                              size: 24,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            color: creditCards[selectedCardIndex!].card.backgroundColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.delete,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (selectedCardIndex != null)
                Positioned.fill(
                    child: GestureDetector(
                      onVerticalDragEnd: (_) {
                        unSelectCard();
                      },
                      onVerticalDragStart: (_) {
                        unSelectCard();
                      },
                    ))
            ],
          ),
        ),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  const CreditCard({
    super.key,
    required this.card,
  });

  final CreditCardData card;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CreditCardWidget(
           cardType: CardType.mastercard,
            cardNumber: card.cardNumber,
            expiryDate: card.expDate,
            cardHolderName: card.holderName,
            bankName: card.bankName,
            cvvCode: '123',
            isHolderNameVisible: true,
            showBackView: false,
            isChipVisible: false,
            isSwipeGestureEnabled: false,
            height: kCardHeight,
            width: kCardWidth,
            cardBgColor: card.backgroundColor,
            onCreditCardWidgetChange: (_) {},
          ),

        ],
      ),
    );
  }
}