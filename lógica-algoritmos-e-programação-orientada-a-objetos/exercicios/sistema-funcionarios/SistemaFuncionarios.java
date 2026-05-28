package exercicios;

import java.util.ArrayList;
import java.util.List;

/**
 * Sistema de Gerenciamento de Funcionários e Folha de Pagamento
 * Demonstra Herança, Sobrescrita de Métodos e Polimorfismo.
 */
abstract class Funcionario {
    protected String nome;
    protected String matricula;
    protected double salarioBase;

    public Funcionario(String nome, String matricula, double salarioBase) {
        if (salarioBase < 0) {
            throw new IllegalArgumentException("O salário base não pode ser negativo.");
        }
        this.nome = nome;
        this.matricula = matricula;
        this.salarioBase = salarioBase;
    }

    public String getNome() { return nome; }
    public String getMatricula() { return matricula; }
    public double getSalarioBase() { return salarioBase; }

    // Método polimórfico para calcular salário líquido
    public abstract double calcularSalario();

    public abstract String getCargo();

    @Override
    public String toString() {
        return String.format("Matrícula: %-6s | Cargo: %-13s | Nome: %-15s | Salário Final: R$ %8.2f", 
                matricula, getCargo(), nome, calcularSalario());
    }
}

class Gerente extends Funcionario {
    private double bonusGerencial;

    public Gerente(String nome, String matricula, double salarioBase, double bonusGerencial) {
        super(nome, matricula, salarioBase);
        this.bonusGerencial = bonusGerencial;
    }

    @Override
    public double calcularSalario() {
        return salarioBase + bonusGerencial;
    }

    @Override
    public String getCargo() {
        return "Gerente";
    }
}

class Desenvolvedor extends Funcionario {
    private String nivel; // Junior, Pleno, Senior

    public Desenvolvedor(String nome, String matricula, double salarioBase, String nivel) {
        super(nome, matricula, salarioBase);
        this.nivel = nivel;
    }

    @Override
    public double calcularSalario() {
        // Bônus adicional baseado no nível
        if (nivel.equalsIgnoreCase("Senior")) {
            return salarioBase + 2000.00;
        } else if (nivel.equalsIgnoreCase("Pleno")) {
            return salarioBase + 1000.00;
        }
        return salarioBase; // Junior recebe o salário base
    }

    @Override
    public String getCargo() {
        return "Dev " + nivel;
    }
}

class Estagiario extends Funcionario {
    private int horasSemanais;

    public Estagiario(String nome, String matricula, double bolsaAuxilio, int horasSemanais) {
        super(nome, matricula, bolsaAuxilio);
        this.horasSemanais = horasSemanais;
    }

    @Override
    public double calcularSalario() {
        // Estagiário recebe proporcional às horas trabalhadas (referência de 30 horas semanais completas)
        return salarioBase * (horasSemanais / 30.0);
    }

    @Override
    public String getCargo() {
        return "Estagiário";
    }
}

public class SistemaFuncionarios {
    public static void main(String[] args) {
        System.out.println("💼 SISTEMA DE RH E FOLHA DE PAGAMENTO 💼\n");

        List<Funcionario> funcionarios = new ArrayList<>();
        funcionarios.add(new Gerente("Clara Mendes", "G001", 8500.00, 2500.00));
        funcionarios.add(new Desenvolvedor("Marcos Silva", "D001", 6000.00, "Senior"));
        funcionarios.add(new Desenvolvedor("Juliana Costa", "D002", 4000.00, "Pleno"));
        funcionarios.add(new Desenvolvedor("Thiago Rocha", "D003", 2500.00, "Junior"));
        funcionarios.add(new Estagiario("Lucas Dias", "E001", 1200.00, 20)); // Trabalha 20h em vez de 30h

        double folhaTotal = 0;
        System.out.println("=========================================================================");
        System.out.println("📋 LISTAGEM DE COLABORADORES:");
        System.out.println("=========================================================================");
        for (Funcionario f : funcionarios) {
            System.out.println(f);
            folhaTotal += f.calcularSalario();
        }
        System.out.println("-------------------------------------------------------------------------");
        System.out.printf("CUSTO TOTAL DA FOLHA DE PAGAMENTO MENSAL: R$ %.2f\n", folhaTotal);
        System.out.println("=========================================================================");
    }
}
