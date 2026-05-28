package Aula_7;

import java.util.ArrayList;

public class Funcionario {
    private String nome;
    private ArrayList<Funcionario> lstFuncionarios;
    
    public Funcionario(String nome) {
        this.nome = nome;
        lstFuncionarios = new ArrayList<>();
    }

    public String getNome() {
        return nome;
    }
    
    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public void addFuncionario(Funcionario func) {
        lstFuncionarios.add(func);
    }
    
    public void imprimirFuncionarios() {
        for (Funcionario f : lstFuncionarios) {
            System.out.println(f.getNome());;
        }
    }
    
    public void imprimir() {
        System.out.println("Nome: "+nome);
    }
}
