
#include <DHT22.h>     


DHT22 myDHT22(DIGITAL4);

// Signal pin on DIGITAL4, power pin on DIGITAL3

void setup() {
    // put your setup code here, to run once:
    pinMode(DIGITAL3, OUTPUT);
    digitalWrite(DIGITAL3, HIGH);
    
      USB.ON();
      delay(100);
      
      USB.println("Booting");
}


void loop() {
   DHT22_ERROR_t errorCode;
  
  // The sensor can only be read from every 1-2s, and requires a minimum
  // 2s warm-up after power-on.
  delay(2000);
  
    USB.println("Requesting data...");
  errorCode = myDHT22.readData();
  switch(errorCode)
  {
    case DHT_ERROR_NONE:
      USB.print("Got Data ");
      USB.print(myDHT22.getTemperatureC());
      USB.print("C ");
      USB.print(myDHT22.getHumidity());
      USB.println("%");
      // Alternately, with integer formatting which is clumsier but more compact to store and
	  // can be compared reliably for equality:
	  //	  
      char buf[128];
      sprintf(buf, "Integer-only reading: Temperature %hi.%01hi C, Humidity %i.%01i %% RH",
                   myDHT22.getTemperatureCInt()/10, abs(myDHT22.getTemperatureCInt()%10),
                   myDHT22.getHumidityInt()/10, myDHT22.getHumidityInt()%10);
      USB.println(buf);
      break;
    case DHT_ERROR_CHECKSUM:
      USB.print("check sum error ");
      USB.print(myDHT22.getTemperatureC());
      USB.print("C ");
      USB.print(myDHT22.getHumidity());
      USB.println("%");
      break;
    case DHT_BUS_HUNG:
      USB.println("BUS Hung ");
      break;
    case DHT_ERROR_NOT_PRESENT:
      USB.println("Not Present ");
      break;
    case DHT_ERROR_ACK_TOO_LONG:
      USB.println("ACK time out ");
      break;
    case DHT_ERROR_SYNC_TIMEOUT:
      USB.println("Sync Timeout ");
      break;
    case DHT_ERROR_DATA_TIMEOUT:
      USB.println("Data Timeout ");
      break;
    case DHT_ERROR_TOOQUICK:
      USB.println("Polled to quick ");
      break;
  }
  
}

