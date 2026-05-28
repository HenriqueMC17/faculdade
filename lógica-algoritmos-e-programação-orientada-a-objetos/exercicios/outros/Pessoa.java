package Aula_7;

import java.util.ArrayList;

public class Pessoa {
    private String nome;
    private ArrayList<ContaComum> lstContas;

    public Pessoa(String nome) {
        this.nome = nome;
        lstContas = new ArrayList<>();
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public void addConta(ContaComum conta) {
        lstContas.add(conta);
    }
}
