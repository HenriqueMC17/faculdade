package exercicios;

import java.util.ArrayList;
import java.util.List;

/**
 * Demonstração de Herança e Polimorfismo em Java.
 */
class Animal {
    protected String nome;
    protected int idade;

    public Animal(String nome, int idade) {
        this.nome = nome;
        this.idade = idade;
    }

    public String getNome() {
        return nome;
    }

    public int getIdade() {
        return idade;
    }

    public void emitirSom() {
        System.out.println(nome + " emite um som genérico.");
    }

    @Override
    public String toString() {
        return "Animal { Nome: '" + nome + "', Idade: " + idade + " anos }";
    }
}

class Cachorro extends Animal {
    private String raca;

    public Cachorro(String nome, int idade, String raca) {
        super(nome, idade);
        this.raca = raca;
    }

    public String getRaca() {
        return raca;
    }

    @Override
    public void emitirSom() {
        System.out.println("🐶 " + nome + " (Cachorro) diz: Au Au!");
    }

    public void enterrarOsso() {
        System.out.println("🦴 " + nome + " está enterrando um osso no quintal.");
    }

    @Override
    public String toString() {
        return "Cachorro { Nome: '" + nome + "', Idade: " + idade + " anos, Raça: '" + raca + "' }";
    }
}

class Gato extends Animal {
    private String corPelo;

    public Gato(String nome, int idade, String corPelo) {
        super(nome, idade);
        this.corPelo = corPelo;
    }

    public String getCorPelo() {
        return corPelo;
    }

    @Override
    public void emitirSom() {
        System.out.println("🐱 " + nome + " (Gato) diz: Miau!");
    }

    public void afiarUnhas() {
        System.out.println("🐱 " + nome + " está afiando as unhas no sofá.");
    }

    @Override
    public String toString() {
        return "Gato { Nome: '" + nome + "', Idade: " + idade + " anos, Cor do Pelo: '" + corPelo + "' }";
    }
}

public class Main {
    public static void main(String[] args) {
        System.out.println("=== 🐾 DEMONSTRAÇÃO DE HERANÇA E POLIMORFISMO 🐾 ===\n");

        // Criação de instâncias utilizando polimorfismo
        List<Animal> animais = new ArrayList<>();
        animais.add(new Cachorro("Rex", 5, "Pastor Alemão"));
        animais.add(new Gato("Mingau", 3, "Branco"));
        animais.add(new Animal("Criatura Misteriosa", 100));

        System.out.println("--- 🔎 Listando todos os animais cadastrados (toString) ---");
        for (Animal animal : animais) {
            System.out.println(animal);
        }

        System.out.println("\n--- 🔊 Demonstração de Polimorfismo (emitirSom) ---");
        for (Animal animal : animais) {
            animal.emitirSom();
        }

        System.out.println("\n--- 🎯 Ações específicas (com casting seguro) ---");
        for (Animal animal : animais) {
            if (animal instanceof Cachorro) {
                Cachorro dog = (Cachorro) animal;
                dog.enterrarOsso();
            } else if (animal instanceof Gato) {
                Gato cat = (Gato) animal;
                cat.afiarUnhas();
            } else {
                System.out.println("❓ " + animal.getNome() + " não possui ações específicas implementadas.");
            }
        }
    }
}
