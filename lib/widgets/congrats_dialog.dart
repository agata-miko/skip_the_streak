import 'package:flutter/material.dart';
import 'package:skip_the_streak/constants/congrats_slogans.dart';

class CongratulationsDialog extends StatelessWidget {
  final int habitNumber;  // Liczba ukończonych akcji

  const CongratulationsDialog({Key? key, required this.habitNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Kopiowanie listy sloganów i przetasowanie jej
    final slogansList = List<String>.from(encouragingSlogans);
    slogansList.shuffle();

    // Losowy slogan
    final randomSlogan = slogansList.first;

    // Zamieniamy wstawki {habitNumber} w sloganie
    final customSlogan = randomSlogan.replaceAll('{habitNumber}', habitNumber.toString());

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();  // Zamknij dialog po kliknięciu
      },
      child: Dialog(
        backgroundColor: Colors.white,  // Kolor tła dialogu
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: EdgeInsets.all(20),// Zmniejszamy wysokość
          child: Stack(
            alignment: Alignment.center,  // Wyrównanie elementów w centrum
            children: [
              // Tekst w środku
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    customSlogan,  // Wyświetl losowy slogan z liczbą
                    style: TextStyle(
                      fontSize: 30,  // Większa czcionka dla lepszej widoczności
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,  // Kolor tekstu
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
