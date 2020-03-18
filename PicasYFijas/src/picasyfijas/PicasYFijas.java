/*

 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//ackage picasyfijas;

import java.io.*;
import java.util.*;

/**
 *
 * @author alexb
 */


public class PicasYFijas {
    /**
     * @param args the command line arguments
     */
    static BufferedReader entrada = new BufferedReader(new InputStreamReader(System.in));
    
    static AgentePicaFija agente = new AgentePicaFija();
    static int buscar =1;
    static int indiceMayor;
    static int auxPicas;
    static int auxFijas;
    static String [] input;
    static char [] numeroAux;
    static boolean init;
    static int n;
    static int r;
    static int j;
    static String [] basePicas = {"0123",
                               "1234",
                               "2345",
                               "3456",
                               "4567",
                               "5678",
                               "6789",
                               "7890",
                               "8901",
                               "9012"
                                };
    private static void percepcion(){
        indiceMayor=0;
        agente.setPicas(0);
        agente.setFijas(0);
        auxPicas=0;
        auxFijas=0;
        
        for (int i = 0; i < basePicas.length; i++) {
            System.out.println("Ingrese el numero de picas seguido del numero de fijas, separandolos por una ',' para el siguiente numero: "+basePicas[i]);            
            try{input = entrada.readLine().split(",");
            auxPicas=Integer.parseInt(input[0]);
            auxFijas=Integer.parseInt(input[1]);
            }catch (IOException ioe) {
                System.out.println("ERROR: " + ioe.getMessage());;}
            if (auxPicas >0 || auxFijas >0) {
                auxPicas = auxPicas + auxFijas;
                if (auxPicas > agente.getPicas()) {
                    indiceMayor = i;
                    agente.setFijas(auxFijas);
                    agente.setPicas(auxPicas-agente.getFijas());
                }
            }
        }
        
        agente.setNumero(basePicas[indiceMayor]);
        numeroAux = agente.getNumero().toCharArray();
        System.out.println("numero: "+agente.getNumero());
    }

    private static void accion(){
        n = 4;                  //Tipos para escoger
        r = numeroAux.length;   //Elementos elegidos
        try {Perm2(numeroAux, "", n, r);} catch (IOException ioe) {
                System.out.println("ERROR: " + ioe.getMessage());;}
     
        numeroAux = agente.getNumero().toCharArray();
        n = 0;
        j=0;
        do {
            if (n>9) {
                n=0;
                j++;
            }
            numeroAux[j]= Integer.toString(n).charAt(0);
            System.out.println("Ingrese el numero de picas seguido del numero de fijas, separandolos por una ',' para el siguiente numero: "+ String.valueOf(numeroAux));            
            
            try {
                input = entrada.readLine().split(",");
                auxPicas=Integer.parseInt(input[0]);
                auxFijas=Integer.parseInt(input[1]);

                if (auxPicas >0 || auxFijas >0) {
                    auxPicas = auxPicas + auxFijas;
                    if (auxFijas<4) {
                        if (auxPicas > (agente.getPicas()+agente.getFijas())) {
                        agente.setNumero(String.valueOf(numeroAux));
                        agente.setFijas(auxFijas);
                        agente.setPicas(auxPicas-auxFijas);
                        if(agente.getPicas()==agente.getFijas()){
                            n=10;
                        }else{
                            buscar = 1;
                            Perm2(numeroAux, "", 4, 4);
                        }
                        
                    }
                    if (auxPicas < (agente.getPicas()+agente.getFijas())) {
                        n=10;
                        numeroAux = agente.getNumero().toCharArray();
                    }
                    }else{
                        agente.setNumero(String.valueOf(numeroAux));
                        agente.setFijas(auxFijas);
                        agente.setPicas(auxPicas-auxFijas);
                        System.out.println("su numero es  "+ agente.getNumero());
                        System.out.println("Ingrese alguna palabra, seguida de enter para volver a empezar");
                        Scanner sc = new Scanner(System.in);
                        sc.next();
                        System.out.print("\033[H\033[2J");
                        System.out.flush();
                        break;
                    }
                    
                    
                    
                    
                }
            } catch (IOException ioe) {
                System.out.println("ERROR: " + ioe.getMessage());;
            } catch (NumberFormatException nfe) {
                System.out.println("ERROR: " + nfe.getMessage() + ". No es numérico.");;
            }
            n++;
        } while (true);
    }

    public static String Perm2(char[] elem, String act, int n, int r) throws IOException {
        if (n == 0 && buscar>0) {
            String numAux = act.replaceAll(", ", "");
            System.out.println("Ingrese el numero de picas seguido del numero de fijas, separandolos por una ',' para el siguiente numero: "+numAux);            
            String [] input = entrada.readLine().split(",");
            int auxPicas=Integer.parseInt(input[0]);
            int auxFijas=Integer.parseInt(input[1]);
            
            if (auxPicas >0 || auxFijas >0) {
                auxPicas = auxPicas + auxFijas;
                if (auxPicas > agente.getPicas()) {
                    agente.setNumero(numAux);
                    agente.setFijas(auxFijas);
                    agente.setPicas(auxPicas-agente.getFijas());
                    if (agente.getFijas() == agente.getPicas()) {
                        buscar = -1;
                    }
                }
            }
        } else {
            for (int i = 0; i < r; i++) {
                if (!act.contains(Character.toString(elem[i]))) { // Controla que no haya repeticiones
                    Perm2(elem, act + elem[i] + ", ", n - 1, r);
                }
            }
        }
        return null;
    }

    public static void main(String[] args) throws IOException {
        while(true){
            percepcion();
            accion();
        }
    }
    
}
