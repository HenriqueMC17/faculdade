package exercicios;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

class Eletrodomestico {
    private String nome;
    private double potenciaWatts;
    private double horasPorDia;
    private int diasPorMes;

    public Eletrodomestico(String nome, double potenciaWatts, double horasPorDia, int diasPorMes) {
        if (nome == null || nome.trim().isEmpty()) {
            throw new IllegalArgumentException("O nome do aparelho não pode ser vazio.");
        }
        if (potenciaWatts <= 0 || horasPorDia < 0 || horasPorDia > 24 || diasPorMes < 0 || diasPorMes > 31) {
            throw new IllegalArgumentException("Valores de potência, horas (0-24) ou dias (0-31) são inválidos.");
        }
        this.nome = nome;
        this.potenciaWatts = potenciaWatts;
        this.horasPorDia = horasPorDia;
        this.diasPorMes = diasPorMes;
    }

    public String getNome() { return nome; }

    public double calcularConsumoMensalKwh() {
        // Consumo (kWh) = (Potência (W) * Horas de uso por dia * Dias de uso no mês) / 1000
        return (potenciaWatts * horasPorDia * diasPorMes) / 1000.0;
    }

    public double calcularCustoMensal(double valorKwh) {
        return calcularConsumoMensalKwh() * valorKwh;
    }

    @Override
    public String toString() {
        return String.format("%-18s | Potência: %6.1f W | Uso: %4.1f h/dia (%2d dias)", 
                nome, potenciaWatts, horasPorDia, diasPorMes);
    }
}

public class CalculadoraEnergia {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<Eletrodomestico> aparelhos = new ArrayList<>();

        System.out.println("⚡ CALCULADORA DE CONSUMO E CUSTO DE ENERGIA ⚡");
        
        System.out.print("Digite o custo do kWh na sua região (Ex: 0,85 ou 0.85): ");
        double valorKwh = 0.85;
        try {
            valorKwh = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
            if (valorKwh <= 0) {
                System.out.println("⚠️ Custo inválido! Usando valor padrão de R$ 0.85/kWh.");
                valorKwh = 0.85;
            }
        } catch (NumberFormatException e) {
            System.out.println("⚠️ Formato inválido! Usando valor padrão de R$ 0.85/kWh.");
        }

        // Adiciona alguns aparelhos de teste por padrão
        try {
            aparelhos.add(new Eletrodomestico("Ar Condicionado", 1500, 8, 30));
            aparelhos.add(new Eletrodomestico("Geladeira", 200, 24, 30));
            aparelhos.add(new Eletrodomestico("Chuveiro Elétrico", 5500, 0.5, 30));
        } catch (Exception ignored) {}

        boolean rodando = true;
        while (rodando) {
            System.out.println("\n=== ⚡ MENU DE OPÇÕES ===");
            System.out.println("1. Listar e calcular consumo dos aparelhos");
            System.out.println("2. Adicionar novo aparelho");
            System.out.println("3. Mudar valor da tarifa (kWh)");
            System.out.println("4. Sair");
            System.out.print("Escolha uma opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        System.out.println("\n=========================================================================");
                        System.out.println("📋 CONSUMO DETALHADO DOS ELETRODOMÉSTICOS (Tarifa: R$ " + String.format("%.2f", valorKwh) + "/kWh)");
                        System.out.println("=========================================================================");
                        double consumoTotal = 0;
                        double custoTotal = 0;
                        for (Eletrodomestico e : aparelhos) {
                            double consumo = e.calcularConsumoMensalKwh();
                            double custo = e.calcularCustoMensal(valorKwh);
                            consumoTotal += consumo;
                            custoTotal += custo;
                            System.out.println(e + String.format(" -> Consumo: %7.2f kWh | Custo: R$ %6.2f", consumo, custo));
                        }
                        System.out.println("-------------------------------------------------------------------------");
                        System.out.printf("TOTAL GERAL MENSAL: %8.2f kWh | Custo Estimado: R$ %6.2f\n", consumoTotal, custoTotal);
                        System.out.println("=========================================================================");
                        break;
                    case 2:
                        System.out.print("Nome do aparelho: ");
                        String nome = scanner.nextLine().trim();
                        System.out.print("Potência em Watts (Ex: 1200): ");
                        double pot = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        System.out.print("Horas de uso por dia (0 a 24): ");
                        double horas = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        System.out.print("Dias de uso no mês (0 a 30): ");
                        int dias = Integer.parseInt(scanner.nextLine().trim());
                        
                        Eletrodomestico novo = new Eletrodomestico(nome, pot, horas, dias);
                        aparelhos.add(novo);
                        System.out.println("✅ Aparelho \"" + nome + "\" adicionado.");
                        break;
                    case 3:
                        System.out.print("Nova tarifa do kWh (R$): ");
                        double novaTarifa = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        if (novaTarifa > 0) {
                            valorKwh = novaTarifa;
                            System.out.println("✅ Tarifa atualizada para R$ " + String.format("%.2f", valorKwh) + "/kWh.");
                        } else {
                            System.out.println("❌ Tarifa inválida!");
                        }
                        break;
                    case 4:
                        rodando = false;
                        System.out.println("Fechando calculadora de energia. 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Entrada inválida! Digite números corretos.");
            } catch (IllegalArgumentException e) {
                System.out.println("❌ Erro de validação: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("❌ Ocorreu um erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
