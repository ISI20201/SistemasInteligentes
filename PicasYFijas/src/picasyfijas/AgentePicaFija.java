/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//package picasyfijas;

/**
 *
 * @author alexb
 */
public class AgentePicaFija {
    private int picas;
    private int fijas;
    private String numero;

    public AgentePicaFija() {
    }
    
    public AgentePicaFija(int picas, int fijas, String numero) {
        this.picas = picas;
        this.fijas = fijas;
        this.numero = numero;
    }
    

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public int getPicas() {
        return picas;
    }

    public void setPicas(int picas) {
        this.picas = picas;
    }

    public int getFijas() {
        return fijas;
    }

    public void setFijas(int fijas) {
        this.fijas = fijas;
    }
    
}
