#include <FREE_RTOS.h>
#include <semphr.h>
#include <task.h>

SemaphoreHandle_t mtx;
uint16_t global = 0;

void vTarea1 (void* pv){
  while(1){
    vTaskDelay(pdMS_TO_TICKS(100));
    xSemaphoreTake(mtx,portMAX_delay);
    global++;
    xSemaphoreGive(mtx);
  }
}

void vTarea2_3 (void* pv){
  char* id = (char*) pv;
  while(1){
    vTaskDelay(pdMS_TO_TICKS(50));
    xSemaphoreTake(mtx,portMAX_delay);
    uart_send_string(pv);
    uart_send(global);
    global += 2;
    xSemaphoreGive(mtx);
  }
}

int main (void){
uart_init(); //generico
mtx = SemaphoreCreateMutex();

xTaskCreate(vTarea1,"tarea1",1000,null,2,null);
xTaskCreate(vTarea2_3,"tarea2",1000,"t2",1,null);
xTaskCreate(vTarea2_3,"tarea3",1000,"t3",1,null);

vTaskStartScheduler();

while(1){};
return 0;
}
