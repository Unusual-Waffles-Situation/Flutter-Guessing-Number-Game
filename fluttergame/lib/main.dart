import 'dart:math';

import 'package:flutter/material.dart';

class GuessingGameLogic{
  int randomNumber = Random().nextInt(9) + 1;    // Initialize it by default in a random number between 1 and 10.

  double difficulty = 0;
  
  // Constructor
  GuessingGameLogic();

  void setRandomNumber()
  {
    /*
      Class method to set the random number to be used in the game
    */ 

    switch(difficulty)
    {
      case 0:
        randomNumber = Random().nextInt(9) + 1;

        print(randomNumber);

      case 1:
        randomNumber = Random().nextInt(19) + 1;

      case 2:
        randomNumber = Random().nextInt(99) + 1;

      case 3:
        randomNumber = Random().nextInt(999) + 1;

      default:

        // By default create a random number between 1 and 10, because the default difficulty is 'Easy'
        randomNumber = Random().nextInt(9) + 1;
    }
  }

  bool checkGuess(String guess)
  {
    /*
      Function to check if the guess has been correct. Return true if the player guessed correctly
    */

    int intGuess = int.parse(guess);

    if (intGuess == randomNumber)
    {
      return true;
    }

    else
    {
      return false;
    }
      
  }

  bool isGreaterThanNumber(String guess)
  {
    /*
      Function to check if the number guessed is greater than the random number. Returns true if it's greater
    */ 

    int intGuess = int.parse(guess);

    if (intGuess > randomNumber)
    {
      return true;
    }

    else
    {
      return false;
    }
  }

  // Create sets and gets for the class

  void setDifficulty(double diff){difficulty = diff;}
  double getDifficulty(){return difficulty;}
  int getRandomNumber(){return randomNumber;}
  
}

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override

  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF444444),

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF636363),
          title: Text('Guess the number', 
            style: const TextStyle(
              color: Colors.white,
            )),
           
        ),

        body: const NumberGuessingBody(),

      ),
    );
  } // Build
  
} // MyApp

class NumberGuessingBody extends StatefulWidget{
  const NumberGuessingBody({super.key});

  @override
  NumberGuessingBodyState createState() => NumberGuessingBodyState();
}

class NumberGuessingBodyState extends State<NumberGuessingBody>
{
  // Variables

  double difficulty = 0;
  int attempsNumber = 5;
  String difficultyText = "Easy";
  String attempStrings = "Attemps: 5";
  List<String> lessThanArray = <String>[];    // List to store the guesses of numbers that are lesser than the correct number
  List<String> greaterThanArray = <String>[];    // List to store the guesses of numbers that are greater than the correct number
  List<String> recordArray = <String>[];    // List to store all the correct numbers

  final GuessingGameLogic ggl = GuessingGameLogic();    // Object of the class that manage the game logic

  @override
  Widget build(BuildContext context)
  {
  
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            
            Center(
              
              child: SizedBox(
                
                width: 200.0,
                
                child: TextField(
                  
                  style: const TextStyle(color: Colors.white),

                  onSubmitted: (String inputValue)
                  {
                    
                    if (ggl.checkGuess(inputValue))
                    {
                      setState(() {
                        // Update the attemp counter

                          attempsNumber = 5;

                          attempStrings = "Attemps: $attempsNumber";
                        });

                      recordArray.add(inputValue);
                      greaterThanArray = [];
                      lessThanArray = [];
                    }

                    else
                    {
                      if (ggl.isGreaterThanNumber(inputValue))
                      {
                        setState(() {
                          attempsNumber -= 1;
                        });

                        if (attempsNumber >= 1)
                        {
                          lessThanArray.add(inputValue);

                          attempStrings = "Attemps: $attempsNumber";
                        }
                      }

                      else
                      {
                        setState(() {
                          attempsNumber -= 1;

                        });

                        if (attempsNumber >= 1)
                        {
                          greaterThanArray.add(inputValue);

                          
                          attempStrings = "Attemps: $attempsNumber";
                        }

                        else
                        {
                          setState(() {
                            attempsNumber = 5;

                            attempStrings = "Attemps: $attempsNumber";
                          });

                          recordArray.add(ggl.getRandomNumber().toString());

                          greaterThanArray = [];
                          lessThanArray = [];
                        }
                        
                      }
                    }

                  } ,

                  decoration: const InputDecoration(
                    
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 25.0,
                      
                      horizontal: 10.0,
                    ),
                    
                    border: OutlineInputBorder(),

                    hintText: 'Numbers', hintStyle: TextStyle(
                      color: Color(0xFF9b9b9b),
                    )
                  ),
                ),
                
              ),
            ),

            Text(attempStrings, style: TextStyle(
              color: Colors.white,
            )),

          ], // Children
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextFieldForNumbers('Greater than', greaterThanArray),
            TextFieldForNumbers('Less than', lessThanArray),
            TextFieldForNumbers('Record', recordArray),
          ],
        ),

        Center(
          child: Text(
            difficultyText, 
    
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        

        Slider(
          min: 0,
          
          max: 3,
          
          divisions: 3,
          
          value: difficulty,

          onChanged: (value)
          {
            setState(() {
              difficulty = value;

              // Switch to manage the difficulty and the number of attemps, as well as creating the random number
              switch(difficulty)
              {
                case 0:
                  difficultyText = "Easy";

                  ggl.setDifficulty(value);

                  ggl.setRandomNumber();

                  attempsNumber = 5;

                  attempStrings = "Attemps: $attempsNumber";

                case 1:
                  difficultyText = "Normal";

                  ggl.setDifficulty(value);

                  ggl.setRandomNumber();

                  attempsNumber = 8;

                  attempStrings = "Attemps: $attempsNumber";

                case 2:
                  difficultyText = "Hard";

                  ggl.setDifficulty(value);

                  ggl.setRandomNumber();

                  attempsNumber = 15;

                  attempStrings = "Attemps: $attempsNumber";

                case 3:
                  difficultyText = "Extreme";

                  ggl.setDifficulty(value);

                  ggl.setRandomNumber();

                  attempsNumber = 25;

                  attempStrings = "Attemps: $attempsNumber";

                default:
                  difficultyText = "Easy";

                  ggl.setDifficulty(value);

                  ggl.setRandomNumber();

                  attempsNumber = 5;

                  attempStrings = "Attemps: $attempsNumber";
              }
              
            });
          }
        )
      ],
    );
    
  } // Build
}
  
// ignore: must_be_immutable
class TextFieldForNumbers extends StatelessWidget{
  /*
    Class used as template for the 3 text field 'Greater than', 'Less than' and 'Record'
  */ 

  String textFieldString;

  List<String> array = <String>[];
  
  TextFieldForNumbers(this.textFieldString, this.array, {super.key});

  @override

  Widget build(BuildContext context)
  {
    String arrayElements = "";

    for(int i = 0; i < array.length; i++)
    {
      arrayElements += "${array[i]} ";
    }
    
    return Center(
      child: SizedBox(

        width: 200.0,
        
        child: Column(
          children: [
            Text(
              textFieldString, style: TextStyle(
                  color: Colors.white,
            )),

            Text(
              
              arrayElements,
              style: TextStyle(
                color: Colors.white
                ),
            ),
          ],
        ), 
                
      ),
    );
  }
}

