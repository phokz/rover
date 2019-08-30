/*
 * simple rover contoll
 * 1x servo, S0..S180\r, on pin 9
 * 1x digital swith - drill on pin 2, switch on by A switch off by D
 * 2x pwm driven dc brush motor with drv8835 driver L-400..L0..L400\r
 * or R-400..R0..L400\r
 */
#define drill_pin 2
#define servo_pin 6
#define direction_pin_l 7
#define direction_pin_r 8
#define pwm_pin_l 9
#define pwm_pin_r 10
#define led_pin 13

#include <DRV8835MotorShield.h>
#include <Servo.h>

DRV8835MotorShield motors;
Servo myservo;

int pos;
int incomingByte;
boolean minus;
boolean servo;
boolean mot_l;
boolean mot_r;

void setup() {
  Serial.begin(115200);
  myservo.attach(servo_pin);  // attaches the servo on pin 9 to the servo object
  pinMode(drill_pin, OUTPUT);
  pinMode(led_pin, OUTPUT);
}


void loop() {
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    if (incomingByte == 65 /* capital A */) {
      digitalWrite(drill_pin, HIGH);
    } else if (incomingByte == 68 /* capital D */) {
      digitalWrite(drill_pin, LOW);
    } else if (incomingByte == 89 /* capital Y */) {
      digitalWrite(led_pin, HIGH);
    } else if (incomingByte == 78 /* capital N */) {
      digitalWrite(led_pin, LOW);
    } else if (incomingByte == 83 /* capital S */) {
      servo = true; pos = 0; minus = false;
    } else if (incomingByte == 76 /* capital L */) {
      mot_l = true; pos = 0; minus = false;
    } else if (incomingByte == 82 /* capital R */) {
      mot_r = true; pos = 0; minus = false;
    } else if (incomingByte == 45 /* minus sign (-) */) {
      minus = true;
    } else if (incomingByte == 13 /* CR */) {
      if (minus) { minus = false; pos = -pos; }
      if (servo) { servo = false; myservo.write(pos); }
      if (mot_l) { mot_l = false; motors.setM1Speed(pos); }
      if (mot_r) { mot_r = false; motors.setM2Speed(pos); }
    } else if (incomingByte >= 48 && incomingByte <= 57) {
      pos *= 10;
      pos += incomingByte - 48;
    }
    Serial.println(pos);
  }
}
