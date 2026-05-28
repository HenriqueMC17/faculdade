package exercicios;

import java.util.ArrayList;
import java.util.List;

/**
 * Demonstração de Polimorfismo com Veículos
 * Classe Abstrata com métodos abstratos implementados de formas distintas por Carros e Motos.
 */
abstract class Veiculo {
    protected String marca;
    protected String modelo;
    protected int ano;

    public Veiculo(String marca, String modelo, int ano) {
        this.marca = marca;
        this.modelo = modelo;
        this.ano = ano;
    }

    public String getInfoGeral() {
        return marca + " " + modelo + " (" + ano + ")";
    }

    // Método abstrato que força a implementação polimórfica
    public abstract void mover();
}

class Carro extends Veiculo {
    private int quantidadePortas;

    public Carro(String marca, String modelo, int ano, int quantidadePortas) {
        super(marca, modelo, ano);
        this.quantidadePortas = quantidadePortas;
    }

    @Override
    public void mover() {
        System.out.println("🚗 O Carro " + getInfoGeral() + " está rodando na rodovia. Rodas girando de forma suave!");
    }

    public void abrirPortaMalas() {
        System.out.println("📦 Porta-malas do carro " + modelo + " aberto.");
    }
}

class Moto extends Veiculo {
    private int cilindradas;

    public Moto(String marca, String modelo, int ano, int cilindradas) {
        super(marca, modelo, ano);
        this.cilindradas = cilindradas;
    }

    @Override
    public void mover() {
        System.out.println("🏍️ A Moto " + getInfoGeral() + " de " + cilindradas + "cc está acelerando rapidamente e cortando o trânsito!");
    }

    public void empinar() {
        System.out.println("🔥 A moto " + modelo + " está empinando de forma radical!");
    }
}

class Caminhao extends Veiculo {
    private double capacidadeCargaToneladas;

    public Caminhao(String marca, String modelo, int ano, double capacidadeCargaToneladas) {
        super(marca, modelo, ano);
        this.capacidadeCargaToneladas = capacidadeCargaToneladas;
    }

    @Override
    public void mover() {
        System.out.println("🚛 O Caminhão " + getInfoGeral() + " está transportando " + capacidadeCargaToneladas + "t de carga na pista da direita.");
    }
}

public class PolimorfismoVeiculos {
    public static void main(String[] args) {
        System.out.println("🚦 SIMULAÇÃO DE FROTA DE VEÍCULOS (POLIMORFISMO) 🚦\n");

        List<Veiculo> frota = new ArrayList<>();
        frota.add(new Carro("Toyota", "Corolla", 2022, 4));
        frota.add(new Moto("Honda", "CB 500F", 2021, 500));
        frota.add(new Caminhao("Volvo", "FH 540", 2020, 25.5));
        frota.add(new Carro("Fiat", "Uno Escada", 2010, 2));

        System.out.println("--- 🛣️ Colocando a Frota em Movimento ---");
        for (Veiculo v : frota) {
            v.mover(); // Chamada polimórfica
        }

        System.out.println("\n--- 🔧 Ações Mecânicas Específicas (Segurança de Tipos) ---");
        for (Veiculo v : frota) {
            if (v instanceof Carro) {
                Carro c = (Carro) v;
                c.abrirPortaMalas();
            } else if (v instanceof Moto) {
                Moto m = (Moto) v;
                m.empinar();
            } else {
                System.out.println("🚛 O caminhão " + v.modelo + " não tem ações rápidas extras.");
            }
        }
    }
}
