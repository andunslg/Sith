#include <U8glib.h>

//initializing the LCD Display
U8GLIB_ST7920_128X64_1X u8g(13, 11, 10);

//Define input PIN numbers
const int buttonPin1 = 52;     
const int buttonPin2 = 50;     
const int buttonPin3 = 48;     
const int buttonPin4 = 46;     
const int buttonPin5 = 44;     
const int buttonPin6 = 42;  
const int buttonPin7 = 40; 
const int buttonPin8 = 38;  

//Define input states
boolean buttonState1 = 0;    
boolean buttonState2 = 0;   
boolean buttonState3 = 0;   
boolean buttonState4 = 0;   
boolean buttonState5 = 0;   
boolean buttonState6 = 0;   
boolean buttonState7 = 0; 
boolean buttonState8 = 0; 

boolean firstTime=true;

char *context;
char *avgPerception;
char *perception1;
char *perception2;
char *perception3;
char *perception4;
char *perception5;

void setup() {
  //Setting up the Device
  pinMode(buttonPin1, INPUT_PULLUP);    
  pinMode(buttonPin2, INPUT_PULLUP);  
  pinMode(buttonPin3, INPUT_PULLUP);    
  pinMode(buttonPin4, INPUT_PULLUP);    
  pinMode(buttonPin5, INPUT_PULLUP);    
  pinMode(buttonPin6, INPUT_PULLUP);  
  pinMode(buttonPin7, INPUT_PULLUP); 
  pinMode(buttonPin8, INPUT_PULLUP); 

  // assign default color value
  if ( u8g.getMode() == U8G_MODE_R3G3B2 ) {
    u8g.setColorIndex(255);     // white
  }
  else if ( u8g.getMode() == U8G_MODE_GRAY2BIT ) {
    u8g.setColorIndex(3);         // max intensity
  }
  else if ( u8g.getMode() == U8G_MODE_BW ) {
    u8g.setColorIndex(1);         // pixel on
  }
  else if ( u8g.getMode() == U8G_MODE_HICOLOR ) {
    u8g.setHiColorByRGB(255,255,255);
  }
  u8g.setFont(u8g_font_unifont);

  //Intilize serial communication
  Serial.begin(9600);
}

void loop(){

  if(firstTime){
    showStartupScreen();
    
    //Requesting intializing values form coordinator
    writeSerial("Expecting Initial String");

    //Receving Initializing data
    context=readFromSerial();
    avgPerception=readFromSerial();
    perception1=readFromSerial();
    perception2=readFromSerial();
    perception3=readFromSerial();
    perception4=readFromSerial();
    perception5=readFromSerial();

    //Completing Initializing
    writeSerial("Initializing Completed");
    firstTime=false;
  }

  //Read average perception from serial, if availble
  if(Serial.available() > 0){
    avgPerception=readFromSerial();
  }

  //Show average perception on LCD
  showCurrentPerception(context,avgPerception);
  
  //Checking for button press events
  checkInputs();

  //Handling percetion recive
  if (buttonState1) {
    showPerceptionQuery("");   
    char *selectedPerception; 
    while(true){  

      checkInputs();   
      if(buttonState2){
        showPerceptionQuery(perception1);   
        selectedPerception=perception1;
      } 
      else if(buttonState6){
        showPerceptionQuery(perception2);
        selectedPerception=perception2;   
      } 
      else if(buttonState5){
        showPerceptionQuery(perception3); 
        selectedPerception=perception3;  
      } 
      else if(buttonState4){
        showPerceptionQuery(perception4);   
        selectedPerception=perception4;
      } 
      else if(buttonState3){
        showPerceptionQuery(perception5);
        selectedPerception=perception5;   
      } 
      else if(buttonState8){
        String check=selectedPerception;
        if(check.equals("")){
          showEmptyOKPressMsg();
          delay(800);
          showPerceptionQuery("");   
        }
        else{
          //Send selected perception to coordinator
          writeSerial(selectedPerception);
          break;
        }
      } 
      else if(buttonState7){
        break;
      } 
    }
  }
}

char* readFromSerial(){
  String text="";
  while (true){    
    if(Serial.available() > 0)
    {
      char recieved = Serial.read();
      if(recieved==';'){
        break;
      }
      else{
        text += recieved; 
      }
    }
  }
  
  char *a=new char[text.length()+1];
  a[text.length()]=0;
  memcpy(a,text.c_str(),text.length());

  return a;
}

void writeSerial(String text){
  Serial.println(text+";");
  Serial.flush();
}

