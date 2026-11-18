#include <FREERTOS.h>
#include <semphr.h>
#include <task.h>

SemaphoreHandle_t s1, s2, s3;

//Tarea3
void vTarea3 (void* pv){
  int i;
  while (1){
    xSemaphoreTake(s3,portMAX_DELAY);
    for (i=0;i<2;i++) uart_send_string("tarea3");
    xSemaphoreGive(s2);             
  }
}

//Tarea2
void vTarea2 (void* pv){
  while (1){
    xSemaphoreTake(s2,portMAX_DELAY);
    uart_send_string("tarea2");
    xSemaphoreGive(s3); 
    xSemaphoreTake(s2,portMAX_DELAY);
    uart_send_string("tarea2");
    xSemaphoreGive(s1);
  }
}

//Tarea1
void vTarea1 (void* pv){
  while (1){
    xSemaphoreTake(s1,portMAX_DELAY);
    uart_send_string("tarea1");
    xSemaphoreGive(s2); 
    xSemaphoreTake(s1,portMAX_DELAY);
    uart_send_string("tarea1");
    xSemaphoreGive(s1);
  }
}

int main (void){
uart_init(); //no me van a pedir inicializar todo

s1 = xSemaphoreCreateBinary();
s2 = xSemaphoreCreateBinary();
s3 = xSemaphoreCreateBinary();

xTaskCreate(vTarea1,"Tarea1",1000,null,1,null);
xTaskCreate(vTarea2,"Tarea2",1000,null,1,null);
xTaskCreate(vTarea3,"Tarea3",1000,null,1,null);

xSemaphoreGive(s1);
vTaskStartScheduler();

while (1){};
return 0;
}
