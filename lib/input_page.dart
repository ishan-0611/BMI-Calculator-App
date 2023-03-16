import 'package:bmi_calculator/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'result_page.dart';
import 'bottom_button.dart';
import 'round_icon.dart';
import 'calculator_brain.dart';

enum Gender
{
   none,
   male,
   female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Gender selectedGender=Gender.none;
  int height=180;
  int weight=60;
  int age=25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF0A0E21),
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: [
          Expanded(child: Row(
            children: [
              Expanded(child: ReusableCard(
                onPress: (){
                  setState(() {
                    selectedGender=Gender.male;
                  });
                },
                  colour: selectedGender == Gender.male ? kActiveCardColour : kInactiveCardColour,
                  cardChild: IconContent(icon: FontAwesomeIcons.mars,label: 'MALE',),
              ),),
              Expanded(child: ReusableCard(
                onPress: (){
                  setState(() {
                    selectedGender=Gender.female;
                  });
                },
                  colour: selectedGender == Gender.female ? kActiveCardColour : kInactiveCardColour,
                  cardChild: IconContent(icon: FontAwesomeIcons.venus,label: 'FEMALE',),
              ),),
            ],
          ),),
          Expanded(child: ReusableCard(
            onPress: (){},
            colour: kActiveCardColour,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('HEIGHT',style: kLabelTextStyle,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                Text(
                  height.toString(),
                  style: kSliderStyle,
                ),
                Text(
                  'cm',
                  style: kLabelTextStyle,
                ),
              ],),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Color(0xFF8D8E98),
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  ),
                  child: Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    //activeColor: Color(0xFFEB1555),
                    //inactiveColor: Color(0xFF8D8E98),
                    onChanged: (double newValue){
                      setState(() {
                        height=newValue.round();
                      });
                    },
                  ),
                ),
              ],
            ),
            ),
          ),
          Expanded(child: Row(
            children: [
              Expanded(child: ReusableCard(
                onPress: (){},
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('WEIGHT',style: kLabelTextStyle,),
                    Text(weight.toString(),style: kSliderStyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIconButton(icon: FontAwesomeIcons.minus,
                          onPressed: (){
                          setState(() {
                            weight--;
                          });
                          },
                        ),
                        SizedBox(width: 10.0,),
                        RoundIconButton(icon: FontAwesomeIcons.plus,
                          onPressed: (){
                          setState(() {
                            weight++;
                          });
                          },
                        ),
                      ],
                    ),
                  ],
                ),),),
              Expanded(child: ReusableCard(
                onPress: (){},
                colour: kActiveCardColour,
                cardChild:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('AGE',style: kLabelTextStyle,),
                      Text(age.toString(),style: kSliderStyle,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundIconButton(icon: FontAwesomeIcons.minus,
                              onPressed: (){
                            setState(() {
                              age--;
                            });
                              },
                          ),
                          SizedBox(width: 10.0,),
                          RoundIconButton(icon: FontAwesomeIcons.plus,
                              onPressed: (){
                            setState(() {
                              age++;
                            });
                              },
                          ),
                        ],
                      ),
                    ],
                  ),
              ),),
            ],
          ),),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: (){

              CalculatorBrain calc=CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>ResultsPage(
                  bmiResult: calc.CalculateBMI(),
                  resultText: calc.getResult(),
                  interpretation: calc.getInterpretation(),
                ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