void checkInputs(){
  int button1 = digitalRead(buttonPin1);
  int button2 = digitalRead(buttonPin2);
  int button3 = digitalRead(buttonPin3);
  int button4 = digitalRead(buttonPin4);
  int button5 = digitalRead(buttonPin5);
  int button6 = digitalRead(buttonPin6);
  int button7 = digitalRead(buttonPin7);
  int button8 = digitalRead(buttonPin8);

  delay(100);

  if(button1==LOW and digitalRead(buttonPin1) == LOW){
    buttonState1=true;
  }
  else{
    buttonState1=false;
  }

  if(button2==LOW and digitalRead(buttonPin2) == LOW){
    buttonState2=true;
  }
  else{
    buttonState2=false;
  }

  if(button3==LOW and digitalRead(buttonPin3) == LOW){
    buttonState3=true;
  }
  else{
    buttonState3=false;
  }

  if(button4==LOW and digitalRead(buttonPin4) == LOW){
    buttonState4=true;
  }
  else{
    buttonState4=false;
  }

  if(button5==LOW and digitalRead(buttonPin5) == LOW){
    buttonState5=true;
  }
  else{
    buttonState5=false;
  }

  if(button6==LOW and digitalRead(buttonPin6) == LOW){
    buttonState6=true;
  }
  else{
    buttonState6=false;
  }

  if(button7==LOW and digitalRead(buttonPin7) == LOW){
    buttonState7=true;
  }
  else{
    buttonState7=false;
  }

  if(button8==LOW and digitalRead(buttonPin8) == LOW){
    buttonState8=true;
  }
  else{
    buttonState8=false;
  }
}

void writeBluetooth(String text){
  if( Serial.available() )       // if data is available to read
  {
    Serial.println(text);         // read it and store it in 'val'
  }  
  delay(50);
}

void drawOnLCD(char *text, int x, int y){
  u8g.firstPage();  
  do {
    u8g.drawStr( x, y, text);
  } 
  while( u8g.nextPage() );  
}

void showPerceptionQuery(char *perception){
  u8g.firstPage();  
  do {
    u8g.setFont(u8g_font_6x12);
    int width=u8g.getStrWidth("-Select Perception-");
    int x=(128-width)/2;
    u8g.drawStr(x, 15, "-Select Perception-");
    u8g.setFont(u8g_font_7x14);
    width=u8g.getStrWidth(perception);
    x=(128-width)/2;
    u8g.drawStr(x, 30, perception);
    u8g.setFont(u8g_font_4x6);
    width=u8g.getStrWidth("Press OK to Confirm");
    x=(128-width)/2;
    u8g.drawStr(x, 45, "Press OK to Confirm");
  } 
  while( u8g.nextPage() );  
}

void showEmptyOKPressMsg(){
  u8g.firstPage();  
  do {
    u8g.setFont(u8g_font_5x8);
    int width=u8g.getStrWidth("Press OK After");
    int x=(128-width)/2;
    u8g.drawStr(x, 25, "Press OK After");
    width=u8g.getStrWidth("Selecting a Perception");
    x=(128-width)/2;
    u8g.drawStr(x, 40, "Selecting a Perception");
  } 
  while( u8g.nextPage() );  
}

void showCurrentPerception(char *context,char *perception){
  u8g.firstPage();  
  do {
    u8g.setFont(u8g_font_6x12);
    u8g.drawStr(35, 15, "-Context-");
    u8g.setFont(u8g_font_6x13);
    int width=u8g.getStrWidth(context);
    int x=(128-width)/2;
    u8g.drawStr(x, 30, context);
    u8g.setFont(u8g_font_6x12);
    u8g.drawStr(5, 45, "-Average Perception-");
    u8g.setFont(u8g_font_6x13);
    width=u8g.getStrWidth(perception);
    x=(128-width)/2;
    u8g.drawStr(x, 60, perception);
  } 
  while( u8g.nextPage() );  
}

void showStartupScreen(){
  u8g.firstPage();  
  do {
    u8g.setFont(u8g_font_7x14);
    u8g.drawStr(0,9,"-------------------");
    u8g.drawStr(18,36,"Sith Platform");
    u8g.setFont(u8g_font_4x6);
    u8g.drawStr(4,44,"www.sithplatform.cse.mrt.ac.lk");
    u8g.setFont(u8g_font_7x14);
    u8g.drawStr(0,64,"-------------------");
  } 
  while( u8g.nextPage() );  

  delay(2000);
  u8g.firstPage();  
  do { 
    u8g.setDefaultForegroundColor();
    u8g.drawBox( 0, 0, 128, 64);     // draw cursor bar
    u8g.setDefaultBackgroundColor();
    u8g.setFont(u8g_font_7x14);

    u8g.drawStr(0,9,"-------------------");
    u8g.drawStr(18,36,"Sith Platform");
    u8g.setFont(u8g_font_4x6);
    u8g.drawStr(4,44,"www.sithplatform.cse.mrt.ac.lk");
    u8g.setFont(u8g_font_7x14);
    u8g.drawStr(0,64,"-------------------");    
    u8g.setDefaultForegroundColor();
  }
  while( u8g.nextPage() );  
  delay(2000);
}





























