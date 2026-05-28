package Aula_7;

import java.util.ArrayList;
import java.util.Scanner;

public class Main_ArrayList {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        ArrayList<Pessoa> lstPessoas = new ArrayList<>();
        Pessoa p = null;
        int opt = 0;
        
        do {
            System.out.println("Nome: ");
            String nome = scan.next();
            System.out.println("Idade: ");
            int idade = scan.nextInt();
            
            p = new Pessoa(nome, idade);
            lstPessoas.add(p);
            opt++;
        } while (opt < 3);
        
        for (Pessoa pe : lstPessoas) {
            pe.imprimir();
        }
    }
}
