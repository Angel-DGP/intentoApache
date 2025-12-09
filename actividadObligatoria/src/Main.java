import javax.swing.JOptionPane;
public class Main {
    public static void main(String[] args) {
        String cantidadPuntajeStr = "";
        int cantidadPuntajes = 0;
        do{
            cantidadPuntajeStr = JOptionPane.showInputDialog("Ingresa la cantidad de puntajes que vas a revisar: \n (El valor debe estar entre 5 - 15)");
            cantidadPuntajes = Integer.parseInt(cantidadPuntajeStr);
            System.out.println(cantidadPuntajes);
        } while(cantidadPuntajes<5 || cantidadPuntajes>15);
        int[]puntajes = new int[cantidadPuntajes];
        int puntajeTemporal = 0;
        String puntajeString = "";
        int puntajeMayor = 0;
        int puntajeMenor = 99999;
        int puntajesTotal = 0;
        int mayoresA89 = 0;
        String puntajesAprobadosMensaje = "";
        String puntajesReprobadosMensaje = "";
        for(int i=0; i<cantidadPuntajes; i++){
            do{
                puntajeString = JOptionPane.showInputDialog("Ingresa el puntaje Nº" + (i+1) +"\n (El rango debe estar entre 0 - 100)");
                puntajeTemporal = Integer.parseInt(puntajeString);
            }while(puntajeTemporal<0 || puntajeTemporal>100);
            puntajes[i] = puntajeTemporal;
            if(puntajeMayor<puntajes[i]){
                puntajeMayor = puntajes[i];
            }
            if(puntajeMenor>puntajes[i]){
                puntajeMenor = puntajes[i];
            }
            puntajesTotal += puntajes[i];
            if(puntajes[i]>89){
                mayoresA89++;
            }
            else if(puntajes[i]>=60){
                puntajesAprobadosMensaje+=("Puntaje Nº" + (i+1) + " aprobado con: " + puntajes[i] + "\n");
            }
            if(puntajes[i]<60){
                puntajesReprobadosMensaje+=("Puntaje Nº" + (i+1) + " reprobado con: " + puntajes[i] + "\n");
            }
        }
        String opcion = "";
        int opcionEntera = 0;
        double promedioGeneral = (double) puntajesTotal /cantidadPuntajes;
        do{
            opcion = JOptionPane.showInputDialog("1. Ver todos los puntajes\n" +
                    "2. Ver puntajes aprobados (>= 60)\n" +
                    "3. Ver puntajes reprobados (< 60)\n" +
                    "4. Salir");
            opcionEntera = Integer.parseInt(opcion);
            switch(opcionEntera){
                case 1:
                    JOptionPane.showMessageDialog(null, "El puntaje mas alto es: " + puntajeMayor + "\nEl puntaje mas bajo es: " + puntajeMenor + "\nPromedio General es: " + promedioGeneral + "\nHay " + mayoresA89 + " mayores o iguales a 90" );
                    break;
                case 2:
                    JOptionPane.showMessageDialog(null, puntajesAprobadosMensaje );
                    break;
                case 3:
                    JOptionPane.showMessageDialog(null, puntajesReprobadosMensaje );
                    break;
                case 4:
                    break;
            }
        }while(opcionEntera!=4);
    }
}