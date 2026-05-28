package exercicios;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class Pessoa {
    private String nome;
    private String cpf;
    private int idade;
    private double peso;
    private double altura;

    public Pessoa(String nome, String cpf, int idade, double peso, double altura) {
        if (nome == null || nome.trim().isEmpty()) {
            throw new IllegalArgumentException("Nome não pode ser vazio.");
        }
        if (cpf == null || cpf.replaceAll("\\D", "").length() != 11) {
            throw new IllegalArgumentException("CPF inválido! Deve conter 11 dígitos.");
        }
        if (idade < 0 || idade > 150) {
            throw new IllegalArgumentException("Idade inválida!");
        }
        if (peso <= 0 || altura <= 0) {
            throw new IllegalArgumentException("Peso e altura devem ser maiores que zero.");
        }
        this.nome = nome;
        this.cpf = cpf.replaceAll("\\D", ""); // Limpa caracteres não numéricos
        this.idade = idade;
        this.peso = peso;
        this.altura = altura;
    }

    public String getNome() { return nome; }
    public String getCpf() { 
        // Formata CPF para exibição: XXX.XXX.XXX-XX
        return cpf.substring(0, 3) + "." + cpf.substring(3, 6) + "." + cpf.substring(6, 9) + "-" + cpf.substring(9, 11);
    }
    public int getIdade() { return idade; }
    public double getPeso() { return peso; }
    public double getAltura() { return altura; }

    public double calcularImc() {
        return peso / (altura * altura);
    }

    public String classificarImc() {
        double imc = calcularImc();
        if (imc < 18.5) return "Abaixo do peso";
        if (imc < 25.0) return "Peso normal";
        if (imc < 30.0) return "Sobrepeso";
        return "Obesidade";
    }

    @Override
    public String toString() {
        return String.format("Nome: %-15s | CPF: %s | Idade: %3d anos | Peso: %5.1f kg | Altura: %.2f m | IMC: %5.2f (%s)", 
                nome, getCpf(), idade, peso, altura, calcularImc(), classificarImc());
    }
}

public class CadastroPessoa {
    private final List<Pessoa> pessoas = new ArrayList<>();

    public void cadastrar(Pessoa p) {
        pessoas.add(p);
        System.out.println("✅ Pessoa cadastrada com sucesso!");
    }

    public void listar() {
        System.out.println("\n👥 PESSOAS CADASTRADAS:");
        if (pessoas.isEmpty()) {
            System.out.println("(Nenhuma pessoa cadastrada)");
            return;
        }
        for (Pessoa p : pessoas) {
            System.out.println(p);
        }
    }

    public static void main(String[] args) {
        CadastroPessoa cadastro = new CadastroPessoa();
        Scanner scanner = new Scanner(System.in);
        
        // Dados iniciais
        cadastro.cadastrar(new Pessoa("João Silva", "123.456.789-00", 35, 78.5, 1.75));
        cadastro.cadastrar(new Pessoa("Maria Souza", "987.654.321-99", 28, 55.2, 1.62));

        boolean executando = true;
        while (executando) {
            System.out.println("\n=== 📝 SISTEMA DE CADASTRO DE PESSOAS ===");
            System.out.println("1. Listar Pessoas");
            System.out.println("2. Cadastrar Nova Pessoa");
            System.out.println("3. Sair");
            System.out.print("Opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        cadastro.listar();
                        break;
                    case 2:
                        System.out.print("Nome completo: ");
                        String nome = scanner.nextLine().trim();
                        System.out.print("CPF (11 dígitos): ");
                        String cpf = scanner.nextLine().trim();
                        System.out.print("Idade: ");
                        int idade = Integer.parseInt(scanner.nextLine().trim());
                        System.out.print("Peso (kg): ");
                        double peso = Double.parseDouble(scanner.nextLine().trim());
                        System.out.print("Altura (m): ");
                        double altura = Double.parseDouble(scanner.nextLine().trim());
                        
                        Pessoa novaPessoa = new Pessoa(nome, cpf, idade, peso, altura);
                        cadastro.cadastrar(novaPessoa);
                        break;
                    case 3:
                        executando = false;
                        System.out.println("Fechando cadastro. 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Erro de formato! Digite valores numéricos válidos para Idade, Peso e Altura.");
            } catch (IllegalArgumentException e) {
                System.out.println("❌ Erro de validação: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("❌ Ocorreu um erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
